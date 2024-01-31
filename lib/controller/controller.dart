import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_post_api_register/model/model.dart';
import 'package:getx_post_api_register/service/service.dart';

class RegisterationController extends GetxController {
  RxList<WelcomeSuccess?> registrationModel = <WelcomeSuccess?>[].obs;
  var isDataLoading = false.obs;
  var registerSuccess = false.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pswdController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> post() async {
    isDataLoading.value = true;
    try {
      //  data to be sent to the API
      Map<String, dynamic> postData = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "confirmEmail": emailController.text,
        "password": pswdController.text,
        "confirmPassword": pswdController.text,
        "address": addressController.text,
        "state": 'S2020-00000035',
        "city": 'CI2020-00003683',
        "country": 'C2020-00000101',
        "PostalCodeID": 'PC2023-0000000001',
      };

      // Call the API service to post the data
      WelcomeSuccess? fetchedData = await CatService().postData(postData);
      debugPrint(fetchedData.toString());
      if (fetchedData != null) {
        registerSuccess(true);
      } else {
        registerSuccess(false);
      }

      registrationModel.addAll([fetchedData]);
    } catch (error) {
      debugPrint('Error posting data: $error');
    } finally {
      isDataLoading.value = false;
    }
  }

  void clearAllControllers() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    pswdController.clear();
    addressController.clear();
  }
}
