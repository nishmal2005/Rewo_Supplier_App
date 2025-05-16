import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewo_supplier/configs/constants.dart';
import 'package:rewo_supplier/controllers/implementations/material_controller.dart';
import 'package:rewo_supplier/controllers/services/api_requests.dart';
import 'package:rewo_supplier/controllers/services/user_local_db.dart';
import 'package:rewo_supplier/hive/hive_registrar.g.dart';
// import 'package:rewo_supplier/models/create_pricing_model.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';
import 'package:rewo_supplier/models/create_vehicle_model.dart';
import 'package:rewo_supplier/models/material_add_model.dart';
import 'package:rewo_supplier/models/models_transporter/create_pricing_model.dart';
// import 'package:rewo_supplier/models/create_vehicle_model.dart';
// import 'package:rewo_supplier/models/material_types_model.dart';
import 'package:rewo_supplier/models/upload_documents_model.dart';
import 'package:rewo_supplier/models/user_model.dart';
import 'package:rewo_supplier/screens/details_tab.dart';
import 'package:rewo_supplier/screens/home_screen.dart';
import 'package:rewo_supplier/screens/login_page.dart';
import 'package:rewo_supplier/screens/navigation_screen_ins.dart';

class UserController extends GetxController {
  RxBool isLoading = false.obs;
  final formKeyTansporter = GlobalKey<FormState>();
  TransporterModel transporterModel = TransporterModel();

  VehicleDocumentUploadModel documentsModel = VehicleDocumentUploadModel();
  final formKeyVehicle = GlobalKey<FormState>();
  // VehicleModel vehicleModel = VehicleModel();
    List<CreatePricingModel> createPricingModels = [
    CreatePricingModel(from: 0, to: 5),
    CreatePricingModel(from: 0, to: 15),
    CreatePricingModel(from: 0, to: 30),
    CreatePricingModel(from: 30, to: null),
  ];
  BankDetailsCreateModel bankDetailsCreateModel = BankDetailsCreateModel();
  List<MaterialAddModel> materilas = [];
  RxInt selectedTab = 0.obs;
  @override
  void onInit() async {
    await Hive.initFlutter();
    Hive.registerAdapters();
    await Hive.openBox<UserModel>(UserLocalDb.boxName);
    getUser();
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    transporterModel.dispose();
    bankDetailsCreateModel.dispose();
    // for (var element in createPricingModels) {
    //   element.priceController.dispose();
    // }
    super.onClose();
  }

  UserModel? userData;
  final TextEditingController controller = TextEditingController();
  @override
  dispose() {
    super.dispose();
    transporterModel.dispose();
    bankDetailsCreateModel.dispose();
    controller.dispose();
    for (var element in materilas) {
      element.textEditingController.dispose();
    }
  }

  getUser() {
    UserModel? userModel = UserLocalDb.loadData();
    userData = userModel;
    Future.delayed(const Duration(seconds: 2), () {
      navigateSpecific();
    });
    update();
  }

  updateLocation(Location? location) {
    transporterModel.location = location;
    formKeyTansporter.currentState?.validate();
    update();
  }

  navigateSpecific() {
    if (userData == null) {
      Get.to(() => LoginPage());
      return;
    }

    final tabIndexMap = {
      RegistrationStatus.pending: 0,
      RegistrationStatus.supplierUploaded: 1,
      RegistrationStatus.bankDetailsUploaded: 2,
      RegistrationStatus.materialsUploaded: 3,
    };

    final index = tabIndexMap[userData?.registrationStatus];

    if (index != null) {
      selectedTab.value = index;
      Get.to(() => DetailsTab());
    } else {
      Get.to(() => OrdersListScreen());
    }
  }

