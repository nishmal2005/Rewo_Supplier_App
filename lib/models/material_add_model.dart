import 'package:flutter/material.dart';

class MaterialAddModel {
  final int? id;
  TextEditingController textEditingController=TextEditingController();
final String? name;
  MaterialAddModel({required this.id,this.name});
  toJson(){
return{"material_type_id":id,"price":double.tryParse(textEditingController.text)};
  }
}
