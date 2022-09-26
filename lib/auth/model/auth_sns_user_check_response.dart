// To parse this JSON data, do
//
//     final authSnsUserCheckResponse = authSnsUserCheckResponseFromJson(jsonString);

import 'dart:convert';

AuthSnsUserCheckResponse authSnsUserCheckResponseFromJson(String str) =>
    AuthSnsUserCheckResponse.fromJson(json.decode(str));

String authSnsUserCheckResponseToJson(AuthSnsUserCheckResponse data) =>
    json.encode(data.toJson());

class AuthSnsUserCheckResponse {
  AuthSnsUserCheckResponse({
    this.resultCode,
    this.resultMsg,
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  int resultCode;
  String resultMsg;
  String accessToken;
  String refreshToken;
  AuthSnsUserCheckResponseUser user;

  factory AuthSnsUserCheckResponse.fromJson(Map<String, dynamic> json) =>
      AuthSnsUserCheckResponse(
        resultCode: json["resultCode"] == null ? null : json["resultCode"],
        resultMsg: json["resultMsg"] == null ? null : json["resultMsg"],
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
        user: json["user"] == null
            ? null
            : AuthSnsUserCheckResponseUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode == null ? null : resultCode,
        "resultMsg": resultMsg == null ? null : resultMsg,
        "accessToken": accessToken == null ? null : accessToken,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "user": user == null ? null : user.toJson(),
      };
}

class AuthSnsUserCheckResponseUser {
  AuthSnsUserCheckResponseUser({
    this.uid,
    this.profileImage,
    this.socialType,
    this.socialCode,
    this.email,
    this.regDate,
    this.user,
  });

  int uid;
  String profileImage;
  int socialType;
  String socialCode;
  String email;
  String regDate;
  UserUser user;

  factory AuthSnsUserCheckResponseUser.fromJson(Map<String, dynamic> json) =>
      AuthSnsUserCheckResponseUser(
        uid: json["uid"] == null ? null : json["uid"],
        profileImage:
            json["profileImage"] == null ? null : json["profileImage"],
        socialType: json["socialType"] == null ? null : json["socialType"],
        socialCode: json["socialCode"] == null ? null : json["socialCode"],
        email: json["email"] == null ? null : json["email"],
        regDate: json["regDate"] == null ? null : json["regDate"],
        user: json["user"] == null ? null : UserUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "profileImage": profileImage == null ? null : profileImage,
        "socialType": socialType == null ? null : socialType,
        "socialCode": socialCode == null ? null : socialCode,
        "email": email == null ? null : email,
        "regDate": regDate == null ? null : regDate,
        "user": user == null ? null : user.toJson(),
      };
}

class UserUser {
  UserUser({
    this.uid,
    this.email,
    this.name,
    this.udid,
    this.password,
    this.addName,
    this.longitude,
    this.latitude,
    this.updateDate,
    this.regDate,
    this.status,
  });

  int uid;
  String email;
  String name;
  String udid;
  String password;
  String addName;
  double longitude;
  double latitude;
  String updateDate;
  String regDate;
  int status;

  factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
        uid: json["uid"] == null ? null : json["uid"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
        udid: json["udid"] == null ? null : json["udid"],
        password: json["password"] == null ? null : json["password"],
        addName: json["addName"] == null ? null : json["addName"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        updateDate: json["updateDate"] == null ? null : json["updateDate"],
        regDate: json["regDate"] == null ? null : json["regDate"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
        "udid": udid == null ? null : udid,
        "password": password == null ? null : password,
        "addName": addName == null ? null : addName,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "updateDate": updateDate == null ? null : updateDate,
        "regDate": regDate == null ? null : regDate,
        "status": status == null ? null : status,
      };
}