  onLogin() {
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.login,
      {"contact_number": "+91${controller.text}"},
      onSuccess: (res) {
        log(res.data.toString());
        isLoading.value = false;
        userData = UserModel.fromJson(res.data["data"]);

        UserLocalDb.saveData(userData!);
        log(userData?.registrationStatus.toString() ?? "Null");
        update();
        navigateSpecific();
      },
      onNotFound: (response) {
        isLoading.value = false;
        userData = UserModel(registrationStatus: RegistrationStatus.pending);
        UserLocalDb.saveData(userData!);
        Get.to(() => DetailsTab());
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "", // Title of the Snackbar
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

  uploadRgistration() {
    if (selectedTab.value == 0) {
      onRegisterSupplier();
    } else if (selectedTab.value == 1) {
      onBankDetails();
    } else if (selectedTab.value == 2) {
      onUploadPricing();
    }
     else if (selectedTab.value == 3) {
      onUploadDocuments();
    }
  }

  onRegisterSupplier() async {
    if (isLoading.value ||
        formKeyTansporter.currentState?.validate() == false) {
      return;
    }
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.register,
      transporterModel.toJson(),
      onSuccess: (res) {
        isLoading.value = false;
        if (userData != null) {
          userData = transporterModel.fromRegistration(userData!.copyWith(
              id: res.data["data"]["supplierId"],
              token: res.data["data"]["token"],
              locationId: res.data["data"]["location_id"]));
          UserLocalDb.saveData(userData!);
          final simplifiedList = (res.data["data"]["materials"] as List)
              .map((item) => MaterialTypesModel.fromJson(item))
              .toList();
          update();

          final materialController =
              Get.put(MaterialController(materialGet: false));
          materialController.updateMaterial(simplifiedList);

          selectedTab.value = 1;
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

  onBankDetails() async {
    if (isLoading.value || formKeyVehicle.currentState?.validate() == false) {
      return;
    }
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.bankAdd,
      bankDetailsCreateModel.toJson(userData?.id),
      onSuccess: (res) {
        if (userData != null) {
          userData = bankDetailsCreateModel.fromRegistration(userData!);
          UserLocalDb.saveData(userData!);
          selectedTab.value = 2;
        }

        isLoading.value = false;
        update();
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "Bank Details Upload Failed", // Title of the Snackbar
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

  onUploadDocuments() async {
    // if (isLoading.value || formKeyVehicle.currentState?.validate() == false) {
    //   return;
    // }
    isLoading.value = true;
    ApiRequests.postWithMedia(
      Constants.uploadDocuments,
      await documentsModel.toFormData(userData?.id),
      onSuccess: (res) {
        if (userData != null) {
          UserLocalDb.saveData(userData!.copyWith(
              documents: res.data["data"] is Map
                  ? userData?.documents?.CopyWith(
                        SupllierMedia.fromJson(res.data["data"]),
                      ) ??
                      SupllierMedia.fromJson(res.data["data"])
                  : null,
              registrationStatus: RegistrationStatus.documentsUploaded));
          Get.to(()=>BottomNavScreen());
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

  onUploadPricing() async {
    if (isLoading.value ||
        materilas.any(
          (element) => element.textEditingController.text.isEmpty,
        )) {
      UserLocalDb.loadData();
      Get.snackbar(
        "Material Updation Failed", // Title of the Snackbar
        "Price fields required", // Message of the Snackbar
        snackPosition:
            SnackPosition.BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
        backgroundColor: Colors.black,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      return;
    }
    isLoading.value = true;
    ApiRequests.postRequest(
      Constants.uploadMaterials,
      {
        "supplier_id": userData?.id,
        "materials": materilas
            .map(
              (e) => e.toJson(),
            )
            .toList()
      },
      onSuccess: (res) {
        if (userData != null) {
          userData!.copyWith(
              materials: res.data["data"] is List
                  ? (res.data["data"] as List)
                      .map(
                        (e) => MaterialTypesModel.fromJson(e),
                      )
                      .toList()
                  : null);
          userData!.registrationStatus = RegistrationStatus.materialsUploaded;
          update();
          UserLocalDb.saveData(userData!);
          selectedTab.value = 3;
        }

        isLoading.value = false;
      },
      onFailure: (error) {
        isLoading.value = false;
        Get.snackbar(
          "Material Updation Failed", // Title of the Snackbar
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
