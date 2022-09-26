import 'dart:convert';
import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_user_ios/global/function/global_function.dart';
import 'package:gym_user_ios/global/function/imageUpload/image_upload.dart';
import 'package:gym_user_ios/ui/intro/controller/splash_controller.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/gym_like_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/search_gym_detail_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/search_gym_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/search_trainer_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/trainer_detail_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/searchTrainerGym/model/trainer_like_response.dart';
import 'package:gym_user_ios/ui/main/pages/page01/wishList/model/wish_list_response.dart';
import 'package:gym_user_ios/ui/main/pages/page02/model/feed_list_data_response.dart';
import 'package:gym_user_ios/ui/main/pages/page02/model/feed_list_response.dart';
import 'package:gym_user_ios/ui/main/pages/page04/model/records_list_response.dart';
import 'package:gym_user_ios/ui/user/login/model/app_banner_response.dart';
import 'package:gym_user_ios/ui/user/login/model/login_response.dart';
import 'package:gym_user_ios/ui/user/login/model/user_profile_info.dart';
import 'package:gym_user_ios/ui/user/login/pages/model/find_email_response.dart';
import 'package:gym_user_ios/ui/user/login/pages/model/find_password_response.dart';
import 'package:gym_user_ios/ui/user/model/refresh_token_model.dart';
import 'package:gym_user_ios/ui/user/model/renewal_access_token_response.dart';
import 'package:gym_user_ios/ui/user/register/userInfo/model/search_poligons_response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';
// import 'package:video_manipulation/video_manipulation.dart';

import '../auth/model/auth_sns_user_check_response.dart';
import '../ui/main/pages/page01/betting/model/betting_payment_result_response.dart';
import '../ui/main/pages/page01/betting/model/betting_recruiting_list_response.dart';
import '../ui/main/pages/page01/betting/model/betting_recruting_detail_response.dart';
import '../ui/main/pages/page01/betting/pages/detail_pages/media_upload/model/upload_result_response.dart';
import '../ui/main/pages/page01/notification/model/notification_list_response.dart';
import '../ui/main/pages/page01/searchTrainerGym/pages/model/offline_check_response.dart';
import '../ui/main/pages/page01/searchTrainerGym/pages/pages/model/online_trainer_curriculum_list_response.dart';
import '../ui/main/pages/page01/searchTrainerGym/pages/pages/quest/model/quest_detail_response.dart';
import '../ui/main/pages/page02/pages/model/feed_detail_response.dart';
import '../ui/main/pages/page03/model/quest_list_response.dart';
import '../ui/main/pages/page03/pages/model/home_training_list_response.dart';
import '../ui/main/pages/page05/model/permit_response.dart';
import '../ui/main/pages/page05/pages/actPages/model/point_list_response.dart';
import '../ui/main/pages/page05/pages/actPages/pages/model/inapp_list_response.dart';
import '../ui/main/pages/page05/pages/coupon/model/coupon_list_response.dart';
import '../ui/main/pages/page05/pages/cs/csQBodyPages/model/question_list_response.dart';
import '../ui/main/pages/page05/pages/curriCulum/model/betting_payment_receipt_response.dart';
import '../ui/main/pages/page05/pages/curriCulum/model/curriculum_payment_receipt_response.dart';
import '../ui/main/pages/page05/pages/faqPage/model/faq_list_response.dart';
import '../ui/main/pages/page05/pages/notice/model/notice_list_response.dart';
import '../ui/main/pages/page05/pages/policy/model/terms_response.dart';
import '../ui/main/pages/page05/pages/review/model/review_list_response.dart';
import '../ui/user/register/model/email_check_result_response.dart';
import '../ui/user/register/userInfo/model/invite_check_user_result_response.dart';
import '../ui/user/register/userInfo/model/register_response.dart';
import 'apiVal.dart';
import 'model/error_response.dart';
import 'model/splash_response.dart';

var phoneCertUrl = 'https://api.iamport.kr/';

class RemoteServices {
  static var client = http.Client();

  // 회원가입
  static Future<RegisterResponse> registerUser(var data) async {
    String apiUrlPath = apiURL + "users/register";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("registerUser :: " + result);
    return response.statusCode < 400 ? registerResponseFromJson(result) : null;
  }

