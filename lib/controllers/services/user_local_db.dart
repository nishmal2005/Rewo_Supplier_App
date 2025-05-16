import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:rewo_supplier/models/user_model.dart';

class UserLocalDb {
  static const String boxName = 'userBox';

  static Future<void> saveData(UserModel userModel) async {
    var box = Hive.box<UserModel>(boxName);

    try {
        log(userModel.name??"",name: "userData");
      await box.put('userData', userModel);
    
    } catch (e) {
      log(e.toString(),name: "UserData");
    }
  }

  static UserModel? loadData() {
    var box = Hive.box<UserModel>(boxName);
    UserModel? userModel = box.get('userData');
log(userModel?.registrationStatus.toString()??"");
    return userModel;
  }

  static Future<void> deleteData() async {
    var box = Hive.box<UserModel>(boxName);

    try {
      await box.delete('userData');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
