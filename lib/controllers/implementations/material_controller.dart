import 'dart:developer';

import 'package:get/get.dart';
import 'package:rewo_supplier/configs/constants.dart';
import 'package:rewo_supplier/configs/enums.dart';
import 'package:rewo_supplier/controllers/services/api_requests.dart';
import 'package:rewo_supplier/models/models_transporter/material_types_model.dart';
import 'package:rewo_supplier/models/user_model.dart';

class MaterialController extends GetxController {
  final bool materialGet;

  List<MaterialTypesModel> materials = [];
  bool materialClicked = false;
  final bool rewoMaterialCode;

  List<TransporterMaterialTypesModel> transporterMaterials = [];
  bool transportermaterialClicked = false;

  BasicState getMaterialState = BasicState.initial;
  BasicState getTranspoerMaterialState = BasicState.initial;

  MaterialController({this.materialGet = true, this.rewoMaterialCode = true});
  updateMaterial(List<MaterialTypesModel> value) {
    materials = value;
    update();
  }

  onGetMaterials() async {
    getMaterialState = BasicState.loading;
    update();

    try {
      final res = await ApiRequests.getRequest(Constants.getMaterials);
      log(res.data.toString());
      materials = (res.data["data"] as List)
          .map((item) => MaterialTypesModel.fromJson(item))
          .toList();
      getMaterialState = BasicState.done;
      update();
    } catch (e) {
      getMaterialState = BasicState.error;
      update();
      // log(e.toString());
    }
  }

  updateMaterialTransporter(List<TransporterMaterialTypesModel> value) {
    transporterMaterials = value;
    update();
  }

  onGetMaterialsTransporter() async {
    getTranspoerMaterialState = BasicState.loading;
    update();

    try {
      final res =
          await ApiRequests.getRequest(Constants.getMaterialsTransporter);

      transporterMaterials = (res.data["data"] as List)
          .map((item) => TransporterMaterialTypesModel.fromMap(item))
          .toList();
      getTranspoerMaterialState = BasicState.done;
      update();
    } catch (e) {
      getTranspoerMaterialState = BasicState.error;
      update();
      log(e.toString());
    }
  }

  @override
  void onInit() {
    if (materialGet) {
      onGetMaterials();
    }
    super.onInit();
  }
}
