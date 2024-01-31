// To parse this JSON data, do
//
//     final welcomeSuccess = welcomeSuccessFromJson(jsonString);

import 'dart:convert';

WelcomeSuccess welcomeSuccessFromJson(String str) =>
    WelcomeSuccess.fromJson(json.decode(str));

String welcomeSuccessToJson(WelcomeSuccess data) => json.encode(data.toJson());

class WelcomeSuccess {
  bool status;
  String message;

  WelcomeSuccess({
    required this.status,
    required this.message,
  });

  factory WelcomeSuccess.fromJson(Map<String, dynamic> json) => WelcomeSuccess(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
