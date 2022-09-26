import 'dart:convert';

class GetIamportAccessTokenReq {
  GetIamportAccessTokenReq({
    this.imp_key,
    this.imp_secret,
  });

  String imp_key;
  String imp_secret;

  factory GetIamportAccessTokenReq.fromRawJson(String str) =>
      GetIamportAccessTokenReq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetIamportAccessTokenReq.fromJson(Map<String, dynamic> json) =>
      GetIamportAccessTokenReq(
        imp_key: json["imp_key"],
        imp_secret: json["imp_secret"],
      );

  Map<String, dynamic> toJson() => {
        "imp_key": imp_key,
        "imp_secret": imp_secret,
      };
}
