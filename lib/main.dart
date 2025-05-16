import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/screens/welcome_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  
  Get.put(UserController());

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            home:  WelcomePage(),
          ),
        );
      },
    );
        }
}

