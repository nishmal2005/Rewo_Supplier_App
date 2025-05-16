import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class VehicleDocumentUploadModel {
  File? rcImage;
  File? insuranceImage;
  File? drivingLicenceImage;
  File? vehicleVideo;
  File? vehicleFrontImage;
  File? vehicleBackImage;
  File? vehicleLeftImage;
  File? vehicleRightImage;

  Future<void> pickImage(Function(File file) onPicked) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }

  Future<void> pickVideo(Function(File file) onPicked) async {
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      onPicked(File(picked.path));
    }
  }
MediaType? getMediaType(String filePath) {
    final ext = path.extension(filePath).toLowerCase();
    switch (ext) {
      case '.jpg':
      case '.jpeg':
        return MediaType('image', 'jpeg');
      case '.png':
        return MediaType('image', 'png');
      case '.pdf':
        return MediaType('application', 'pdf');
      case '.mp4':
        return MediaType('video', 'mp4');
      default:
        return null; // fallback to default if unknown
    }
  }

  Future<FormData> toFormData(int? vehicleId) async {
    final data = <String, dynamic>{
      "vehicle_id": vehicleId,
    };

    Future<void> addFile(String key, File? file) async {
      if (file != null) {
        final mediaType = getMediaType(file.path);
        data[key] = await MultipartFile.fromFile(
          file.path,
          filename: path.basename(file.path),
          contentType: mediaType,
        );
      }
    }

    try {
      await addFile("rc_image", rcImage);
      await addFile("insurance_image", insuranceImage);
      await addFile("driving_licence_image", drivingLicenceImage);
      await addFile("vehicle_video", vehicleVideo);
      await addFile("vehicle_front_image", vehicleFrontImage);
      await addFile("vehicle_back_image", vehicleBackImage);
      await addFile("vehicle_left_image", vehicleLeftImage);
      await addFile("vehicle_right_image", vehicleRightImage);
    } catch (e) {
      log("FormData file processing error: $e");
    }

    log(data.toString());
    return FormData.fromMap(data);
  }

}

class VehicleMedia {
  final String? rcImage;
  final String? insuranceImage;
  final String? drivingLicenceImage;
  final String? vehicleVideo;
  final String? vehicleFrontImage;
  final String? vehicleBackImage;
  final String? vehicleLeftImage;
  final String? vehicleRightImage;

  VehicleMedia({
    this.rcImage,
    this.insuranceImage,
    this.drivingLicenceImage,
    this.vehicleVideo,
    this.vehicleFrontImage,
    this.vehicleBackImage,
    this.vehicleLeftImage,
    this.vehicleRightImage,
  });

  factory VehicleMedia.fromJson(Map<String, dynamic> json) {
    return VehicleMedia(
      rcImage: json['rc_image'],
      insuranceImage: json['insurance_image'],
      drivingLicenceImage: json['driving_licence_image'],
      vehicleVideo: json['vehicle_video'],
      vehicleFrontImage: json['vehicle_front_image'],
      vehicleBackImage: json['vehicle_back_image'],
      vehicleLeftImage: json['vehicle_left_image'],
      vehicleRightImage: json['vehicle_right_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rc_image': rcImage,
      'insurance_image': insuranceImage,
      'driving_licence_image': drivingLicenceImage,
      'vehicle_video': vehicleVideo,
      'vehicle_front_image': vehicleFrontImage,
      'vehicle_back_image': vehicleBackImage,
      'vehicle_left_image': vehicleLeftImage,
      'vehicle_right_image': vehicleRightImage,
    };
  }
  VehicleMedia copyWithVehicleMedia(VehicleMedia? vehicle) {
    if (vehicle == null) return this;
log(vehicle.drivingLicenceImage.toString());
    return VehicleMedia(
      rcImage: vehicle.rcImage ?? rcImage,
      insuranceImage: vehicle.insuranceImage ?? insuranceImage,
      drivingLicenceImage: vehicle.drivingLicenceImage ?? drivingLicenceImage,
      vehicleVideo: vehicle.vehicleVideo ?? vehicleVideo,
      vehicleFrontImage: vehicle.vehicleFrontImage ?? vehicleFrontImage,
      vehicleBackImage: vehicle.vehicleBackImage ?? vehicleBackImage,
      vehicleLeftImage: vehicle.vehicleLeftImage ?? vehicleLeftImage,
      vehicleRightImage: vehicle.vehicleRightImage ?? vehicleRightImage,
    );
  }

}
