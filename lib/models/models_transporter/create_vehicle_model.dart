import 'package:flutter/material.dart';
import 'package:rewo_supplier/models/models_transporter/material_types_model.dart';

import 'transporter_model.dart';

class VehicleModel {
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehiclemanufacturerController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController loadWeightController = TextEditingController();
  TextEditingController loadVolumeControler = TextEditingController();

  List<TransporterMaterialTypesModel> selectedMaterialTypes = [];

  Map<String, dynamic> toJson(int? transporterId,
  int?vehicleId) {
    return {
      "vehicle_id":vehicleId,
      "transporter_id": transporterId,
      "vehicle_number": vehicleNumberController.text,
      "manufacturer": vehiclemanufacturerController.text,
      "model": modelController.text,
      "load_capacity_volume": double.tryParse(loadVolumeControler.text) ?? 0,
      "load_capacity_weight": double.tryParse(loadWeightController.text) ?? 0,
      "material_carried": selectedMaterialTypes.map((e) => e.id).toList(),
    };
  }

  void dispose() {
    vehicleNumberController.dispose();
    vehiclemanufacturerController.dispose();
    loadWeightController.dispose();
    loadVolumeControler.dispose();
    modelController.dispose();

    // No need to dispose location because it's not a controller
  }
void assignFromUserModel(UserModel userModel) {
    vehicleNumberController.text = userModel.vehicleNumber ?? '';
    vehiclemanufacturerController.text = userModel.manufacturer ?? '';
    modelController.text = userModel.model ?? '';
    loadVolumeControler.text = userModel.loadCapacityVolume?.toString() ?? '';
    loadWeightController.text = userModel.loadCapacityWeight?.toString() ?? '';
    selectedMaterialTypes = userModel.materials ?? [];
  }

  UserModel fromRegistration(UserModel userModel) {
    return userModel.copyWith(
      
      loadCapacityVolume: loadVolumeControler.text,
      loadCapacityWeight: loadWeightController.text,
      vehicleNumber: vehicleNumberController.text,
      materials: selectedMaterialTypes,
      model: modelController.text,
      manufacturer: vehiclemanufacturerController.text,
      registrationStatus: RegistrationStatus
          .vehicleUploaded, // or whatever status you want
      updatedAt: DateTime.now(),
    );
  }
}
