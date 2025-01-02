import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_integration/login_controller.dart';

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: const Text(
          'Post Api',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: loginController.emailController.value,
              decoration: const InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: loginController.passwordController.value,
              decoration: const InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => loginController.loading.value
                  ? const CircularProgressIndicator(
                      color: Colors.blueAccent,
                    )
                  : SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        onPressed: () {
                          loginController.loginApi();
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
