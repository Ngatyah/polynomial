import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:polynomial/login_control.dart';

import 'widgets/components.dart';

// A simple Login Form
class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final LoginControl loginCxt = Get.find();
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginCxt.loginFormKey,
        autovalidateMode: AutovalidateMode.always,
        child: Container(
          color: const Color(0xFF00CDAD),
          width: context.width,
          height: context.height,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Polynomial Calculator",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: myFocusNode,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Login",
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.black : Colors.white),
                    prefixIcon: const Icon(
                      Icons.keyboard,
                      color: Colors.white,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: loginCxt.loginController,
                  onSaved: (value) {
                    loginCxt.email = value!;
                  },
                  validator: (value) {
                    return loginCxt.loginValidator(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.black : Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  controller: loginCxt.passController,
                  onSaved: (value) {
                    loginCxt.password = value!;
                  },
                  validator: (value) {
                    return loginCxt.passwordValidator(value!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: "Polynomial",
                    labelStyle: TextStyle(
                        color:
                            myFocusNode.hasFocus ? Colors.black : Colors.white),
                    prefixIcon: const Icon(
                      Icons.auto_graph,
                      color: Colors.white,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: false,
                  controller: loginCxt.polyController,
                  onSaved: (value) {
                    loginCxt.polynomial = value!;
                  },
                  validator: (value) {
                    return loginCxt.polynomialValidator(value!);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                buildLoginButton(
                    onPress: () {
                      loginCxt.checkLogin();
                      loginCxt.polynomialDerivative();
                      loginCxt.addUserCredentials();
                    },
                    query: 'Submit'),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Text(
                      'Derivatives: ${loginCxt.polyData.value}',
                      style: const TextStyle(fontSize: 20),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Text(
                      'sum of Derivatives : ${loginCxt.polySum.value}',
                      style: const TextStyle(fontSize: 20),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
