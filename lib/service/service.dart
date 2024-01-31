import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_post_api_register/controller/controller.dart';
import 'package:getx_post_api_register/model/model.dart';
import 'package:http/http.dart' as http;

class CatService {
  final RegisterationController registerationController =
      Get.put(RegisterationController());

  String apiUrl = 'https://10hp.in/api/customer/registration';

  Future<WelcomeSuccess?> postData(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse(apiUrl), body: data);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);

      final Map<String, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse["status"] == true) {
        debugPrint("success");

        return WelcomeSuccess.fromJson(json.decode(response.body));
      } else {
        debugPrint("fail");
        return null;
      }
    } else {
      throw Exception('Failed to post exception');
    }
  }
}
