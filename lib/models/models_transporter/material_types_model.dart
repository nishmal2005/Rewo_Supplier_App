class TransporterMaterialTypesModel {
  final int id;
  final String name;

  TransporterMaterialTypesModel({required this.id, required this.name});

  factory TransporterMaterialTypesModel.fromMap(Map<String, dynamic> map) {
    return TransporterMaterialTypesModel(id: map["id"] ??map["material_id"]?? 0, name: map["name"] ??map["material_name"]?? "");
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() => 'SimplifiedMaterialModel(id: $id, name: $name)';
}
