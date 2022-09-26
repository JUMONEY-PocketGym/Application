import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_user_ios/api/remoteServices.dart';
import 'package:gym_user_ios/global/function/global_function.dart';
import 'package:gym_user_ios/ui/intro/controller/splash_controller.dart';
import 'package:iamport_flutter/iamport_certification.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iamport_flutter/model/certification_data.dart';
// import 'package:iamport_flutter/model/certification_data.dart';

class PhoneCertPage extends StatelessWidget {
  SplashController sc = Get.find();
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      /* 웹뷰 로딩 컴포넌트 */
      appBar: null,
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo/splash_logo.png',
                width: 100.w,
                height: 100.h,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp49730761',
      /* [필수입력] 본인인증 데이터 */
      /// 그냥 라이브러리에는 CertificationData.fromJson 가 존재하지 않는다.
      ///  만들어야 하는 부분
      ///

      data: CertificationData(
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
          company: '',
          carrier: '',
          name: "",
          // 'name': sc.userProfileInfo.value.name,
          phone: '',
          minAge: 14),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) async {
        print('폰인증 정보  $result');
        // if (pageType == 1) {
        //   // 핸드폰 번호 변경
        //   Get.back(result: result);
        // } else {
        //   ///회원가입
        //   _signupController.phoneCert(result);
        // }
        await getPhoneInfo(result);
      },
    );
  }

  getPhoneInfo(Map<String, dynamic> data) async {
    if (data['success'] != 'true') {
      showBotToast("핸드폰 인증에 실패했습니다.", Colors.black, Alignment.bottomCenter, 1);
      return;
    }
    var result = await RemoteServices.getCertificationPhone();

    var getinfo = await RemoteServices.getCertificationPhoneInfo(
        data['imp_uid'], jsonDecode(result)['response']['access_token']);

    if (jsonDecode(getinfo)['code'] < 0) {
      print('phoneCert  핸드폰 인증 실패 ${data.toString()}');
      showBotToast("핸드폰 인증에 실패했습니다.", Colors.black, Alignment.bottomCenter, 1);
      return;
    }

    print('getPhoneInfo data: ${jsonDecode(getinfo)['response']['name']}');
    print('getPhoneInfo data: ${jsonDecode(getinfo)['response']['gender']}');
    print('getPhoneInfo data: ${jsonDecode(getinfo)['response']['birthday']}');
    print(
        'getPhoneInfo data: ${jsonDecode(getinfo)['response']['unique_key']}');
    print(
        'getPhoneInfo data: ${jsonDecode(getinfo)['response']['unique_in_site']}');
    print('getPhoneInfo data: ${jsonDecode(getinfo)['response']['foreigner']}');
    print('getPhoneInfo phoneNum: ${jsonDecode(getinfo)['response']['phone']}');

    sc.userProfileInfo.value.userProfile.phoneNumber =
        jsonDecode(getinfo)['response']['phone'];
    sc.userProfileInfo.refresh();

    var phoneData = {"phoneNumber": jsonDecode(getinfo)['response']['phone']};
    var infoResult = await RemoteServices.updateUser(phoneData);

    print(jsonEncode(infoResult));

    Get.back(result: true);

    // return jsonDecode(getinfo)['response'];
  }

  /// CertificationData.fromJson 가 오류 나면  iamport_flutter라이브러리 CertificationData 클래스에 붙여넣기
  // factory CertificationData.fromJson(Map<String, dynamic> json) => CertificationData(
  //   merchantUid: json["merchantUid"],
  //   company: json["company"],
  //   carrier: json["carrier"],
  //   name: json["name"],
  //   phone: json["phone"],
  //   minAge: json["minAge"],
  // );

}
