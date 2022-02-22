import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polynomial/login_control.dart';

// Custom Login Button

SizedBox buildLoginButton({
  required String query,
  required VoidCallback onPress,
}) {
  final LoginControl loginCxt = Get.find<LoginControl>();
  return SizedBox(
    height: 64,
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.white,
        ),
        elevation: MaterialStateProperty.all(6),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
      child: Obx(() => loginCxt.isLoading.value
          ? const CircularProgressIndicator()
          : Text(
              query,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
      onPressed: onPress,
    ),
  );
}
