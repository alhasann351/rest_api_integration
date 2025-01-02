import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final loading = false.obs;

  void loginApi() async {
    loading.value = true;
    try {
      var responseApi = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email': emailController.value.text,
          'password': passwordController.value.text,
        },
      );
      var data = jsonDecode(responseApi.body.toString());
      debugPrint(responseApi.statusCode.toString());
      debugPrint(data.toString());

      if (responseApi.statusCode == 200) {
        Get.snackbar(
          'Login success',
          'welcome',
          snackPosition: SnackPosition.TOP,
        );
        loading.value = false;
      } else {
        Get.snackbar('Login failed', data['error']);
        loading.value = false;
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
      loading.value = false;
    }
  }
}
