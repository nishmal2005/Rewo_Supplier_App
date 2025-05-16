import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:rewo_supplier/views/widgets/camera_or_gallery_popup.dart';
import 'package:rewo_supplier/views/widgets/custom_text.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';

import '../../controllers/implementations/transporter_controller.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransporterController>(builder: (controller) {
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
            labelText: 'RC Image',
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
            labelText: 'Insurance Image',
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

          /// Driving Licence
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget: _buildImagePreview(
                controller.documentsModel.drivingLicenceImage),
            labelText: 'Driving Licence Image',
            hintText: controller.documentsModel.drivingLicenceImage?.path
                .split("/")
                .last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.drivingLicenceImage = file;
                }, source);
              });
            },
          ),

          /// Vehicle Video (No preview here)
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            labelText: 'Vehicle Video',
            prefixWidget: controller.documentsModel.vehicleVideo?.path == null
                ? null
                : InkWell(
                    onTap: () {
                      OpenFile.open(
                          controller.documentsModel.vehicleVideo?.path);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black,
                          child: CustomText(
                            text: "V",
                            fontColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
            hintText:
                controller.documentsModel.vehicleVideo?.path.split("/").last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickVideo((file) {
                  controller.documentsModel.vehicleVideo = file;
                }, source);
              });
            },
          ),

          /// Vehicle Front
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget:
                _buildImagePreview(controller.documentsModel.vehicleFrontImage),
            labelText: 'Vehicle Front Image',
            hintText: controller.documentsModel.vehicleFrontImage?.path
                .split("/")
                .last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.vehicleFrontImage = file;
                }, source);
              });
            },
          ),

          /// Vehicle Back
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget:
                _buildImagePreview(controller.documentsModel.vehicleBackImage),
            labelText: 'Vehicle Back Image',
            hintText: controller.documentsModel.vehicleBackImage?.path
                .split("/")
                .last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.vehicleBackImage = file;
                }, source);
              });
            },
          ),

          /// Vehicle Left
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget:
                _buildImagePreview(controller.documentsModel.vehicleLeftImage),
            labelText: 'Vehicle Left Image',
            hintText: controller.documentsModel.vehicleLeftImage?.path
                .split("/")
                .last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.vehicleLeftImage = file;
                }, source);
              });
            },
          ),

          /// Vehicle Right
          CustomTextField(
            keyboardType: TextInputType.name,
            suffixIcon: Icons.file_upload_outlined,
            prefixWidget:
                _buildImagePreview(controller.documentsModel.vehicleRightImage),
            labelText: 'Vehicle Right Image',
            hintText: controller.documentsModel.vehicleRightImage?.path
                .split("/")
                .last,
            readOnly: true,
            ontap: () {
              popupCameraOrGallery((source) {
                controller.pickImage((file) {
                  controller.documentsModel.vehicleRightImage = file;
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
