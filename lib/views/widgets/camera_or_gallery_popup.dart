import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:rewo_supplier/configs/app_colors.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';

void popupCameraOrGallery(Function(ImageSource) onTap) {
  Get.bottomSheet(
    Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back(); // Close the bottom sheet
                onTap(ImageSource.gallery);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.kPrimaryColor1,
                    radius: 30,
                    child: Icon(
                      Icons.photo,
                      size: 25,
                      color: AppColors.kWhite,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomText(text: "Gallery", fontColor: AppColors.kLabelColor),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back(); // Close the bottom sheet
                onTap(ImageSource.camera);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.kPrimaryColor1,
                    radius: 30,
                    child: Icon(
                      Icons.camera_alt_sharp,
                      size: 25,
                      color: AppColors.kWhite,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomText(text: "Camera", fontColor: AppColors.kLabelColor),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}
