import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/views/widgets/camera_or_gallery_popup.dart';
import '../views/widgets/custom_text_form_field.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Column(
        children: [
          Text(
            "Register",
            style: TextStyle(
              color: Color(0xff557669),
              fontSize: 42.dg,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "upload documents",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24.dg,
              fontWeight: FontWeight.w400,
            ),
          ),

          /// RC Image
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget: _buildImagePreview(controller.documentsModel.rcImage),
            labelText: 'Gst Certificate',
            hintText: controller.documentsModel.rcImage?.path.split("/").last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.rcImage = file;
                }, source);
              });
            },
          ),

          /// Insurance Image
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget:
                _buildImagePreview(controller.documentsModel.insuranceImage),
            labelText: 'Company Registration',
            hintText:
                controller.documentsModel.insuranceImage?.path.split("/").last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.insuranceImage = file;
                }, source);
              });
            },
          ),


          SizedBox(height: 10.h),
        ],
      );
    });
  }

  Widget? _buildImagePreview(File? imageFile) {
    if (imageFile == null) return null;
    return InkWell(
      onTap: () {
        OpenFile.open(imageFile.path);
      },
      child: Row(
        children: [
          SizedBox(width: 5),
          CircleAvatar(
            backgroundImage: FileImage(imageFile),
            radius: 15,
          ),
        ],
      ),
    );
  }
}
