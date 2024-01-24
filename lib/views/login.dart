import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:top_care/controllers/authController.dart';

import 'package:top_care/views/signUp.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: controller.formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome,',
                    style: TextStyle(fontSize: 30, fontFamily: 'primary'),
                  ),
                  Lottie.asset("assets/anim/welcom.json",
                      height: 140.h, width: 150.w)
                ],
              ),
              TextFormField(
                controller: controller.emailCNTL,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter Your Email";
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade800,
                    ),
                    label: const Text(
                      'Email',
                      style: TextStyle(fontFamily: 'primary'),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controller.passCNTL,
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Enter Your Password";
                  }
                  if (v.length < 8) {
                    return "Password Must be 8 character or above";
                  }
                },
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.grey.shade800,
                    ),
                    label: const Text(
                      'Password',
                      style: TextStyle(fontFamily: 'primary'),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),
              SizedBox(
                height: 30.h,
              ),
              RoundedLoadingButton(
                  color: Colors.teal,
                  controller: controller.btnCNTL,
                  onPressed: () {
                    controller.logIn(
                        controller.emailCNTL.text, controller.passCNTL.text);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: 'primary',
                        fontSize: 18,
                        color: Colors.white),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont Have an account?  ',
                    style: TextStyle(fontFamily: 'primary', fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(const SignUpView(),
                            transition: Transition.rightToLeft);
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                            fontFamily: 'primary',
                            fontSize: 18,
                            color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
