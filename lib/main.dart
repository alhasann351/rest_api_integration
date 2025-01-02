import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_integration/post_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostApi(),
    );
  }
}
