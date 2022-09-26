// To parse this JSON data, do
//
//     final splashDataResponse = splashDataResponseFromJson(jsonString);

import 'dart:convert';

SplashDataResponse splashDataResponseFromJson(String str) =>
    SplashDataResponse.fromJson(json.decode(str));

String splashDataResponseToJson(SplashDataResponse data) =>
    json.encode(data.toJson());

class SplashDataResponse {
  SplashDataResponse({
    this.uid,
    this.bannerUseCurriculum,
    this.bannerUsePoint,
    this.bannerResultBetting,
    this.commissionRatio,
    this.totalRewardAct,
    this.monthRewardAct,
    this.type1TrainerIncomeRatio,
    this.type1GymIncomeRatio,
    this.type1CompanyIncomeRatio,
    this.type2TrainerIncomeRatio,
    this.type2GymIncomeRatio,
    this.type2CompanyIncomeRatio,
    this.type3TrainerIncomeRatio,
    this.type3GymIncomeRatio,
    this.type3CompanyIncomeRatio,
    this.type4TrainerIncomeRatio,
    this.type4GymIncomeRatio,
    this.type4CompanyIncomeRatio,
    this.actToKrw,
    this.pptToKrw,
    this.pptToAct,
    this.actToPpt,
    this.actToPptFeeRate,
    this.actToKrwFeeRate,
    this.companyName,
    this.companyInfo,
    this.introPageImages,
    this.paymentCurriculumList,
    this.paymentBettingList,
  });

  int uid;
  String bannerUseCurriculum;
  String bannerUsePoint;
  String bannerResultBetting;
  double commissionRatio;
  int totalRewardAct;
  int monthRewardAct;
  double type1TrainerIncomeRatio;
  double type1GymIncomeRatio;
  double type1CompanyIncomeRatio;
  double type2TrainerIncomeRatio;
  double type2GymIncomeRatio;
  double type2CompanyIncomeRatio;
  double type3TrainerIncomeRatio;
  double type3GymIncomeRatio;
  double type3CompanyIncomeRatio;
  double type4TrainerIncomeRatio;
  double type4GymIncomeRatio;
  double type4CompanyIncomeRatio;
  int actToKrw;
  int pptToKrw;
  double pptToAct;
  double actToPpt;
  double actToPptFeeRate;
  double actToKrwFeeRate;
  String companyName;
  String companyInfo;
  List<String> introPageImages;
  List<PaymentCurriculumList> paymentCurriculumList;
  List<PaymentBettingList> paymentBettingList;

