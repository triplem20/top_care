import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:top_care/controllers/authController.dart';
import 'package:top_care/models/userModel.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    const Text(
                      'Register',
                      style: TextStyle(fontSize: 28, fontFamily: 'primary'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: controller.nameCNTL,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Enter Your Name";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.grey.shade800,
                          ),
                          label: const Text(
                            'Name',
                            style: TextStyle(fontFamily: 'primary'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: controller.adressCNTL,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Enter Your adress";
                        }
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.house_outlined,
                            color: Colors.grey.shade800,
                          ),
                          label: const Text(
                            'Adress',
                            style: TextStyle(fontFamily: 'primary'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20.h,
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
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: controller.phoneCNTL,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Enter Your Phone Nubmer";
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey.shade800,
                          ),
                          label: const Text(
                            'Phone Number',
                            style: TextStyle(fontFamily: 'primary'),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(
                      height: 20.h,
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
                          controller.signUp(
                              UserModel(
                                userName: controller.nameCNTL.text,
                                emailAdress: controller.emailCNTL.text,
                                phoneNumber: controller.phoneCNTL.text,
                                adress: controller.adressCNTL.text,
                              ),
                              controller.passCNTL.text);
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: 'primary',
                              fontSize: 18,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
