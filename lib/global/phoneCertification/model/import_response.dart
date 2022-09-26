// To parse this JSON data, do
//
//     final iamPortResponse = iamPortResponseFromJson(jsonString);

import 'dart:convert';

IamPortResponse iamPortResponseFromJson(String str) =>
    IamPortResponse.fromJson(json.decode(str));

String iamPortResponseToJson(IamPortResponse data) =>
    json.encode(data.toJson());

class IamPortResponse {
  IamPortResponse({
    this.success,
    this.impUid,
    this.merchantUid,
    this.pgProvider,
    this.pgType,
    this.errorCode,
    this.errorMsg,
  });

  bool success;
  String impUid;
  String merchantUid;
  String pgProvider;
  String pgType;
  dynamic errorCode;
  dynamic errorMsg;

  factory IamPortResponse.fromJson(Map<String, dynamic> json) =>
      IamPortResponse(
        success: json["success"] == null ? null : json["success"],
        impUid: json["imp_uid"] == null ? null : json["imp_uid"],
        merchantUid: json["merchant_uid"] == null ? null : json["merchant_uid"],
        pgProvider: json["pg_provider"] == null ? null : json["pg_provider"],
        pgType: json["pg_type"] == null ? null : json["pg_type"],
        errorCode: json["error_code"],
        errorMsg: json["error_msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "imp_uid": impUid == null ? null : impUid,
        "merchant_uid": merchantUid == null ? null : merchantUid,
        "pg_provider": pgProvider == null ? null : pgProvider,
        "pg_type": pgType == null ? null : pgType,
        "error_code": errorCode,
        "error_msg": errorMsg,
      };
}