  factory SplashDataResponse.fromJson(Map<String, dynamic> json) =>
      SplashDataResponse(
        uid: json["uid"] == null ? null : json["uid"],
        bannerUseCurriculum: json["bannerUseCurriculum"] == null
            ? null
            : json["bannerUseCurriculum"],
        bannerUsePoint:
            json["bannerUsePoint"] == null ? null : json["bannerUsePoint"],
        bannerResultBetting: json["bannerResultBetting"] == null
            ? null
            : json["bannerResultBetting"],
        commissionRatio: json["commissionRatio"] == null
            ? null
            : json["commissionRatio"].toDouble(),
        totalRewardAct:
            json["totalRewardAct"] == null ? null : json["totalRewardAct"],
        monthRewardAct:
            json["monthRewardAct"] == null ? null : json["monthRewardAct"],
        type1TrainerIncomeRatio: json["type1TrainerIncomeRatio"] == null
            ? null
            : json["type1TrainerIncomeRatio"].toDouble(),
        type1GymIncomeRatio: json["type1GymIncomeRatio"] == null
            ? null
            : json["type1GymIncomeRatio"].toDouble(),
        type1CompanyIncomeRatio: json["type1CompanyIncomeRatio"] == null
            ? null
            : json["type1CompanyIncomeRatio"].toDouble(),
        type2TrainerIncomeRatio: json["type2TrainerIncomeRatio"] == null
            ? null
            : json["type2TrainerIncomeRatio"].toDouble(),
        type2GymIncomeRatio: json["type2GymIncomeRatio"] == null
            ? null
            : json["type2GymIncomeRatio"].toDouble(),
        type2CompanyIncomeRatio: json["type2CompanyIncomeRatio"] == null
            ? null
            : json["type2CompanyIncomeRatio"].toDouble(),
        type3TrainerIncomeRatio: json["type3TrainerIncomeRatio"] == null
            ? null
            : json["type3TrainerIncomeRatio"].toDouble(),
        type3GymIncomeRatio: json["type3GymIncomeRatio"] == null
            ? null
            : json["type3GymIncomeRatio"].toDouble(),
        type3CompanyIncomeRatio: json["type3CompanyIncomeRatio"] == null
            ? null
            : json["type3CompanyIncomeRatio"].toDouble(),
        type4TrainerIncomeRatio: json["type4TrainerIncomeRatio"] == null
            ? null
            : json["type4TrainerIncomeRatio"].toDouble(),
        type4GymIncomeRatio: json["type4GymIncomeRatio"] == null
            ? null
            : json["type4GymIncomeRatio"].toDouble(),
        type4CompanyIncomeRatio: json["type4CompanyIncomeRatio"] == null
            ? null
            : json["type4CompanyIncomeRatio"].toDouble(),
        actToKrw: json["actToKrw"] == null ? null : json["actToKrw"],
        pptToKrw: json["pptToKrw"] == null ? null : json["pptToKrw"],
        pptToAct: json["pptToAct"] == null ? null : json["pptToAct"].toDouble(),
        actToPpt: json["actToPpt"] == null ? null : json["actToPpt"].toDouble(),
        actToPptFeeRate:
            json["actToPptFeeRate"] == null ? null : json["actToPptFeeRate"],
        actToKrwFeeRate:
            json["actToKrwFeeRate"] == null ? null : json["actToKrwFeeRate"],
        companyName: json["companyName"] == null ? null : json["companyName"],
        companyInfo: json["companyInfo"] == null ? null : json["companyInfo"],
        introPageImages: json["introPageImages"] == null
            ? null
            : List<String>.from(json["introPageImages"].map((x) => x)),
        paymentCurriculumList: json["paymentCurriculumList"] == null
            ? null
            : List<PaymentCurriculumList>.from(json["paymentCurriculumList"]
                .map((x) => PaymentCurriculumList.fromJson(x))),
        paymentBettingList: json["paymentBettingList"] == null
            ? null
            : List<PaymentBettingList>.from(json["paymentBettingList"]
                .map((x) => PaymentBettingList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "bannerUseCurriculum":
            bannerUseCurriculum == null ? null : bannerUseCurriculum,
        "bannerUsePoint": bannerUsePoint == null ? null : bannerUsePoint,
        "bannerResultBetting":
            bannerResultBetting == null ? null : bannerResultBetting,
        "commissionRatio": commissionRatio == null ? null : commissionRatio,
        "totalRewardAct": totalRewardAct == null ? null : totalRewardAct,
        "monthRewardAct": monthRewardAct == null ? null : monthRewardAct,
        "type1TrainerIncomeRatio":
            type1TrainerIncomeRatio == null ? null : type1TrainerIncomeRatio,
        "type1GymIncomeRatio":
            type1GymIncomeRatio == null ? null : type1GymIncomeRatio,
        "type1CompanyIncomeRatio":
            type1CompanyIncomeRatio == null ? null : type1CompanyIncomeRatio,
        "type2TrainerIncomeRatio":
            type2TrainerIncomeRatio == null ? null : type2TrainerIncomeRatio,
        "type2GymIncomeRatio":
            type2GymIncomeRatio == null ? null : type2GymIncomeRatio,
        "type2CompanyIncomeRatio":
            type2CompanyIncomeRatio == null ? null : type2CompanyIncomeRatio,
        "type3TrainerIncomeRatio":
            type3TrainerIncomeRatio == null ? null : type3TrainerIncomeRatio,
        "type3GymIncomeRatio":
            type3GymIncomeRatio == null ? null : type3GymIncomeRatio,
        "type3CompanyIncomeRatio":
            type3CompanyIncomeRatio == null ? null : type3CompanyIncomeRatio,
        "type4TrainerIncomeRatio":
            type4TrainerIncomeRatio == null ? null : type4TrainerIncomeRatio,
        "type4GymIncomeRatio":
            type4GymIncomeRatio == null ? null : type4GymIncomeRatio,
        "type4CompanyIncomeRatio":
            type4CompanyIncomeRatio == null ? null : type4CompanyIncomeRatio,
        "actToKrw": actToKrw == null ? null : actToKrw,
        "pptToKrw": pptToKrw == null ? null : pptToKrw,
        "pptToAct": pptToAct == null ? null : pptToAct,
        "actToPpt": actToPpt == null ? null : actToPpt,
        "actToPptFeeRate": actToPptFeeRate == null ? null : actToPptFeeRate,
        "actToKrwFeeRate": actToKrwFeeRate == null ? null : actToKrwFeeRate,
        "companyName": companyName == null ? null : companyName,
        "companyInfo": companyInfo == null ? null : companyInfo,
        "introPageImages": introPageImages == null
            ? null
            : List<dynamic>.from(introPageImages.map((x) => x)),
        "paymentCurriculumList": paymentCurriculumList == null
            ? null
            : List<dynamic>.from(paymentCurriculumList.map((x) => x.toJson())),
        "paymentBettingList": paymentBettingList == null
            ? null
            : List<dynamic>.from(paymentBettingList.map((x) => x.toJson())),
      };
}

class PaymentBettingList {
  PaymentBettingList({
    this.uid,
    this.title,
    this.startTime,
    this.endTime,
    this.image,
    this.recruitmentNumber,
  });

  int uid;
  String title;
  String startTime;
  String endTime;
  String image;
  int recruitmentNumber;

  factory PaymentBettingList.fromJson(Map<String, dynamic> json) =>
      PaymentBettingList(
        uid: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        image: json["image"] == null ? null : json["image"],
        recruitmentNumber: json["recruitmentNumber"] == null
            ? null
            : json["recruitmentNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "title": title == null ? null : title,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "image": image == null ? null : image,
        "recruitmentNumber":
            recruitmentNumber == null ? null : recruitmentNumber,
      };
}

class PaymentCurriculumList {
  PaymentCurriculumList({
    this.uid,
    this.startDate,
    this.endDate,
    this.curriculum,
  });

  int uid;
  dynamic startDate;
  dynamic endDate;
  Curriculum curriculum;

  factory PaymentCurriculumList.fromJson(Map<String, dynamic> json) =>
      PaymentCurriculumList(
        uid: json["uid"] == null ? null : json["uid"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        curriculum: json["curriculum"] == null
            ? null
            : Curriculum.fromJson(json["curriculum"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "startDate": startDate,
        "endDate": endDate,
        "curriculum": curriculum == null ? null : curriculum.toJson(),
      };
}

class Curriculum {
  Curriculum({
    this.uid,
    this.title,
    this.price,
    this.periodDays,
    this.rewardType,
    this.rewardAmount,
    this.startDate,
    this.endDate,
    this.goal,
    this.explanation,
    this.type,
    this.isOnline,
    this.onlineResultCode,
    this.regDate,
    this.trainer,
  });

  int uid;
  String title;
  int price;
  int periodDays;
  int rewardType;
  int rewardAmount;
  String startDate;
  String endDate;
  String goal;
  String explanation;
  int type;
  bool isOnline;
  int onlineResultCode;
  String regDate;
  Trainer trainer;

  factory Curriculum.fromJson(Map<String, dynamic> json) => Curriculum(
        uid: json["uid"] == null ? null : json["uid"],
        title: json["title"] == null ? null : json["title"],
        price: json["price"] == null ? null : json["price"],
        periodDays: json["periodDays"] == null ? null : json["periodDays"],
        rewardType: json["rewardType"] == null ? null : json["rewardType"],
        rewardAmount:
            json["rewardAmount"] == null ? null : json["rewardAmount"],
        startDate: json["startDate"] == null ? null : json["startDate"],
        endDate: json["endDate"] == null ? null : json["endDate"],
        goal: json["goal"] == null ? null : json["goal"],
        explanation: json["explanation"] == null ? null : json["explanation"],
        type: json["type"] == null ? null : json["type"],
        isOnline: json["isOnline"] == null ? null : json["isOnline"],
        onlineResultCode:
            json["onlineResultCode"] == null ? null : json["onlineResultCode"],
        regDate: json["regDate"] == null ? null : json["regDate"],
        trainer:
            json["trainer"] == null ? null : Trainer.fromJson(json["trainer"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "title": title == null ? null : title,
        "price": price == null ? null : price,
        "periodDays": periodDays == null ? null : periodDays,
        "rewardType": rewardType == null ? null : rewardType,
        "rewardAmount": rewardAmount == null ? null : rewardAmount,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "goal": goal == null ? null : goal,
        "explanation": explanation == null ? null : explanation,
        "type": type == null ? null : type,
        "isOnline": isOnline == null ? null : isOnline,
        "onlineResultCode": onlineResultCode == null ? null : onlineResultCode,
        "regDate": regDate == null ? null : regDate,
        "trainer": trainer == null ? null : trainer.toJson(),
      };
}

class Trainer {
  Trainer({
    this.uid,
    this.name,
    this.trainerProfile,
  });

  int uid;
  String name;
  TrainerProfile trainerProfile;

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        uid: json["uid"] == null ? null : json["uid"],
        name: json["name"] == null ? null : json["name"],
        trainerProfile: json["trainerProfile"] == null
            ? null
            : TrainerProfile.fromJson(json["trainerProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "name": name == null ? null : name,
        "trainerProfile":
            trainerProfile == null ? null : trainerProfile.toJson(),
      };
}

class TrainerProfile {
  TrainerProfile({
    this.profileImage,
    this.gym,
  });

  String profileImage;
  Gym gym;

  factory TrainerProfile.fromJson(Map<String, dynamic> json) => TrainerProfile(
        profileImage:
            json["profileImage"] == null ? null : json["profileImage"],
        gym: json["gym"] == null ? null : Gym.fromJson(json["gym"]),
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage == null ? null : profileImage,
        "gym": gym == null ? null : gym.toJson(),
      };
}

class Gym {
  Gym({
    this.name,
    this.gymProfile,
  });

  String name;
  GymProfile gymProfile;

  factory Gym.fromJson(Map<String, dynamic> json) => Gym(
        name: json["name"] == null ? null : json["name"],
        gymProfile: json["gymProfile"] == null
            ? null
            : GymProfile.fromJson(json["gymProfile"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "gymProfile": gymProfile == null ? null : gymProfile.toJson(),
      };
}

class GymProfile {
  GymProfile({
    this.adress,
  });

  String adress;

  factory GymProfile.fromJson(Map<String, dynamic> json) => GymProfile(
        adress: json["adress"] == null ? null : json["adress"],
      );

  Map<String, dynamic> toJson() => {
        "adress": adress == null ? null : adress,
      };
}
