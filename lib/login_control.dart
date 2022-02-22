import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

// This Controller controls every aspect of the login Form
// Use Getx Package for smooth state management
class LoginControl extends GetxController {
  late TextEditingController loginController, passController, polyController;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var polynomial = '';
  var isLoading = false.obs;
  var polyData = ''.obs;
  var polySum = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loginController = TextEditingController();
    passController = TextEditingController();
    polyController = TextEditingController();
  }

  @override
  void onClose() {
    loginController.dispose();
    passController.dispose();
    polyController.dispose();

    super.onClose();
  }

  loginValidator(String value) {
    Pattern pattern = r'^[a-zA-Z0-9]+$';

    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Wrong credential, Ensure your credentials contains lowercase letters a-z\n or uppercase letters A-Z or numbers 0-9 or a combination of the three";
    }

    return null;
  }

  passwordValidator(String value) {
    Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return "Wrong Password!\n Make sure your password has at least has one upper case\n, one lower case, at least one special character\n & has a Minimum eight Characters ";
    }
    return null;
  }

  polynomialValidator(String value) {
    RegExp pattern = RegExp(r'(\+|-)?(\d+[a-zA-z]|[a-zA-z]|\d+)(\^\d+)?');
    final splitEquation = value.split(RegExp(r'([+|-])'));
    Iterable<RegExpMatch> matches = pattern.allMatches(value);

    if (splitEquation.length != matches.length) {
      return "Enter A Correct Polynomial, Use ^ as a sign of Power example\n 6x^2-5x^3-5+5x^6";
    }

    return null;
  }

// Helps save currentState of the form
  checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
  }

  Future<void> addUserCredentials() async {
    // Call the user's CollectionReference to add a new user
    isLoading.value = true;
    return await users.add({
      'login': loginController.text.trim(),
      'password': passController.text.trim(),
      'derivatives': polyData.value,
      'sum-of-derivatives': polySum.value,
    }).then((value) {
      isLoading.value = false;
      print("User Added");
    }).catchError((error) {
      isLoading.value = false;
      print("Failed to add user: $error");
    });
  }

  polynomialDerivative() {
    var polynomial = polyController.text.trim().replaceAll(RegExp(r'\s'), '');
//Get a Derivative Term
    deriveTerm(String term) {
      final splitTerm = term.split("^");
      final splitCoefficient = splitTerm[0].split(RegExp(r'(?=[a-z])'));

      final newPower = int.parse(splitTerm[1]) - 1;
      var constructTerm = (splitTerm[1]);

      if (splitCoefficient.length > 1) {
        constructTerm =
            (int.parse(splitCoefficient[0]) * int.parse(constructTerm))
                .toString();
      }
      var newTerm = constructTerm.toString();
      if (newPower > 1) {
        newTerm = '$newTerm ${splitCoefficient[1]} ^ $newPower';
      }

      return newTerm;
    }

// Finds Derivative of Each Term
    derive(String exp) {
      var expLength = exp.length;
      var newExp = '';
      var expTerm = '';
      var prevSign = '';
      for (var i = 0; i < expLength; i++) {
        final val = exp[i];
        if (val == "-" || val == "+" || i == expLength - 1) {
          if (i == expLength - 1) {
            expTerm = expTerm + val;
          }
          RegExp exp = RegExp('[a-z]', multiLine: true);
          if (exp.hasMatch(expTerm)) {
            if (expTerm.contains('^')) {
              while (expTerm.contains('^')) {
                expTerm = deriveTerm(expTerm);
              }
            }
            newExp = newExp + prevSign + expTerm;
          }
          prevSign = val;
          expTerm = "";
        } else {
          expTerm = expTerm + val;
        }
      }
      return newExp;
    }

    while (polynomial.contains('^')) {
      polynomial = derive(polynomial);
    }

    polynomial = polynomial.replaceAll(RegExp(r'[a-z]'), '');

    polyData.value = polynomial;

    final splitDer = polynomial.split(RegExp(r'[+|-]'));

    List<int> intList = [];
    for (var i in splitDer) {
      int? value = int.tryParse(i);
      intList.add(value!);
    }

    var sum = intList.reduce((a, b) => a + b);
    polySum.value = sum.toString();
    print('Sum: $sum');
  }
}
