import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewo_supplier/configs/constants.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/implementations/material_controller.dart';
import 'package:rewo_supplier/controllers/services/api_requests.dart';
import 'package:rewo_supplier/models/create_registration_model.dart'
    hide TransporterModel;
import 'package:rewo_supplier/models/models_transporter/create_pricing_model.dart';
import 'package:rewo_supplier/models/models_transporter/create_registration_model.dart';
import 'package:rewo_supplier/models/models_transporter/create_vehicle_model.dart';
import 'package:rewo_supplier/models/models_transporter/material_types_model.dart';
import 'package:rewo_supplier/models/models_transporter/transporter_model.dart';
import 'package:rewo_supplier/models/models_transporter/upload_documents_model.dart';
import 'package:rewo_supplier/screens/transporter/details_tab.dart';
import 'package:rewo_supplier/screens/transporter/profile.dart';

class TransporterController extends GetxController {
  BasicState getTransportersState = BasicState.initial;
  RxBool isLoading = false.obs;
  final formKeyTansporter = GlobalKey<FormState>();
  TransporterModel transporterModel = TransporterModel();
  List<CreatePricingModel> createPricingModels = [
    CreatePricingModel(from: 0, to: 5),
    CreatePricingModel(from: 0, to: 15),
    CreatePricingModel(from: 0, to: 30),
    CreatePricingModel(from: 30, to: null),
  ];
  VehicleDocumentUploadModel documentsModel = VehicleDocumentUploadModel();
  final formKeyVehicle = GlobalKey<FormState>();
  VehicleModel vehicleModel = VehicleModel();
  RxInt selectedTab = 0.obs;
  @override
  void onInit() async {
    getTransporters();
    super.onInit();
  }

  assignFromPriceRanges() {
    // Define the default pricing slots
    final defaultRanges = [
      CreatePricingModel(from: 0, to: 5),
      CreatePricingModel(from: 0, to: 15),
      CreatePricingModel(from: 0, to: 30),
      CreatePricingModel(from: 30, to: null),
    ];

    // Extract existing models from userData
    final existing = userData?.priceRanges?.map((e) {
          final model =
              CreatePricingModel(from: e.from ?? 0, to: e.to, id: e.id);
          model.priceController.text = e.price?.toString() ?? '';
          return model;
        }).toList() ??
        [];

    // Add missing default models
    for (final def in defaultRanges) {
      final alreadyExists = existing.any(
        (e) => e.from == def.from && e.to == def.to,
      );
      if (!alreadyExists) {
        existing.add(CreatePricingModel(from: def.from, to: def.to));
      }
    }

    createPricingModels = existing;
    update();
  }

  @override
  void onClose() {
    controller.dispose();
    transporterModel.dispose();
    vehicleModel.dispose();
    for (var element in createPricingModels) {
      element.priceController.dispose();
    }
    super.onClose();
  }

  List<UserModel> transpoters = [];
  UserModel? userData;
  final TextEditingController controller = TextEditingController();
  @override
  dispose() {
    super.dispose();
    transporterModel.dispose();
    vehicleModel.dispose();
    controller.dispose();
    for (var element in createPricingModels) {
      element.priceController.dispose();
    }
  }

  getTransporters() async {
    getTransportersState = BasicState.loading;
    update();
    try {
      final data = await ApiRequests.getRequest(
        "get-transpoter",
      );
      log(data.data.toString());
      transpoters = (data.data["data"] as List)
          .map(
            (e) => UserModel.fromJson(e),
          )
          .toList();
      getTransportersState = BasicState.done;
      update();
    } catch (e) {
      getTransportersState = BasicState.error;
      update();
    }
  }

  updateLocation(Location? location) {
    transporterModel.location = location;
    formKeyTansporter.currentState?.validate();
    update();
  }

  navigateSpecific() {
    if (userData == null) {
      return;
    }

    final tabIndexMap = {
      RegistrationStatus.pending: 0,
      RegistrationStatus.transportersUploaded: 1,
      RegistrationStatus.vehicleUploaded: 2,
      RegistrationStatus.vehicleDocumentsUploaded: 3,
    };

    final index = tabIndexMap[userData?.registrationStatus];

    if (index != null) {
      selectedTab.value = index;
      Get.to(() => DetailsTab());
    } else {
      Get.to(() => TransporterProfileScreen());
    }
  }

  uploadRgistration({bool edit = false, required int index}) {
    log(edit.toString());
    if (selectedTab.value == 0) {
      onRegisterTansporter(edit: edit, index: index);
    } else if (selectedTab.value == 1) {
      onRegisterVehicle(
        edit: edit,
        index: index,
      );
    } else if (selectedTab.value == 2) {
      onUploadDocuments(
        edit: edit,
        index: index,
      );
    } else if (selectedTab.value == 3) {
      onUploadPricing(
        edit: edit,
        index: index,
      );
    }
  }

