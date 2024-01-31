import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_post_api_register/controller/controller.dart';
import 'package:getx_post_api_register/view/widgets/button_widget.dart';
import 'package:getx_post_api_register/view/widgets/textfield_widget.dart';

class Homescreen extends StatelessWidget {
  final RegisterationController registerationController =
      Get.put(RegisterationController());
  Homescreen({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await registerationController.post();
        },
      ),
      appBar: AppBar(
        title: const Text(' Home Screen'),
      ),
      body: Obx(() {
        if (registerationController.isDataLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                registerWidget(),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget registerWidget() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputTextFieldWidget(
              registerationController.firstNameController,
              'first name',
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the field';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextFieldWidget(
              registerationController.lastNameController,
              'last name',
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the field';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextFieldWidget(
              registerationController.emailController,
              'email address',
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the field';
                } else if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextFieldWidget(
              registerationController.pswdController,
              'Password',
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the field';
                } else if (value.length < 5) {
                  return 'Password must be at least 5 characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextFieldWidget(
              registerationController.addressController,
              'address',
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill the field';
                } else if (value.length < 10) {
                  return 'address must be at least 10 characters';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            SubmitButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Get.snackbar('processing', 'registering as a User',
                      backgroundColor: Colors.green, colorText: Colors.white);
                  await registerationController.post().then((value) {
                    Get.dialog(
                      AlertDialog(
                        title: registerationController.registerSuccess.isTrue
                            ? const Text('Registration Successful')
                            : const Text('Registration faild'),
                        content: registerationController.registerSuccess.isTrue
                            ? const Text('You have been successfully registered.')
                            : const Text('please try agian.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back(); // Close the alert box
                            },
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                    if (registerationController.registerSuccess.isTrue) {
                      registerationController.clearAllControllers();
                    }
                  });
                } else {
                  Get.snackbar('fill all data', 'all fields are required',
                      colorText: Colors.white, backgroundColor: Colors.red);
                }
              },
              title: 'Register',
            )
          ],
        ),
      ),
    );
  }
}
