import 'dart:developer';

import 'package:hive_ce/hive.dart';
import 'package:rewo_supplier/models/create_registration_model.dart';

class UserModel extends HiveObject {
  final int? id;
  final String? name;
  final String? contactNumber;
  final String? companyName;
  final int? locationId;
  final String? gstNumber;
  final String? ownerName;
  final String? ownerContact;
  RegistrationStatus? registrationStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Location? location;
  final List<MaterialTypesModel>? materials;
  final SupllierMedia? documents;
  final BankDetails? bankDetails;
  final String? token;

  UserModel({
    this.id,
    this.name,
    this.contactNumber,
    this.companyName,
    this.locationId,
    this.gstNumber,
    this.ownerName,
    this.ownerContact,
    this.registrationStatus,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.materials = const [],
    this.documents,
    this.bankDetails,
    this.token,
  });
  UserModel copyWith({
    int? id,
    String? name,
    String? contactNumber,
    String? companyName,
    int? locationId,
    String? ownerName,
    String? ownerContact,
    RegistrationStatus? registrationStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? gstNumber,
    String? token,
    Location? location,
    List<MaterialTypesModel>? materials,
    SupllierMedia? documents,
    BankDetails? bankDetails,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      contactNumber: contactNumber ?? this.contactNumber,
      companyName: companyName ?? this.companyName,
      locationId: locationId ?? this.locationId,
      ownerName: ownerName ?? this.ownerName,
      ownerContact: ownerContact ?? this.ownerContact,
      registrationStatus: registrationStatus ?? this.registrationStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
      location: location ?? this.location,
      gstNumber: gstNumber ?? this.gstNumber,
      materials: materials ?? this.materials,
      documents: documents ?? this.documents,
      bankDetails: bankDetails ?? this.bankDetails,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      contactNumber: json['contact_number'],
      companyName: json['company_name'],
      locationId: json['location_id'],
      gstNumber: json['gst_number'],
      ownerName: json['owner_name'],
      ownerContact: json['owner_contact_number'],
      registrationStatus:
          RegistrationStatusExtension.fromString(json['registration_status']),
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      materials: (json['materials'] as List?)
              ?.map((e) => MaterialTypesModel.fromJson(e))
              .toList() ??
          [],
      documents: json['documents'] != null
          ? SupllierMedia.fromJson(json['documents'])
          : null,
      bankDetails: json['bank_details'] != null
          ? BankDetails.fromJson(json['bank_details'])
          : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'contact_number': contactNumber,
      'company_name': companyName,
      'location_id': locationId,
      'gst_number': gstNumber,
      'owner_name': ownerName,
      'owner_contact_number': ownerContact,
      // 'registration_status': registrationStatus?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'location': location?.toJson(),
      'materials': materials?.map((e) => e.toJson()).toList(),
      'documents': documents?.toJson(),
      'bank_details': bankDetails?.toJson(),
      'token': token,
    };
  }
}

enum RegistrationStatus {
  pending,
  supplierUploaded,
  materialsUploaded,
  bankDetailsUploaded,
  documentsUploaded,
}

extension RegistrationStatusExtension on RegistrationStatus {
  String get name {
    switch (this) {
      case RegistrationStatus.pending:
        return 'pending';
      case RegistrationStatus.supplierUploaded:
        return 'supplier_uploaded';
      case RegistrationStatus.materialsUploaded:
        return 'materials_uploaded';
      case RegistrationStatus.bankDetailsUploaded:
        return 'bank_details_uploaded';
      case RegistrationStatus.documentsUploaded:
        return 'documents_uploaded';
    }
  }

  static RegistrationStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return RegistrationStatus.pending;
      case 'supplier_uploaded':
        return RegistrationStatus.supplierUploaded;
      case 'materials_uploaded':
        return RegistrationStatus.materialsUploaded;
      case 'bank_details_uploaded':
        return RegistrationStatus.bankDetailsUploaded;
      case 'documents_uploaded':
        return RegistrationStatus.documentsUploaded;
      default:
        throw Exception('Unknown registration status: $status');
    }
  }
}

class MaterialTypesModel {
  final int? materialTypesId;
  final int? materialId;
  final String? measurement;
  final String? materialName;
  final int? typesId;
  final String? typesName;
  final String? price;

  MaterialTypesModel({
    this.materialTypesId,
    this.materialId,
    this.measurement,
    this.materialName,
    this.typesId,
    this.typesName,
    this.price,
  });

  factory MaterialTypesModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return MaterialTypesModel(
      materialTypesId: json['material_types_id'],
      materialId: json['material_id'],
      measurement: json['measurement'],
      materialName: json['material_name'],
      typesId: json['types_id'],
      typesName: json['types_name'],
      price: json['price']?.toString(),
    );
  }



  Map<String, dynamic> toJson() => {
        'material_types_id': materialTypesId,
        'material_id': materialId,
        'measurement': measurement,
        'material_name': materialName,
        'types_id': typesId,
        'types_name': typesName,
        'price': price,
      };
}

class SupllierMedia {
  final String? gstCertificate;
  final String? companyRegistrationCertificate;

  SupllierMedia({
    this.gstCertificate,
    this.companyRegistrationCertificate,
  });

  factory SupllierMedia.fromJson(Map<String, dynamic> json) {
    return SupllierMedia(
      gstCertificate: json['gst_certificate'],
      companyRegistrationCertificate: json['company_registration_certificate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'gst_certificate': gstCertificate,
        'company_registration_certificate': companyRegistrationCertificate,
      };
 SupllierMedia CopyWith(SupllierMedia media) {
    return SupllierMedia(
        gstCertificate: media.gstCertificate ?? gstCertificate,
        companyRegistrationCertificate: media.companyRegistrationCertificate ??
            companyRegistrationCertificate);
  }
}

class BankDetails {
  final String? accountHolderName;
  final String? accountNumber;
  final String? bankName;
  final String? ifscCode;
  final String? branchName;
  final String? upiId;

  BankDetails({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.ifscCode,
    this.branchName,
    this.upiId,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      accountHolderName: json['account_holder_name'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      ifscCode: json['ifsc_code'],
      branchName: json['branch_name'],
      upiId: json['upi_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'account_holder_name': accountHolderName,
        'account_number': accountNumber,
        'bank_name': bankName,
        'ifsc_code': ifscCode,
        'branch_name': branchName,
        'upi_id': upiId,
      };
}
