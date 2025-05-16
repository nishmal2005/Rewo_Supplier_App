import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';
import 'package:rewo_supplier/controllers/services/location_services.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';
import 'package:rewo_supplier/views/widgets/bottom_loader.dart';

class LocationController extends GetxController {
  LocationServices locationServices = LocationServices();
  BasicState getCurrentLocationState = BasicState.initial;

  BasicState getSuggestedLocationState = BasicState.initial;
  List<Suggestion> suggessions = [];
  Location? currentLocation;
  bool serviceEnabled = true;
  bool permissionEnabled = true;

  final TextEditingController controller = TextEditingController();
  @override
  void onInit() {
    onGetLocation();
    super.onInit();
  }

  @override
  dispose() {
    super.dispose();
    controller.dispose();
  }

  onSuggessionClick(int index) {
    if (Get.context != null) {
      bottomLoader(Get.context!);
    }

    locationServices.getCurrentLocationFromAddress(
      suugession: suggessions[index],
      onSuccess: (location) {
        
        Get.find<UserController>().updateLocation(location);
        if (Get.context != null) {
          Get.back();
           Get.back();
        }

      },
      onError: (e) {
        Get.snackbar(
          "", // Title of the Snackbar
          e.toString(), // Message of the Snackbar
          snackPosition: SnackPosition
              .BOTTOM, // Where to show the Snackbar (TOP or BOTTOM)
          backgroundColor: Colors.black,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      },
    );
  }

  onGetSuggetions() async {
    getSuggestedLocationState = BasicState.loading;
    update();
    if (controller.text.length < 4) {
      return;
    }
    try {
      final value = await locationServices.fetchSuggestions(controller.text);
      suggessions = value;
      getSuggestedLocationState = BasicState.done;
      update();
    } catch (e) {
      getSuggestedLocationState = BasicState.done;
      update();
      log(e.toString());
    }
  }

  onGetLocation({
    bool requestPermission = true,
    bool requestService = true,
  }) async {
    getCurrentLocationState = BasicState.loading;
    permissionEnabled = true;
    serviceEnabled = true;
    update();
    await locationServices.getCurrentLocation(
      needRequestServices: requestService,
      needRequstPermission: requestPermission,
      onServiceNotEnabled: () {
        getCurrentLocationState = BasicState.error;
        serviceEnabled = false;
        update();
      },
      onPermissionNotEnabled: () {
        getCurrentLocationState = BasicState.error;
        permissionEnabled = false;
        update();
      },
      onError: (e) {
        getCurrentLocationState = BasicState.error;
        update();
      },
      onSuccess: (locationVal) {
        getCurrentLocationState = BasicState.done;
        currentLocation = locationVal;
        permissionEnabled = true;
        serviceEnabled = true;
        update();
      },
    );
  }
}
