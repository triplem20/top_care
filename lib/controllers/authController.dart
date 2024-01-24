import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:top_care/models/userModel.dart';
import 'package:top_care/views/entryPoint.dart';
import 'package:top_care/views/login.dart';

class AuthController extends GetxController {
  RoundedLoadingButtonController btnCNTL = RoundedLoadingButtonController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();
  TextEditingController nameCNTL = TextEditingController();
  TextEditingController emailCNTL = TextEditingController();
  TextEditingController passCNTL = TextEditingController();
  TextEditingController phoneCNTL = TextEditingController();
  TextEditingController adressCNTL = TextEditingController();

  // Register User
  signUp(UserModel userInfo, String password) async {
    try {
      if (formKey.currentState!.validate()) {
        btnCNTL.start();
        await _auth
            .createUserWithEmailAndPassword(
                email: userInfo.emailAdress!.trim(), password: password.trim())
            .then((value) async {
          await _userCollection.doc(value.user!.uid).set({
            "uid": value.user!.uid,
            "name": userInfo.userName,
            "email": userInfo.emailAdress,
            "phone": userInfo.phoneNumber,
            "adress": userInfo.adress,
            "role": "user"
          });
        });
        nameCNTL.clear();
        emailCNTL.clear();
        adressCNTL.clear();
        passCNTL.clear();
        phoneCNTL.clear();
        btnCNTL.stop();
        Get.to(() => const LoginView());
      }
    } on FirebaseAuthException catch (e) {
      btnCNTL.stop();
      print(e.message);
      EasyLoading.showError("something went wrong");
    }
    btnCNTL.reset();
  }

  // Login
  logIn(String email, String password) async {
    if (formKey2.currentState!.validate()) {
      btnCNTL.start();
      try {
        await _auth.signInWithEmailAndPassword(
            email: email.trim(), password: password);
        btnCNTL.reset();
        Get.to(() => MainScreen());
      } on FirebaseAuthException catch (e) {
        btnCNTL.reset();
        print(e.message);
        EasyLoading.showError("wrong email or password");
      }
    }
    btnCNTL.reset();
  }
}
