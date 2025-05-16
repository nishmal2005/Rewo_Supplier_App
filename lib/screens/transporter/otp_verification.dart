import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/views/widgets/custom_registration.dart';


class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 80.h,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 260.h,
                  width: 260.h,
                  child: Image.asset(
                    'assets/image/arcticons_otp-authenticator.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Enter the OTP sent to +91 ${Get.find<UserController>().controller.text}",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 17.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Pinput(
                  length: 4, // 4-digit OTP
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: TextStyle(
                        fontSize: 24, color: Colors.white), // Text color
                    decoration: BoxDecoration(
                      color: Color(0xFFB0C4B1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: TextStyle(fontSize: 24, color: Colors.black),
                    decoration: BoxDecoration(
                      color: Color(0xFF9EB3A7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  onCompleted: (pin) {
                    print("Entered OTP: $pin");
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 94),
                  child: Row(
                    children: [
                      Text(
                        "Didn’t receive OTP?",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        " Resend",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<UserController>().onLogin();
                  },
                  child: CustomRegistration(
                    buttonText: "Verify and proceed",
                  
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
