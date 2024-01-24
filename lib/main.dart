import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:top_care/bindings.dart';
import 'package:top_care/views/entryPoint.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_care/views/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA9sO5YIsA3Xzgc_14rvdi7-ZvDkz08qH0",
      appId: "1:639592067343:android:9d62baa349b96b510c0e7a",
      messagingSenderId: "messaging sender id here",
      projectId: "flutter-topcare",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 825),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        initialBinding: Binding(),
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser != null
            ? MainScreen()
            : const LoginView(),
      ),
    );
  }
}
