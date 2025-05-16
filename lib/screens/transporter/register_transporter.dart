import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/transporter_controller.dart';
import 'package:rewo_supplier/screens/transporter/location_screen.dart';
import 'package:rewo_supplier/views/widgets/custom_text_form_field.dart';


class RegisterTransporter extends StatelessWidget {
  RegisterTransporter({super.key});

  final controller = Get.find<TransporterController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyTansporter,
      child: Column(
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
            "Transporter",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24.dg,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),

          // Driver name
          CustomTextField(
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person,
            
            
            controller: controller.transporterModel.nameController,
            labelText: 'Driver name',
            
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Driver name is required'
                : null,
          ),

          // Contact number
          CustomTextField(
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
            
            
            controller: controller.transporterModel.contactNumberController,
            labelText: 'Contact',
            prefixText: '+91 ',
            maxLength: 10,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Contact number is required';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
          ),

          // Company Name
          CustomTextField(
            keyboardType: TextInputType.name,
            prefixIcon: Icons.assured_workload,
            
            
            controller: controller.transporterModel.companyNameController,
            labelText: 'Company Name',
            
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Company name is required'
                : null,
          ),

          // Location Picker
          GetBuilder<TransporterController>(
            builder: (controller) {
              return CustomTextField(
                readOnly: true,
                keyboardType: null,
                prefixIcon: Icons.location_city,
                
                
                ontap: () {
                  Get.to(() => LocationScreen());
                },
                labelText: 'Location',
                
                hintText: controller.transporterModel.location?.address ??
                    "Please Select a Location",
                validator: (_) {
                  if (controller.transporterModel.location?.address == null) {
                    return 'Location is required';
                  }
                  return null;
                },
              );
            },
          ),

          // Owner Name
          CustomTextField(
            keyboardType: TextInputType.name,
            prefixIcon: Icons.person,
            
            
            controller: controller.transporterModel.ownerNameController,
            labelText: 'Owner Name',
            
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Owner name is required'
                : null,
          ),

          // Owner Contact
          CustomTextField(
            keyboardType: TextInputType.phone,
            prefixIcon: Icons.phone,
            
            
            controller: controller.transporterModel.ownerContactController,
            labelText: 'Owner Contact',
            prefixText: '+91 ',
            maxLength: 10,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Owner contact is required';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value.trim())) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
