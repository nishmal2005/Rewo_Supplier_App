import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/controllers/implementations/material_controller.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import '../views/widgets/custom_text_form_field.dart';

class BankDetailsScreen extends StatelessWidget {
  BankDetailsScreen({super.key});
  final materialController = Get.put(MaterialController());
  final controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        Text(
          "Bank",
          style: TextStyle(
              color: Color(0xff557669),
              fontSize: 42.dg,
              fontWeight: FontWeight.w600),
        ),
        Text(
          "Details",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 24.dg,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20.h,
        ),
        CustomTextField(
          keyboardType: TextInputType.name,
          controller:
              controller.bankDetailsCreateModel.accountHolderNameController,
          hideText: "-------",
          labelText: 'Account Holder Name',
        ),
        CustomTextField(
          hideText: "-------",
          keyboardType: TextInputType.name,
          controller: controller.bankDetailsCreateModel.accountNumberController,
          labelText: 'Account Number',
        ),
        CustomTextField(
          keyboardType: TextInputType.name,
          hideText: "-------",
          controller: controller.bankDetailsCreateModel.bankNameController,
          labelText: 'Bank name',
        ),
        CustomTextField(
          controller: controller.bankDetailsCreateModel.ifscCodeController,
          labelText: 'Ifsc Code',
        ),
        CustomTextField(
          controller: controller.bankDetailsCreateModel.branchNameControler,
          labelText: 'Branch Name',
        ),
        CustomTextField(
          controller: controller.bankDetailsCreateModel.upiIdControler,
          labelText: 'Upi Id',
        ),
      ]),
    );
  }
}
