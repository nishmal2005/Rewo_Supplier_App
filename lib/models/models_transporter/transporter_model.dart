import 'package:hive_ce/hive.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';
import 'package:rewo_supplier/models/models_transporter/create_pricing_model.dart' show PriceRange;
import 'package:rewo_supplier/models/models_transporter/create_registration_model.dart';
import 'package:rewo_supplier/models/models_transporter/material_types_model.dart';
import 'package:rewo_supplier/models/models_transporter/upload_documents_model.dart';




class UserModel extends HiveObject {
  final int? id;
  final String? name;
  final String? contactNumber;
  final String? companyName;
  final int? locationId;
  final String? ownerName;
  final String? ownerContact;
  final RegistrationStatus? registrationStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? vehicleId;
  final String? vehicleNumber;
  final String? manufacturer;
  final String? model;
  final String? loadCapacityVolume;
  final String? loadCapacityWeight;
  final VehicleMedia? documents;
  final List<TransporterMaterialTypesModel>? materials;
  final String? token;
  final Location? location;
  final List<PriceRange>? priceRanges;
  UserModel(
      {this.id,
      this.name,
      this.contactNumber,
      this.companyName,
      this.locationId,
      this.ownerName,
      this.ownerContact,
      this.registrationStatus,
      this.createdAt,
      this.updatedAt,
      this.vehicleId,
      this.vehicleNumber,
      this.manufacturer,
      this.model,
      this.loadCapacityVolume,
      this.loadCapacityWeight,
      this.documents,
      this.materials = const [],
      this.priceRanges = const [],
      this.token,
      this.location});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      contactNumber: json['contact_number'] ?? '',
      companyName: json['company_name'] ?? '',
      locationId: json['location_id'] ?? 0,
      ownerName: json['owner_name'] ?? '',
      ownerContact: json['owner_contact'] ?? '',
      priceRanges: (json['pricing'] is List)
          ? (json['pricing'] as List)
              .map(
                (e) => PriceRange.fromJson(e),
              )
              .toList()
          : [],
      registrationStatus:
          RegistrationStatus.fromString(json['registration_status']),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      vehicleId: json['vehicle_id'],
      vehicleNumber: json['vehicle_number'],
      manufacturer: json['manufacturer'],
      model: json['model'],
      loadCapacityVolume: json['load_capacity_volume'],
      loadCapacityWeight: json['load_capacity_weight'],
      documents: json['documents'] is Map
          ? VehicleMedia.fromJson(json['documents'])
          : null,
      materials: (json['materials'] is List)
          ? (json['materials'] as List)
              .map(
                (e) => TransporterMaterialTypesModel.fromMap(e),
              )
              .toList()
          : [],
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_number': contactNumber,
      'company_name': companyName,
      'location_id': locationId,
      'owner_name': ownerName,
      'owner_contact': ownerContact,
      'registration_status': registrationStatus?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'vehicle_id': vehicleId,
      'vehicle_number': vehicleNumber,
      'manufacturer': manufacturer,
      'model': model,
      'load_capacity_volume': loadCapacityVolume,
      'load_capacity_weight': loadCapacityWeight,
      'documents': documents,
      'materials': materials,
      'token': token,
    };
  }

  UserModel copyWith(
      {int? id,
      String? name,
      String? contactNumber,
      String? companyName,
      int? locationId,
      String? ownerName,
      String? ownerContact,
      Location? location,
      RegistrationStatus? registrationStatus,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? vehicleId,
      String? vehicleNumber,
      String? manufacturer,
      String? model,
      String? loadCapacityVolume,
      String? loadCapacityWeight,
      VehicleMedia? documents,
      List<TransporterMaterialTypesModel>? materials,
      String? token,
      List<PriceRange>? range}) {
    return UserModel(
        id: id ?? this.id,
        location: location??this.location,
        name: name ?? this.name,
        contactNumber: contactNumber ?? this.contactNumber,
        companyName: companyName ?? this.companyName,
        locationId: locationId ?? this.locationId,
        ownerName: ownerName ?? this.ownerName,
        ownerContact: ownerContact ?? this.ownerContact,
        registrationStatus:
            this.registrationStatus == RegistrationStatus.pricingUploaded
                ? RegistrationStatus.pricingUploaded
                : registrationStatus ?? this.registrationStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        manufacturer: manufacturer ?? this.manufacturer,
        model: model ?? this.model,
        loadCapacityVolume: loadCapacityVolume ?? this.loadCapacityVolume,
        loadCapacityWeight: loadCapacityWeight ?? this.loadCapacityWeight,
        documents: documents ?? this.documents,
        materials: materials ?? this.materials,
        token: token ?? this.token,
        priceRanges: range ?? this.priceRanges);
  }
}

enum RegistrationStatus {
  pending,
  transportersUploaded,
  vehicleUploaded,
  vehicleDocumentsUploaded,
  pricingUploaded,
  unknown; // for unexpected or null values

  static RegistrationStatus fromString(String? status) {
    switch (status) {
      case 'pending':
        return RegistrationStatus.pending;
      case 'transporters_uploaded':
        return RegistrationStatus.transportersUploaded;
      case 'vehicle_uploaded':
        return RegistrationStatus.vehicleUploaded;
      case 'vehicle_documents_uploaded':
        return RegistrationStatus.vehicleDocumentsUploaded;
      case "pricing_uploaded":
        return RegistrationStatus.pricingUploaded;
      default:
        return RegistrationStatus.unknown;
    }
  }

  String toJson() {
    switch (this) {
      case RegistrationStatus.pending:
        return 'pending';
      case RegistrationStatus.transportersUploaded:
        return 'transporters_uploaded';
      case RegistrationStatus.vehicleUploaded:
        return 'vehicle_uploaded';
      case RegistrationStatus.vehicleDocumentsUploaded:
        return 'vehicle_documents_uploaded';
      case RegistrationStatus.pricingUploaded:
        return "pricing_uploaded";
      case RegistrationStatus.unknown:
        return 'unknown';
    }
  }
}
