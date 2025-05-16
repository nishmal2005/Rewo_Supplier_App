// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: (fields[0] as num?)?.toInt(),
      name: fields[1] as String?,
      contactNumber: fields[2] as String?,
      companyName: fields[3] as String?,
      locationId: (fields[4] as num?)?.toInt(),
      gstNumber: fields[21] as String?,
      ownerName: fields[5] as String?,
      ownerContact: fields[6] as String?,
      registrationStatus: fields[7] as RegistrationStatus?,
      createdAt: fields[8] as DateTime?,
      updatedAt: fields[9] as DateTime?,
      location: fields[19] as Location?,
      materials: fields[17] == null
          ? const []
          : (fields[17] as List?)?.cast<MaterialTypesModel>(),
      documents: fields[16] as SupllierMedia?,
      bankDetails: fields[22] as BankDetails?,
      token: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.contactNumber)
      ..writeByte(3)
      ..write(obj.companyName)
      ..writeByte(4)
      ..write(obj.locationId)
      ..writeByte(5)
      ..write(obj.ownerName)
      ..writeByte(6)
      ..write(obj.ownerContact)
      ..writeByte(7)
      ..write(obj.registrationStatus)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(16)
      ..write(obj.documents)
      ..writeByte(17)
      ..write(obj.materials)
      ..writeByte(18)
      ..write(obj.token)
      ..writeByte(19)
      ..write(obj.location)
      ..writeByte(21)
      ..write(obj.gstNumber)
      ..writeByte(22)
      ..write(obj.bankDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RegistrationStatusAdapter extends TypeAdapter<RegistrationStatus> {
  @override
  final int typeId = 1;

  @override
  RegistrationStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RegistrationStatus.pending;
      case 6:
        return RegistrationStatus.materialsUploaded;
      case 7:
        return RegistrationStatus.supplierUploaded;
      case 8:
        return RegistrationStatus.bankDetailsUploaded;
      case 9:
        return RegistrationStatus.documentsUploaded;
      default:
        return RegistrationStatus.pending;
    }
  }

  @override
  void write(BinaryWriter writer, RegistrationStatus obj) {
    switch (obj) {
      case RegistrationStatus.pending:
        writer.writeByte(0);
      case RegistrationStatus.materialsUploaded:
        writer.writeByte(6);
      case RegistrationStatus.supplierUploaded:
        writer.writeByte(7);
      case RegistrationStatus.bankDetailsUploaded:
        writer.writeByte(8);
      case RegistrationStatus.documentsUploaded:
        writer.writeByte(9);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistrationStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final int typeId = 2;

  @override
  Location read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Location(
      latitude: (fields[0] as num).toDouble(),
      longitude: (fields[1] as num).toDouble(),
      address: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MaterialTypesModelAdapter extends TypeAdapter<MaterialTypesModel> {
  @override
  final int typeId = 3;

  @override
  MaterialTypesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialTypesModel(
      materialTypesId: (fields[2] as num?)?.toInt(),
      materialId: (fields[3] as num?)?.toInt(),
      measurement: fields[4] as String?,
      materialName: fields[5] as String?,
      typesId: (fields[6] as num?)?.toInt(),
      typesName: fields[7] as String?,
      price: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MaterialTypesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(2)
      ..write(obj.materialTypesId)
      ..writeByte(3)
      ..write(obj.materialId)
      ..writeByte(4)
      ..write(obj.measurement)
      ..writeByte(5)
      ..write(obj.materialName)
      ..writeByte(6)
      ..write(obj.typesId)
      ..writeByte(7)
      ..write(obj.typesName)
      ..writeByte(8)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialTypesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BankDetailsAdapter extends TypeAdapter<BankDetails> {
  @override
  final int typeId = 6;

  @override
  BankDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankDetails(
      accountHolderName: fields[0] as String?,
      accountNumber: fields[1] as String?,
      bankName: fields[2] as String?,
      ifscCode: fields[3] as String?,
      branchName: fields[4] as String?,
      upiId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BankDetails obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.accountHolderName)
      ..writeByte(1)
      ..write(obj.accountNumber)
      ..writeByte(2)
      ..write(obj.bankName)
      ..writeByte(3)
      ..write(obj.ifscCode)
      ..writeByte(4)
      ..write(obj.branchName)
      ..writeByte(5)
      ..write(obj.upiId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SupllierMediaAdapter extends TypeAdapter<SupllierMedia> {
  @override
  final int typeId = 7;

  @override
  SupllierMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupllierMedia(
      gstCertificate: fields[0] as String?,
      companyRegistrationCertificate: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SupllierMedia obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.gstCertificate)
      ..writeByte(1)
      ..write(obj.companyRegistrationCertificate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupllierMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
