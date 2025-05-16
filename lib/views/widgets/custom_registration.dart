import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rewo_supplier/configs/assets.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';

class CustomRegistration extends StatelessWidget {
  final Function()? ontap;
  final String buttonText;
  CustomRegistration({
    this.ontap,
    required this.buttonText,
    Key? key,
  }) : super(key: key);
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 270.w,
        height: 50.h,
        margin: EdgeInsets.only(top: 10.h),
        decoration: BoxDecoration(
          color: Color(0xff557669),
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Obx(
          () => Center(
            child: userController.isLoading.value
                ? Lottie.asset(Assets.loader, height: 50.h)
                : Text(
                    buttonText,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
