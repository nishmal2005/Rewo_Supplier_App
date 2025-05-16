import 'package:flutter/material.dart';
import 'package:rewo_supplier/models/user_model.dart';

class TransporterModel {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerContactController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  
  Location? location;

  Map<String, dynamic> toJson() {
    return {
      "name": nameController.text,
      "contact_number":"+91${contactNumberController.text}",
      "company_name": companyNameController.text,
      "gst_number": gstNumberController.text,
      "owner_name": ownerNameController.text,
      "owner_contact_number":"+91${ownerContactController.text}",
      "latitude": location?.latitude,
      "longitude": location?.longitude,
      "address": location?.address,
    };
  }

  void dispose() {
    nameController.dispose();
    contactNumberController.dispose();
    ownerNameController.dispose();
    ownerContactController.dispose();
    companyNameController.dispose();
    gstNumberController.dispose();
    // No need to dispose location because it's not a controller
  }

  UserModel fromRegistration(UserModel userModel) {
    return userModel.copyWith(
      name: nameController.text,
      contactNumber: contactNumberController.text,
      ownerName: ownerNameController.text,
      ownerContact: ownerContactController.text,
      companyName: companyNameController.text,
      gstNumber: gstNumberController.text,
      location: location,
      registrationStatus: RegistrationStatus.supplierUploaded,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  void assignFromUserModel(UserModel userModel) {}
}

class Location {
  double latitude;
  double longitude;
  String? address;

  Location({required this.latitude, required this.longitude, required this.address});

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
    );
  }
}
