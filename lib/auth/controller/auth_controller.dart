import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_user_ios/api/remoteServices.dart';
import 'package:gym_user_ios/ui/main/main_page.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../global/function/global_function.dart';
import '../../global/function/onesignal/init.dart';
import '../../global/function/secure.dart';
import '../../ui/intro/controller/splash_controller.dart';
import '../../ui/user/register/controller/signup_controller.dart';
import '../../ui/user/register/userInfo/user_info_page_01.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  goToMain(String uid) async {
    SplashController sc = Get.find();
    sc.userUid(uid);

    await storage.write(key: "uid", value: uid);
    await oneSignalSetting();
    await sc.getUserInfo(uid);
    await sc.getSplash(uid);
    await sc.getUserAppBanner(uid);

    await sc.getFeedList();

    Get.offAll(MainPage());
  }

  void signInWithNaver() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    print('네이버 로그인 결과 ${res.toString()}');
    if (res.account.id.isNotEmpty) {
      socialLoginCheck(res.account.id.toString(), 1);
      // FlutterNaverLogin.logOut();
    } else {
      //todo: 로그인 실패시 처리
      // Get.back();
    }
  }

  Future<void> signInWithGoogle() async {
    print('구글 로그인 ');

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    //todo 여기서 가입한 유저인지 확인 필요
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print(
        'google userCredential ${userCredential.additionalUserInfo.isNewUser.toString()}');
    print('google userCredential ${userCredential.user.uid}');

    await GoogleSignIn().signOut();
    if (userCredential.user.uid.isNotEmpty) {
      socialLoginCheck(userCredential.user.uid.toString(), 2);
    } else {
      //todo: 로그인 실패시 처리
    }
  }

  void signInWithKakao() async {
    print('카카오 로그인 ');

    try {
      final installed = await kakao.isKakaoTalkInstalled();
      print('카카오 설치 확인 $installed');

      installed
          ? await kakao.UserApi.instance.loginWithKakaoTalk()
          : await kakao.UserApi.instance.loginWithKakaoAccount();
    } catch (e) {
      print('카카오 로그인 실패(sdk열기 실패)   $e');
    }

    try {
      print('카카오 로그인 확인  ');
      kakao.User user = await kakao.UserApi.instance.me();
      print('카카오 로그인 성공  ${user.toString()}');
      if (user.id.toString().isNotEmpty) {
        print("KAKAO :: " + user.id.toString());
        socialLoginCheck(user.id.toString(), 3);
      } else {
        //todo: 로그인 실패시 처리
        showBotToast(
            "로그인 오류가 발생했습니다.", Colors.black, Alignment.bottomCenter, 1);
      }
    } on kakao.KakaoAuthException catch (e) {
      print('카카오 로그인 실패(인증 실패) $e');
    } catch (e) {
      print('카카오 로그인 실패(기타 실패) $e');
    }
  }

  signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final authResult =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    print("CHCHCHCH ::  " + authResult.user.uid.toString());
    socialLoginCheck(authResult.user.uid.toString(), 4);

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  }

  void socialLoginCheck(String socialCode, int socialType) async {
    print('socialLoginCheck ');

    // // 이 이메일로 가입을 한 사람이 있나 확인

    var data = {"socialType": socialType, "code": socialCode};
    var result = await RemoteServices.checkSnsLoginUser(data);

    //2. 없으면 회원가입
    if (result.resultCode == 700) {
      print('로그인 성공 ');

      goToMain(result.user.user.uid.toString());
      // //1. 있으면 로그인
      // utils.saveRefreshToken(result.refreshToken);
      // utils.saveAccessToken(result.accessToken);
      // print(utils.loadAccessToken().toString());
      // print(utils.loadRefreshToken().toString());
      // Get.offAllNamed(Routes.homeMainRoute);
      // editControllerDispose();
    } else {
      SignupController sc = Get.put(SignupController(socialType, socialCode));
      Get.to(Get.to(UserInfoPage01()));

      // print('회원가입으로 ');
      // print('socialLoginCheck socialType  $socialType  ');
      // print('socialLoginCheck socialCode  $socialCode  ');

      // //2. 없으면 회원가입
      // Get.toNamed(Routes.signupOneRoute, arguments: {
      //   'signupType': 1,
      //   'socialType': socialType,
      //   'socialCode': socialCode
      // });
    }
  }
}
