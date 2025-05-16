import 'package:flutter/material.dart';
import 'package:rewo_supplier/models/user_model.dart';

class BankDetailsCreateModel {
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController branchNameControler = TextEditingController();
  TextEditingController upiIdControler = TextEditingController();
  // List<MaterialTypesbank_name> selectedMaterialTypes = [];

  Map<String, dynamic> toJson(int? supplierId) {
    return {
      "supplier_id": supplierId,
      "account_holder_name": accountHolderNameController.text,
      "account_number": accountNumberController.text,
      "bank_name": bankNameController.text,
      "ifsc_code": ifscCodeController.text,
      "branch_name": branchNameControler.text,
      "upi_id": upiIdControler.text
      // "material_carried": selectedMaterialTypes.map((e) => e.id).toList(),
    };
  }

  void dispose() {
    accountHolderNameController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    branchNameControler.dispose();
    ifscCodeController.dispose();
    upiIdControler.dispose();
    // No need to dispose location because it's not a controller
  }

  UserModel fromRegistration(UserModel userModel) {
    return userModel.copyWith(
      bankDetails: BankDetails(
          accountHolderName: accountHolderNameController.text,
          accountNumber: accountNumberController.text,
          bankName: bankNameController.text,
          branchName: branchNameControler.text,
          ifscCode: ifscCodeController.text),
      registrationStatus: RegistrationStatus.bankDetailsUploaded,
      updatedAt: DateTime.now(),
    );
  }
}