  static exchangeToPPT(var data) async {
    print(jsonEncode(data));

    String apiUrlPath = apiURL + "point/exchangeToken";
    SplashController sc = Get.find();
    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("exchangeToPPT :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  static exchangeToKRW(var data) async {
    print(jsonEncode(data));

    String apiUrlPath = apiURL + "point/exchangeKRW";
    SplashController sc = Get.find();
    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("exchangeToKRW :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  static createPptWallet() async {
    String apiUrlPath = apiURL + "create-ppt-wallet";
    SplashController sc = Get.find();
    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.post(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("createPptWallet :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  static completeInapp(var data) async {
    String apiUrlPath = apiURL + "payment/complete-inapp";

    SplashController sc = Get.find();
    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    print(jsonEncode(data));
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("completeInapp :: " + result);
    return response.statusCode < 400 ? true : false;
  }

  // 회원정보 수정
  static updateUser(var data) async {
    String apiUrlPath = apiURL + "users/update-profile";

    SplashController sc = Get.find();

    print(jsonEncode(data));

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };
    var response = await client.put(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("updateUser :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // Feed detail
  static Future<FeedDetailResponse> getFeedDetail(String feedUid) async {
    String apiUrlPath = apiURL + "feeds/detail/$feedUid";

    SplashController sc = Get.find();

    var header = {"uid": sc.userUid.value.toString()};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getFeedDetail :: " + result);
    return response.statusCode < 400
        ? feedDetailResponseFromJson(result)
        : null;
  }

  // Sns 로그인시 회원가입여부 확인
  static Future<AuthSnsUserCheckResponse> checkSnsLoginUser(var data) async {
    String apiUrlPath = apiURL + "auth/social/check";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("checkSnsLoginUser :: " + result);
    return response.statusCode < 400
        ? authSnsUserCheckResponseFromJson(result)
        : null;
  }

  static Future<String> imageUpload(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    File file = await pickProfilePicture(source);
    File decompressImage = await compressToJpeg(file);
    String fileExtension = decompressImage.path.split(".").last;
    List<int> imageBytes = decompressImage.readAsBytesSync();

    String base64File = base64Encode(imageBytes);

    String apiUrlPath = "http://cubelean.com:8888/api/v1/s3/upload";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode({
          "data": [base64File],
          "extension": [fileExtension],
          "thumbnail": false,
        }),
        headers: header);

    // var result = response.body;

    var result = jsonDecode(response.body);
    // print(jsonEncode(result));

    print(result[0]);

    return response.statusCode < 400 ? result[0] : null;
  }

  // 비디오 업로드
  static Future<String> videoUpload(ImageSource source) async {
    PickedFile picker = await ImagePicker().getVideo(source: source);
    File video = File(picker.path);

    List<File> compressedfiles = [];
    List<String> base64Strings = [];
    // List<String> filenameList = [];
    List<String> fileExtension = [];

    MediaInfo info = await VideoCompress.compressVideo(
      video.path,
      quality: VideoQuality.HighestQuality,
      deleteOrigin: false,
    );

    var originalVideoPath = info.file.path;
    var targetVideoPath = info.file.path.replaceAll(".mp4", "_edited.mp4");

    FFmpegKit.execute(
            '-i ${originalVideoPath} -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2[a]" -map "[v]" -map "[a]" ${targetVideoPath}')
        .then((session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        // SUCCESS
        print("SUCCESS");

        MediaInfo info = await VideoCompress.compressVideo(
          targetVideoPath,
          quality: VideoQuality.DefaultQuality,
          includeAudio: false,
          deleteOrigin: false,
        );

        compressedfiles.add(info.file);

        for (var i = 0; i < compressedfiles.length; i++) {
          base64Strings.add(
              base64Encode(compressedfiles.elementAt(i).readAsBytesSync()));
          fileExtension.add("mp4");
        }

        String apiUrlPath = "http://cubelean.com:8888/api/v1/s3/upload";

        var header = {
          "Content-Type": "application/json",
        };
        var response = await client.post(Uri.parse(apiUrlPath),
            body: jsonEncode({
              "data": [base64Strings],
              "extension": [fileExtension],
              "thumbnail": false,
            }),
            headers: header);

        var result = jsonDecode(response.body);
        print(result[0]);
        return response.statusCode < 400 ? result[0] : null;
      } else if (ReturnCode.isCancel(returnCode)) {
        // CANCEL
        print("CANCEL");
        return null;
      } else {
        // ERROR
        print("ERROR");
        return null;
      }
    });
  }

  // betting 결제

  static Future<BettingPaymentResultResponse> bettingPayment(var data) async {
    SplashController sc = Get.find();
    String apiUrlPath = apiURL + "payment/betting";

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("bettingPayment Response :: " + result);
    return response.statusCode < 400
        ? bettingPaymentResultResponseFromJson(result)
        : null;
  }

  // 운동 영상 기록
  static homeSessionRecord(var data) async {
    SplashController sc = Get.find();
    String apiUrlPath = apiURL + "curriculum/home-session-record";

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    print(jsonEncode(data));

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("homeSessionRecord Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // 운동 퀘스트 결제
  static Future<BettingPaymentResultResponse> curriculumPayment(
      var data) async {
    SplashController sc = Get.find();
    String apiUrlPath = apiURL + "payment/curriculum";

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("renewalAccessToken Response :: " + result);
    return response.statusCode < 400
        ? bettingPaymentResultResponseFromJson(result)
        : null;
  }

  // 베팅 기록
  static Future<BettingRecordImageUploadResponse> bettingRecord(
      var data) async {
    SplashController sc = Get.find();

    String apiUrlPath = apiURL + "betting/record-certification";

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.post(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(data));

    var result = response.body;

    print("bettingRecord Response :: " + result);
    return response.statusCode < 400
        ? bettingRecordImageUploadResponseFromJson(result)
        : null;
  }

  // 베팅 기록 수정
  static Future<BettingRecordImageUploadResponse> modifyBettingRecord(
      var data) async {
    SplashController sc = Get.find();

    String apiUrlPath = apiURL + "betting/record-certification-edit";

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.put(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(data));

    var result = response.body;

    print("bettingRecord Response :: " + result);
    return response.statusCode < 400
        ? bettingRecordImageUploadResponseFromJson(result)
        : null;
  }

  // renewal access token
  static Future<RenewalAccessTokenResponse> renewalAccessToken(
      RefreshTokenModel data) async {
    String apiUrlPath = apiURL + "auth/user/renewalToken";

    var header = {
      "Content-Type": "application/json",
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: data.toJson(), headers: header);

    var result = response.body;

    print("renewalAccessToken Response :: " + result);
    return response.statusCode < 400
        ? renewalAccessTokenResponseFromJson(result)
        : null;
  }

  // certification phone

  static getCertificationPhone() async {
    String apiUrlPath = phoneCertUrl + "users/getToken";

    var header = {
      "Content-Type": "application/json",
    };

    var body = {
      "imp_key": "7417784262382793",
      "imp_secret":
          "f35f26595fc870d33ce2cdafa835de5ee51682b753df5e82606d27a9cf1485bf68f6c4b616df7cef"
    };
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(body), headers: header);

    var result = response.body;

    print("getCertificationPhoneInfo Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  // certification phone info
  static getCertificationPhoneInfo(String uid, String accessToken) async {
    String apiUrlPath = phoneCertUrl + "certifications/$uid";

    var header = {
      "Content-Type": "application/json",
      'Authorization': accessToken
    };

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCertificationPhoneInfo Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  // check offline pt user
  static Future<OfflineCheckResponse> getCheckOfflineUser(
      int uid, int trainerUid) async {
    String apiUrlPath = apiURL + "trainers/request-curriculum";

    var header = {
      "Content-Type": "application/json",
    };

    var body = {"userUid": uid, "trainerUid": trainerUid};

    var response = await client.post(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(body));

    var result = response.body;

    print("getCheckOfflineUser Response :: " + result);
    return response.statusCode < 400
        ? offlineCheckResponseFromJson(result)
        : null;
  }

  // 약관
  static Future<TermsResponse> getTerms() async {
    String apiUrlPath = apiURL + "terms";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("getTerms Response :: " + apiUrlPath);
    print("getTerms Response :: " + result);
    return response.statusCode < 400 ? termsResponseFromJson(result) : null;
  }

  // 인앱 상품 목록
  static Future<List<InAppListResponse>> getInAppList(String type) async {
    String apiUrlPath = apiURL + "payment/inapp-product/$type";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("getInAppList Response :: " + apiUrlPath);
    print("getInAppList Response :: " + result);
    return response.statusCode < 400 ? inAppListResponseFromJson(result) : null;
  }

  // Check Email
  static Future<EmailCheckResultResponse> checkEmail(String email) async {
    String apiUrlPath = apiURL + "users/check/email/$email";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkEmail Response :: " + apiUrlPath);
    print("checkEmail Response :: " + result);
    return response.statusCode < 400
        ? emailCheckResultResponseFromJson(result)
        : null;
  }

  // Check NickName
  static Future<EmailCheckResultResponse> checkNickName(String nickName) async {
    String apiUrlPath = apiURL + "users/check/nickname/$nickName";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkNickName Response :: " + apiUrlPath);
    print("checkNickName Response :: " + result);
    return response.statusCode < 400
        ? emailCheckResultResponseFromJson(result)
        : null;
  }

  // Check Invite user
  static Future<InviteCheckUserResultResponse> checkInviteUser(
      String type, String keyword) async {
    String apiUrlPath;

    if (type == "user") {
      apiUrlPath = apiURL + "users/validate-nickname/$keyword";
    } else {
      apiUrlPath = apiURL + "trainers/validate-name/$keyword";
    }

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("checkInviteUser Response :: " + apiUrlPath);
    print("checkInviteUser Response :: " + result);
    return response.statusCode < 400
        ? inviteCheckUserResultResponseFromJson(result)
        : null;
  }

  // coupon list
  static Future<List<CouponListResponse>> getCouponList(
      String uid, String trainerUid, String type) async {
    String apiUrlPath = apiURL + "coupons?type=$type&trainerUid=$trainerUid";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCouponList Response :: " + apiUrlPath);
    print("getCouponList Response :: " + result);
    return response.statusCode < 400
        ? couponListResponseFromJson(result)
        : null;
  }

  // 나의 문의내역
  static Future<List<QuestionListResponse>> getQuestionList(String uid) async {
    String apiUrlPath = apiURL + "other/question";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getQuestionList Response :: " + apiUrlPath);
    print("getQuestionList Response :: " + result);
    return response.statusCode < 400
        ? questionListResponseFromJson(result)
        : null;
  }

  // 별점 및 후기 리스트
  static Future<List<ReviewListResponse>> getReviewList(String uid) async {
    String apiUrlPath = apiURL + "other/review-list";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getReviewList Response :: " + apiUrlPath);
    print("getReviewList Response :: " + result);
    return response.statusCode < 400
        ? reviewListResponseFromJson(result)
        : null;
  }

  // 공지사항 목록
  static Future<List<NoticeListResponse>> getNoticeList(String uid) async {
    String apiUrlPath = apiURL + "notices";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getNoticeList Response :: " + apiUrlPath);
    print("getNoticeList Response :: " + result);
    return response.statusCode < 400
        ? noticeListResponseFromJson(result)
        : null;
  }

  // 자주 묻는 질문
  static Future<List<FaQListResponse>> getFaQList(String uid) async {
    String apiUrlPath = apiURL + "other/faq";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getFaQList Response :: " + apiUrlPath);
    print("getFaQList Response :: " + result);
    return response.statusCode < 400 ? faQListResponseFromJson(result) : null;
  }

// 후기 작성
  static sendReview(var data) async {
    String apiUrlPath = apiURL + "other/write-review";
    SplashController sc = Get.find();
    var header = {
      "uid": sc.userUid.value.toString(),
      "Content-Type": "application/json",
    };

    var response = await client.put(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(data));

    var result = response.body;

    print("sendReview Response :: " + apiUrlPath);
    print("sendReview Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // 알림 리스트
  static Future<List<NotificationListResponse>> getNotificationList(
      String uid) async {
    String apiUrlPath = apiURL + "push-message/user-history";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getNotificationList Response :: " + apiUrlPath);
    print("getNotificationList Response :: " + result);
    return response.statusCode < 400
        ? notificationListResponseFromJson(result)
        : null;
  }

  // point list
  static Future<List<PointListResponse>> getPointList(String uid) async {
    String apiUrlPath = apiURL + "point/fitpoint/record-list";
    // String apiUrlPath =
    //     apiURL + "point/fitpoint/record?recordType=0&pointType=0";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getPointList Response :: " + apiUrlPath);
    print("getPointList Response :: " + result);
    return response.statusCode < 400 ? pointListResponseFromJson(result) : null;
  }

  // 모집중 베팅 리스트
  static Future<List<BettingRecruitingListResponse>> getRecruitingBetting(
      String uid) async {
    String apiUrlPath = apiURL + "betting/recruiting/all";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecruitingBetting Response :: " + apiUrlPath);
    print("getRecruitingBetting Response :: " + result);
    return response.statusCode < 400
        ? bettingRecruitingListResponseFromJson(result)
        : null;
  }

  // 운동 퀘스트 목록
  static Future<List<QuestListResponse>> getQuestList(String uid) async {
    String apiUrlPath = apiURL + "curriculum/ing";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecruitingBettingDetail Response :: " + result);
    return response.statusCode < 400 ? questListResponseFromJson(result) : null;
  }

  // 홈 트레이닝 리스트
  static Future<List<HomeTrainingListResponse>> getHomeTrainingList(
      String uid, String questUid) async {
    String apiUrlPath = apiURL + "curriculum/exercise/$questUid";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getHomeTrainingList Response :: " + result);
    return response.statusCode < 400
        ? homeTrainingListResponseFromJson(result)
        : null;
  }

  // 모집중 베팅 상세 페이지
  static Future<BettingRecrutingDetailResponse> getRecruitingBettingDetail(
      String uid, String bettingUid) async {
    String apiUrlPath = apiURL + "betting/detail/$bettingUid";

    print("hanshem_check :: " + apiUrlPath);

    var header = {"uid": uid};

    print("hanshem_check :: " + uid);

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecruitingBettingDetail Response :: " + result);
    return response.statusCode < 400
        ? bettingRecrutingDetailResponseFromJson(result)
        : null;
  }

  // 참여중 베팅 리스트
  static Future<List<BettingRecruitingListResponse>> getParticipationBetting(
      String uid) async {
    String apiUrlPath = apiURL + "betting/participating/all";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getParticipationBetting Response :: " + result);
    return response.statusCode < 400
        ? bettingRecruitingListResponseFromJson(result)
        : null;
  }

  // 완료 베팅 리스트
  static Future<List<BettingRecruitingListResponse>> getDoneBetting(
      String uid) async {
    String apiUrlPath = apiURL + "betting/done/all";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getDoneBetting Response :: " + result);
    return response.statusCode < 400
        ? bettingRecruitingListResponseFromJson(result)
        : null;
  }

  // update phone info
  static updatePhoneInfo(String uid, dynamic phoneCertInfo) async {
    String apiUrlPath = apiURL + "users/profile/phoneInfo";

    var header = {"Content-Type": "application/json", "uid": uid};

    var response = await client.patch(Uri.parse(apiUrlPath),
        body: jsonEncode(phoneCertInfo), headers: header);

    var result = response.body;

    print("updatePhoneInfo Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  // 내 기록 트레이너에게 공개
  static Future<PermitResponse> updateRecordSharePermit(String uid) async {
    String apiUrlPath = apiURL + "records/permission-toggle";

    var header = {"Content-Type": "application/json", "uid": uid};

    var response = await client.patch(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("updateRecordSharePermit Response :: " + result);
    return response.statusCode < 400 ? permitResponseFromJson(result) : null;
  }

  // 위시리스트 삭제
  static deleteWishList(int wishListType, dynamic data) async {
    String apiUrlPath = apiURL + "users/wishList/$wishListType";

    SplashController sc = Get.find();

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.patch(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(data));

    var result = response.body;

    print("deleteWishList Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // feed like
  static feedLike(int feedUid, bool state) async {
    String apiUrlPath = apiURL + "feeds/like";

    SplashController sc = Get.find();

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var bodyData = {"feedUid": feedUid, "state": state ? 1 : 0};

    var response = await client.patch(Uri.parse(apiUrlPath),
        headers: header, body: jsonEncode(bodyData));

    var result = response.body;

    print("feedLike Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // delete record
  static deleteRecord(String recordUid) async {
    String apiUrlPath = apiURL + "users/record/$recordUid";

    SplashController sc = Get.find();

    var header = {
      "Content-Type": "application/json",
      "uid": sc.userUid.value.toString()
    };

    var response = await client.delete(
      Uri.parse(apiUrlPath),
      headers: header,
    );

    var result = response.body;

    print("deleteRecord Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  // login

  static Future<LoginResponse> login(String email, String password) async {
    String apiUrlPath = apiURL + "auth/user/login";

    var header = {
      "Content-Type": "application/json",
    };

    var data = jsonEncode({"email": email, "password": password});
    var response =
        await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

    var result = response.body;

    print("login Response :: " + result);

    if (response.statusCode >= 400) {
      ErrorResponse ev = ErrorResponse.fromJson(jsonDecode(result));
      showBotToast(ev.message, Colors.black, Alignment.bottomCenter, 1);
    }

    return response.statusCode < 400 ? loginResponseFromJson(result) : null;
  }

// 문의하기

  static questionSubmit(String uid, var data) async {
    String apiUrlPath = apiURL + "other/customerInquiry";

    var header = {"Content-Type": "application/json", "uid": uid};

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("questionSubmit Response :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  // 이메일 찾기
  static Future<FindEmailResponse> findEmail(var data) async {
    String apiUrlPath = apiURL + "users/find-email";

    var header = {"Content-Type": "application/json"};

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("findEmail Response :: " + result);

    return findEmailResponseFromJson(result);
  }

  // 비밀번호 찾기
  static Future<FindPasswordResponse> findPassword(var data) async {
    String apiUrlPath = apiURL + "users/find-password";

    var header = {"Content-Type": "application/json"};

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("findPassword Response :: " + result);

    return findPasswordResponseFromJson(result);
  }

  // applyOfflineDiagnostics

  static applyOfflineDiagnostics(String uid, dynamic data) async {
    String apiUrlPath = apiURL + "trainers/phonecounseling";

    print("UID::" + uid);

    var header = {"Content-Type": "application/json", "uid": uid};

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("applyOfflineDiagnostics Response :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  static submitDiagnosisResult(dynamic data, String uid) async {
    String apiUrlPath = apiURL + "diagnostic/answer";

    var header = {"Content-Type": "application/json", "uid": uid};

    print(jsonEncode(data));

    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("diagnostic Response :: " + result);

    return response.statusCode < 400 ? true : null;
  }

  // User profile info
  static Future<UserProfileInfoResponse> getUserProfileInfo(String uid) async {
    String apiUrlPath = apiURL + "users/profile";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("UserProfileInfo Response :: " + result);
    return response.statusCode < 400
        ? userProfileInfoResponseFromJson(result)
        : null;
  }

  // get splash data
  static Future<SplashDataResponse> getSplashData(String uid) async {
    String apiUrlPath = apiURL + "splash";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getSplashData Response :: " + result);
    return response.statusCode < 400
        ? splashDataResponseFromJson(result)
        : null;
  }

  // 운동 퀘스트 구매내역 상세
  static Future<CurriCulumPaymentReceiptModel>
      getCurriculumPaymentReceiptDetail(int paymentUid) async {
    String apiUrlPath = apiURL + "payment/receipt/1/$paymentUid";
    SplashController sc = Get.find();
    var header = {"uid": sc.userUid.toString()};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getCurriculumPaymentReceiptDetail Response :: " + result);
    return response.statusCode < 400
        ? curriCulumPaymentReceiptModelFromJson(result)
        : null;
  }

  // 미션 퀘스트 구매내역 상세
  static Future<BettingPaymentReceiptModel> getBettingPaymentReceiptDetail(
      int paymentUid) async {
    String apiUrlPath = apiURL + "payment/receipt/2/$paymentUid";
    SplashController sc = Get.find();
    var header = {"uid": sc.userUid.toString()};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getBettingPaymentReceiptDetail Response :: " + result);
    return response.statusCode < 400
        ? bettingPaymentReceiptModelFromJson(result)
        : null;
  }

  // Online Trainer curriculum list
  static Future<List<OnlineTrainerCurriCulumListResponse>>
      getOnlineTrainerCurriculumList(String trainerUid) async {
    String apiUrlPath = apiURL + "curriculum/trainer/$trainerUid";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("getOnlineTrainerCurriculumList apiUrlPath :: " + apiUrlPath);
    print("getOnlineTrainerCurriculumList Response :: " + result);
    return response.statusCode < 400
        ? onlineTrainerCurriCulumListResponseFromJson(result)
        : null;
  }

  // Qeust Detail page
  static Future<QuestDetailResponse> getQuestDetailInfo(String questUid) async {
    String apiUrlPath = apiURL + "curriculum/detail/$questUid";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;
    print("getOnlineTrainerCurriculumList apiUrlPath :: " + apiUrlPath);
    print("getOnlineTrainerCurriculumList Response :: " + result);
    return response.statusCode < 400
        ? questDetailResponseFromJson(result)
        : null;
  }

  // Search Online Trainer
  static Future<List<SearchTrainerResponse>> searchOnlineTrainer(
      String searchKey) async {
    String apiUrlPath = apiURL + "trainers/online/$searchKey";

    print(apiUrlPath);

    // var header = {"uid": uid};

    var response = await client.get(
      Uri.parse(apiUrlPath),
      // headers: header,
    );

    var result = response.body;

    print("searchOnlineTrainer Response :: " + result);
    return response.statusCode < 400
        ? searchTrainerResponseFromJson(result)
        : null;
  }

  // WishList
  static Future<WishListResponse> getWishList(String uid) async {
    String apiUrlPath = apiURL + "users/wishlist";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("UserProfileInfo Response :: " + result);
    return response.statusCode < 400 ? wishListResponseFromJson(result) : null;
  }

  // feed list data
  static Future<FeedListDataResponse> getFeedListData(
      String uid, String feedUid, String page, String limit) async {
    String apiUrlPath = apiURL + "feeds/list/$feedUid/$page/$limit";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getFeedListData Response :: " + apiUrlPath);
    print("getFeedListData Response :: " + result);
    return response.statusCode < 400
        ? feedListDataResponseFromJson(result)
        : null;
  }

  // Feed List
  static Future<List<FeedListResponse>> getFeedList() async {
    String apiUrlPath = apiURL + "feeds/category";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("UserProfileInfo Response :: " + result);
    return response.statusCode < 400 ? feedListResponseFromJson(result) : null;
  }

  // gym like
  static Future<GymLikeResponse> GymLike(
      String gymUid, String uid, String status) async {
    String apiUrlPath = apiURL + "gyms/like/$gymUid/$status";

    print(apiUrlPath);

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("UserProfileInfo Response :: " + result);
    return response.statusCode < 400 ? gymLikeResponseFromJson(result) : null;
  }

  static bettingLike(String bettingUid, String uid, String status) async {
    String apiUrlPath = apiURL + "betting/like/$bettingUid/$status";

    print(apiUrlPath);

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("bettingLike Response :: " + result);
    return response.statusCode < 400 ? true : null;
  }

  static Future<TrainerLikeResponse> TrainerLike(
      String trainerUid, String uid, String status) async {
    String apiUrlPath = apiURL + "trainers/like/$trainerUid/$status";

    print(apiUrlPath);

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("UserProfileInfo Response :: " + result);
    return response.statusCode < 400
        ? trainerLikeResponseFromJson(result)
        : null;
  }

  // search gym
  static Future<SearchGymResponse> searchGym(
      String keyword, String lat, String long) async {
    String apiUrlPath =
        apiURL + "gyms/search?searchWord=$keyword&lat=$lat&long=$long";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("SearchGym Response :: " + result);
    return response.statusCode < 400 ? searchGymResponseFromJson(result) : null;
  }

  // search Trainer
  static Future<List<SearchTrainerResponse>> searchTrainer(
      String keyword, String lat, String long) async {
    String apiUrlPath =
        apiURL + "trainers/search?searchWord=$keyword&lat=$lat&long=$long";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    print("searchTrainer Response :: " + result);
    return response.statusCode < 400
        ? searchTrainerResponseFromJson(result)
        : null;
  }

  // search gym detail
  static Future<SearchGymDetailResponse> getGymDetail(
      String uid, int gymUid) async {
    var header = {"uid": uid};

    String gUid = gymUid.toString();
    String apiUrlPath = apiURL + "gyms/$gUid";

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("SearchGymDetail Response :: " + result);
    return response.statusCode < 400
        ? searchGymDetailResponseFromJson(result)
        : null;
  }

  // search trainer detail
  static Future<TrainerDetailResponse> getTrainerDetail(
      String uid, int trainerUid) async {
    var header = {"uid": uid};

    String tUid = trainerUid.toString();
    String apiUrlPath = apiURL + "trainers/$trainerUid";

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("SearchTrainerDetail Response :: " + result);
    return response.statusCode < 400
        ? trainerDetailResponseFromJson(result)
        : null;
  }

  static Future<List<UserAppBannerResponse>> getUserAppBanner(
      String uid) async {
    String apiUrlPath = apiURL + "other/userAppBanner";

    var header = {"uid": uid};

    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("UserAppBanner Response :: " + result);
    return response.statusCode < 400
        ? userAppBannerResponseFromJson(result)
        : null;
  }

  // 행정구역 리스트 호출
  static Future<SearchPoligonsResponse> getPoligons(String keyword) async {
    // 임시 트레이너 uid = 12;
    String apiUrlPath =
        "http://api.vworld.kr/req/data?service=data&request=GetFeature&data=LT_C_ADEMD_INFO&key=0E074B46-64C3-34AE-9F85-313BAD60C1CE&attrFilter=emd_kor_nm:like:$keyword&geometry=true&attribute=true";

    var response = await client.get(Uri.parse(apiUrlPath));

    var result = response.body;

    // print("poligons Response :: " + result);
    return response.statusCode < 400
        ? searchPoligonsResponseFromJson(result)
        : null;
  }

  // 내 노트 등록
  static recordUpload(String uploadType, String uid, dynamic data) async {
    String apiUrlPath = apiURL + "records/$uploadType";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("recordUpload Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  // 운동기록 등록
  static recordExerciseUpload(String uid, dynamic data) async {
    String apiUrlPath = apiURL + "records/exercise";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.post(Uri.parse(apiUrlPath),
        body: jsonEncode(data), headers: header);

    var result = response.body;

    print("recordExerciseUpload Response :: " + result);
    return response.statusCode < 400 ? result : null;
  }

  static Future<List<RecordsListResponse>> getRecords(
      String uid, String page) async {
    String apiUrlPath = apiURL + "records/list/$page";

    var header = {"Content-Type": "application/json", "uid": uid};
    var response = await client.get(Uri.parse(apiUrlPath), headers: header);

    var result = response.body;

    print("getRecords Response :: " + result);
    return response.statusCode < 400
        ? recordsListResponseFromJson(result)
        : null;
  }

  // // Trainer info
  // static Future<TrainerDetailResponse> getTrainerInfo() async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "trainers/detail/12";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("TrainerInfoResponse :: " + result);
  //   return response.statusCode < 400
  //       ? trainerDetailResponseFromJson(result)
  //       : null;
  // }

  // // Trainer Act list
  // static Future<List<TrainerActListResponse>> getTrainerActList() async {
  //   // 임시 트레이너 uid = 34;
  //   String apiUrlPath = apiURL + "point/trainer-history/34";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("TrainerActListResponse :: " + result);
  //   return response.statusCode < 400
  //       ? trainerActListResponseFromJson(result)
  //       : null;
  // }

  // // 운동종목
  // static Future<List<ExeciseVoiceListResponse>> getExerciseVoice() async {
  //   // 임시 트레이너 uid = 11;
  //   String apiUrlPath = apiURL + "trainers/exercise-voice/11";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("ExerciseVoiceListResponse :: " + result);
  //   return response.statusCode < 400
  //       ? execiseVoiceListResponseFromJson(result)
  //       : null;
  // }

  // // exchange to krw
  // static Future<ExchangeToKrwResponse> exchangeToKrw(var data) async {
  //   String apiUrlPath = apiURL + "point/exchange-to-krw";

  //   var header = {
  //     "Content-Type": "application/json",
  //   };
  //   var response =
  //       await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

  //   var result = response.body;

  //   print("exchangeToKrwResponse :: " + result);
  //   return response.statusCode < 400
  //       ? exchangeToKrwResponseFromJson(result)
  //       : null;
  // }

  // // Trainer intro voice list
  // static Future<List<Intro>> getTrainerIntroVoice() async {
  //   // 임시 트레이너 uid = 7;
  //   String apiUrlPath = apiURL + "trainers/intro-voice/7";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("TrainerIntroVoiceResponse :: " + result);
  //   return response.statusCode < 400
  //       ? trainerIntroVoiceResponseFromJson(result)
  //       : null;
  // }

  // // notice
  // static Future<List<NoticeListResponse>> getNoticeList() async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "notices/trainers";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("NoticeListResponse :: " + result);
  //   return response.statusCode < 400
  //       ? noticeListResponseFromJson(result)
  //       : null;
  // }

  // // faq
  // static Future<List<FaQListResponse>> getFaQList() async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "other/faq";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("FaQListResponse :: " + result);
  //   return response.statusCode < 400 ? faQListResponseFromJson(result) : null;
  // }

  // // SearchUser
  // static Future<List<SearchUserListResponse>> searchUser(
  //     String searchKey) async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "users/search-users/$searchKey";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("TrainerInfoResponse :: " + result);
  //   return response.statusCode < 400
  //       ? searchUserListResponseFromJson(result)
  //       : null;
  // }

  // // 스케쥴 조회
  // static Future<TrainerScheduleResponse> getSchedule(String yearMonth) async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "trainers/schedule/12/$yearMonth";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("emailCheckResponse :: " + result);
  //   return response.statusCode < 400
  //       ? trainerScheduleResponseFromJson(result)
  //       : null;
  // }

  // // 오프라인 상담 요청 목록
  // static Future<List<CsRequestListResponse>> getCsRequestList() async {
  //   // 임시 트레이너 uid = 12;

  //   // status 0 -> 전화 전 || 1 -> 전화 후
  //   String apiUrlPath = apiURL + "trainers/cs-request-list/12/0";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("CsRequestListResponse :: " + result);
  //   return response.statusCode < 400
  //       ? csRequestListResponseFromJson(result)
  //       : null;
  // }

  // // 이메일 중복 체크
  // static Future<EmailCheckResponse> emailCheck(String email) async {
  //   String apiUrlPath = apiURL + "trainers/validate-email/$email";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("emailCheckResponse :: " + result);
  //   return response.statusCode < 400
  //       ? emailCheckResponseFromJson(result)
  //       : null;
  // }

  // 회원가입
  // static Future<RegisterResponse> registerUser(var data) async {
  //   String apiUrlPath = apiURL + "trainers/register";

  //   var header = {
  //     "Content-Type": "application/json",
  //   };
  //   var response =
  //       await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

  //   var result = response.body;

  //   print("registerResponse :: " + result);
  //   return response.statusCode < 400 ? registerResponseFromJson(result) : null;
  // }

  // static Future<SearchGymResponse> searchGym(String key) async {
  //   String apiUrlPath = apiURL + "gyms/search/$key";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("SearchGymResponse :: " + result);
  //   return response.statusCode < 400 ? searchGymResponseFromJson(result) : null;
  // }

  // // offline user list
  // static Future<List<OfflineUserListModel>> getOfflineUserList(
  //     String userType) async {
  //   // 임시 트레이너 uid = 12;
  //   String apiUrlPath = apiURL + "trainers/userList/12/$userType";

  //   var response = await client.get(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("SearchGymResponse :: " + result);
  //   return response.statusCode < 400
  //       ? offlineUserListModelFromJson(result)
  //       : null;
  // }

  // // offline pt 등록
  // static Future<OfflinePtResponse> createSchedule(var data) async {
  //   String apiUrlPath = apiURL + "trainers/create-schedule";

  //   var header = {
  //     "Content-Type": "application/json",
  //   };
  //   var response =
  //       await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

  //   var result = response.body;

  //   print("registerResponse :: " + result);
  //   return response.statusCode < 400 ? offlinePtResponseFromJson(result) : null;
  // }

  // // offline pt 업데이트
  // static Future<OfflinePtResponse> updateSchedule(var data) async {
  //   String apiUrlPath = apiURL + "trainers/update-schedule";

  //   var header = {
  //     "Content-Type": "application/json",
  //   };
  //   var response =
  //       await client.put(Uri.parse(apiUrlPath), body: data, headers: header);

  //   var result = response.body;

  //   print("registerResponse :: " + result);
  //   return response.statusCode < 400 ? offlinePtResponseFromJson(result) : null;
  // }

  // // offline pt 완료 / 노쇼 처리
  // static confirmSchedule(var data) async {
  //   String apiUrlPath = apiURL + "trainers/confirm-schedule";

  //   var header = {
  //     "Content-Type": "application/json",
  //   };
  //   var response =
  //       await client.put(Uri.parse(apiUrlPath), body: data, headers: header);

  //   var result = response.body;

  //   print("registerResponse :: " + result);
  //   return response.statusCode < 400
  //       ?
  //       // offlinePtResponseFromJson(result)
  //       true
  //       : null;
  // }

  // // offline pt 삭제
  // static Future<ScheduleDeleteResponse> deleteSchedule(String uid) async {
  //   String apiUrlPath = apiURL + "trainers/delete-schedule/$uid";

  //   var response = await client.delete(Uri.parse(apiUrlPath));

  //   var result = response.body;

  //   print("SearchGymResponse :: " + result);
  //   return response.statusCode < 400
  //       ? scheduleDeleteResponseFromJson(result)
  //       : null;
  // }

  // // // Splash 설정 데이터
  // // static Future<AppDefaultSettingsModel> getAppDefaultSettings() async {
  // //   String apiUrlPath = apiURL + "app-default-setting";

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};

  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;
  // //   // print(result.toString());
  // //   return response.statusCode < 400
  // //       ? appDefaultSettingsModelFromJson(result)
  // //       : null;
  // // }

  // // static Future<List<BoardListItemsAllModel>> getBoardListItemsAll() async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL + "board/init";

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;
  // //   print("BOARDALL :: " + result);
  // //   return response.statusCode < 400
  // //       ? boardListItemsAllModelFromJson(result)
  // //       : null;
  // // }

  // // static Future<DynamicDataModel> getDynamicSettingData() async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL + "app-dynamic-setting";

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;
  // //   // print("DYNAMIC API RESULT : " + result);
  // //   return response.statusCode < 400 ? dynamicDataModelFromJson(result) : null;
  // // }

  // // // static Future<AppDynamicSettingsModel> getAppDynamicSettings() async {
  // // //   String apiUrlPath = apiURL + "app-dynamic-setting";

  // // //   print("SplashApiUrl :: " + apiUrlPath);
  // // //   var response = await client.get(Uri.parse(apiUrlPath));

  // // //   var result = response.body;
  // // //   print(result.toString());
  // // //   return response.statusCode < 400
  // // //       ? appDynamicSettingsModelFromJson(result)
  // // //       : null;
  // // // }

  // // static Future<List<BoardListModel>> getBoardList() async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL + "board/list/all";

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;
  // //   return response.statusCode < 400 ? boardListModelFromJson(result) : null;
  // // }

  // // // boardContentListData
  // // static Future<BoardContentListModel> getBoardContentListData(String boardKey,
  // //     int page, int limit, int sort, String orderBy, bool showReserved) async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL +
  // //       "board/" +
  // //       boardKey +
  // //       "/" +
  // //       page.toString() +
  // //       "/" +
  // //       limit.toString() +
  // //       "/" +
  // //       sort.toString() +
  // //       "/" +
  // //       orderBy +
  // //       "/" +
  // //       showReserved.toString();

  // //   print("DDDSSDSF " + apiUrlPath);

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;

  // //   // print("HAHAHAHHH :: " + result);
  // //   // print("DYNAMIC API RESULT : " + result);
  // //   return response.statusCode < 400
  // //       ? boardContentListModelFromJson(result)
  // //       : null;
  // // }

  // // // boardContentDetailData
  // // static Future<BoardContentDetailModel> getBoardContentDetailData(
  // //     String contentKey) async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL + "board/content/" + contentKey;

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;

  // //   // print("HAHAHAHHH :: " + result);
  // //   // print("DYNAMIC API RESULT : " + result);
  // //   return response.statusCode < 400
  // //       ? boardContentDetailModelFromJson(result)
  // //       : null;
  // // }

  // // // getContentCommentList
  // // static Future<List<ContentCommentListModel>> getContentCommentList(
  // //     String commentUuid) async {
  // //   // String apiUrlPath = apiUrl + "GET_DYNAMIC_DATA";
  // //   String apiUrlPath = apiURL + "board/comment/" + commentUuid;

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   var response = await client.get(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;

  // //   print("HAHAHAHHH :: " + result);
  // //   // print("DYNAMIC API RESULT : " + result);
  // //   return response.statusCode < 400
  // //       ? contentCommentListModelFromJson(result)
  // //       : null;
  // // }

  // // // submit comment
  // // static Future<CommentSendResponseModel> sendCommentMsg(
  // //     String content,
  // //     String author,
  // //     String contentKey,
  // //     String parentCommentKey,
  // //     String imageUrl,
  // //     String mp3Url,
  // //     String youtubeUrl,
  // //     String webUrl) async {
  // //   String apiUrlPath = apiURL + "board/comment";
  // //   var data = {
  // //     'content': content,
  // //     'author': author,
  // //     'contentKey': contentKey,
  // //     'boardKey': "",
  // //     'parentCommentKey': parentCommentKey,
  // //     'imageUrl': imageUrl,
  // //     'mp3Url': mp3Url,
  // //     'youtubeUrl': youtubeUrl,
  // //     'webUrl': webUrl
  // //   };
  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   // var header = {
  // //   //   "Access-Control-Allow-Headers": "Content-Type",
  // //   //   "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
  // //   // };
  // //   var response =
  // //       await client.post(Uri.parse(apiUrlPath), body: data, headers: header);

  // //   var result = response.body;
  // //   print("commentResult :: " + result);
  // //   return response.statusCode < 400
  // //       ? commentSendResponseModelFromJson(result)
  // //       : null;
  // // }

  // // static Future<DeleteCommentResultModel> deleteCommentMsg(
  // //     String commentKey) async {
  // //   String apiUrlPath = apiURL + "board/comment/" + commentKey;

  // //   print(apiUrlPath);

  // //   var header = {"pkgname": "com.crevenew.hanshem2", "uid": "admin"};
  // //   // var header = {
  // //   //   "Access-Control-Allow-Headers": "Content-Type",
  // //   //   "Access-Control-Allow-Methods": "OPTIONS,POST,GET"
  // //   // };
  // //   var response = await client.delete(Uri.parse(apiUrlPath), headers: header);

  // //   var result = response.body;
  // //   print("commentResult :: " + result);
  // //   return response.statusCode < 400
  // //       // ? true
  // //       ? deleteCommentResultModelFromJson(result)
  // //       : null;
  // // }
}
