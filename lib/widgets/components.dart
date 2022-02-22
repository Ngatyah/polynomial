import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polynomial/login_control.dart';

Material buildTextField(
    {required bool obscureText,
    Widget? prefixedIcon,
    String? hintText,
    final String? Function(String?)? validator,
    void Function(String?)? onSaved,
    TextEditingController? txController,
    required TextInputType keyboard}) {
  return Material(
    color: Colors.white,
    elevation: 2,
    child: TextFormField(
      onSaved: onSaved,
      validator: validator,
      keyboardType: keyboard,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      cursorWidth: 2,
      obscureText: obscureText,
      controller: txController,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: const Color(0xFF00CDAD),
        prefixIcon: prefixedIcon,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

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