  onRegisterTansporter({bool edit = false, required int index}) async {
    if (isLoading.value ||
        formKeyTansporter.currentState?.validate() == false) {
      return;
    }
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.transporteRegister,
      transporterModel.toJson(userData?.id),
      onSuccess: (res) {
        isLoading.value = false;
        if (userData != null) {
          userData = transporterModel.fromRegistration(userData!.copyWith(
              id: res.data?["data"]?["transporter"],
              token: res.data?["data"]?["token"],
              locationId: res.data?["data"]?["location_id"]));
          if (!edit) {
            transpoters.insert(index, userData!);
          } else {
            transpoters[index] = userData!;
          }
          final simplifiedList = (res.data["data"]["materials"] as List)
              .map((item) => TransporterMaterialTypesModel.fromMap(item))
              .toList();
          update();

          final materialController =
              Get.put(MaterialController(materialGet: false));
          materialController.updateMaterialTransporter(simplifiedList);
          if (edit) {
            Get.back();
          } else {
            selectedTab.value = 1;
          }
        }
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "User Registration Failed", // Title of the Snackbar
          error, // Message of the Snackbar
          snackPosition: SnackPosition
              .BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      },
    );
  }

  Future<void> pickVideo(
      Function(File file) onPicked, ImageSource source) async {
    final picked = await ImagePicker().pickVideo(source: source);
    if (picked != null) {
      onPicked(File(picked.path));
      update();
    }
  }

  Future<void> pickImage(
      Function(File file) onPicked, ImageSource source) async {
    final picked = await ImagePicker().pickImage(source: source);
    if (picked != null) {
      onPicked(File(picked.path));
      update();
    }
  }

  onRegisterVehicle({bool edit = false, required int index}) async {
    if (isLoading.value || formKeyVehicle.currentState?.validate() == false) {
      return;
    }

    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.vehicleAdd,
      vehicleModel.toJson(userData?.id, userData?.vehicleId),
      onSuccess: (res) {
        if (userData != null) {
          userData = vehicleModel.fromRegistration(
              userData!.copyWith(vehicleId: res.data?["data"]));
          transpoters[index] = userData!;
          if (edit) {
            Get.back();
          } else {
            selectedTab.value = 2;
          }
        }

        isLoading.value = false;
        update();
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "Vehicle Registraion Failed", // Title of the Snackbar
          error, // Message of the Snackbar
          snackPosition: SnackPosition
              .BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      },
    );
  }

  onUploadDocuments({bool edit = false, required int index}) async {
    if (isLoading.value) {
      return;
    }
    isLoading.value = true;
    ApiRequests.postWithMedia(
      Constants.uploadTransporterDocuments,
      await documentsModel.toFormData(userData?.vehicleId),
      onSuccess: (res) {
        if (userData != null) {
          userData = userData!.copyWith(
              documents: res.data["data"] is Map
                  ? userData?.documents?.copyWithVehicleMedia(
                        VehicleMedia.fromJson(res.data["data"]),
                      ) ??
                      VehicleMedia.fromJson(res.data["data"])
                  : null,
              registrationStatus: RegistrationStatus.vehicleDocumentsUploaded);
          transpoters[index] = userData!;
          update();
          if (edit) {
            Get.back();
          } else {
            selectedTab.value = 3;
          }
        }

        isLoading.value = false;
        update();
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "Documents Upload Failed", // Title of the Snackbar
          error, // Message of the Snackbar
          snackPosition: SnackPosition
              .BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      },
    );
  }

  onUploadPricing({bool edit = false, required int index}) async {
    if (isLoading.value || formKeyVehicle.currentState?.validate() == false) {
      return;
    }
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.uploadPricing,
      {
        "vehicle_id": userData?.vehicleId,
        "transporter_id": userData?.id,
        "price_ranges": createPricingModels
            .map(
              (e) => e.toJson(),
            )
            .toList()
      },
      onSuccess: (res) {
        if (userData != null) {
          userData = userData!.copyWith(
              registrationStatus: RegistrationStatus.pricingUploaded,
              range: res.data["data"] is List
                  ? (res.data["data"] as List)
                      .map(
                        (e) => PriceRange.fromJson(e),
                      )
                      .toList()
                  : null);
          transpoters[index] = userData!;
          update();

          if (edit) {
            Get.back();
          } else {}
        }

        isLoading.value = false;
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "Pricing Updation Failed", // Title of the Snackbar
          error, // Message of the Snackbar
          snackPosition: SnackPosition
              .BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      },
    );
  }
}
