import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/views/widgets/custom_circle_parameter.dart';

bottomLoader(
  BuildContext context, {
  Widget? child,
}) {
  // //sliderBloc?.add(ResetAnimation(submitted: false));
  showModalBottomSheet(
    useSafeArea: true,
    backgroundColor: Colors.white,
    context: context,
    enableDrag: false,
    isDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20.h,
              ),
              if (child == null)
                CircularProgress(
                  speed: true,
                  isPauseed: false,
                  size: 50.w,
                  primaryColor: AppColors.kPrimaryColor1,
                  strokeWidth: 15.w,
                )
              else
                child,
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 20.h,
              )
            ],
          ),
        ),
      );
    },
  );
}
