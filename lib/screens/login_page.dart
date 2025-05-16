import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/views/widgets/custom_registration.dart';

import '../views/widgets/custom_text_form_field.dart';
import 'otp_verification.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 32.h),
                Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color(0xff557669),
                    fontSize: 42.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xff557669),
                    fontSize: 42.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Enter your Phone Number",
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "We will send you the 4 digit",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  "verification code",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone,
                  
                  controller: Get.find<UserController>().controller,
                  labelText: 'Contact ',
                  prefixText: '+91',
                  
                ),
                SizedBox(
                  height: 25.h,
                ),
                CustomRegistration(
                 
                  buttonText: "Generate Otp",
                  ontap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => OtpVerification(),));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
