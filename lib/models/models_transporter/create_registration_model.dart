import 'package:flutter/material.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';
import 'package:rewo_supplier/models/models_transporter/transporter_model.dart';

class TransporterModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerContactController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  Location? location;

  Map<String, dynamic> toJson(int? id) {
    return {
      if (id != null) ...{
        "transporter_id": id,
      },
      "name": nameController.text,
      "contact_number": "+91${contactNumberController.text}",
      "owner_name": ownerNameController.text,
      "owner_contact": "+91${ownerContactController.text}",
      "company_name": companyNameController.text,
      "location": location?.toJson(),
    };
  }

  void dispose() {
    nameController.dispose();
    contactNumberController.dispose();
    ownerNameController.dispose();
    ownerContactController.dispose();
    companyNameController.dispose();
    // No need to dispose location because it's not a controller
  }

  void assignFromUserModel(UserModel userModel) {
    nameController.text = userModel.name ?? '';
    contactNumberController.text =
        userModel.contactNumber?.replaceFirst('+91', '') ?? '';
    ownerNameController.text = userModel.ownerName ?? '';
    ownerContactController.text =
        userModel.ownerContact?.replaceFirst('+91', '') ?? '';
    companyNameController.text = userModel.companyName ?? '';

    location = userModel.location;
  }

  UserModel fromRegistration(UserModel userModel) {
    return userModel.copyWith(
      name: nameController.text,
      contactNumber: contactNumberController.text,
      ownerName: ownerNameController.text,
      ownerContact: ownerContactController.text,
      companyName: companyNameController.text,
      // Assuming you have locationId separately, otherwise leave it null
      location: location,
      registrationStatus: RegistrationStatus
          .transportersUploaded, // or whatever status you want
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

