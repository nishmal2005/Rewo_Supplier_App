import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:rewo_supplier/models/create_registration_model.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class LocationServices {
  loc.Location location = loc.Location();

  Future<void> getCurrentLocation(
      {required Function() onServiceNotEnabled,
      required Function() onPermissionNotEnabled,
      required Function(Exception e) onError,
      required Function(Location location) onSuccess,
      bool needRequestServices = false,
      bool needRequstPermission = false}) async {
    try {
      // Step 1: Check service
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        if (needRequestServices) {
          serviceEnabled = await location.requestService();
        }
        log(serviceEnabled.toString(), name: "serviceEnabled");
        if (!serviceEnabled) {
          onServiceNotEnabled();
          return;
        }
      }

      // Step 2: Check permission
      loc.PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        if (needRequstPermission) {
          permissionGranted = await location.requestPermission();
        }

        if (permissionGranted != loc.PermissionStatus.granted) {
          onPermissionNotEnabled();
          return;
        }
      } else if (permissionGranted == loc.PermissionStatus.deniedForever) {
        onPermissionNotEnabled();
        return;
      }

      // Step 3: Get location
      final loc.LocationData locationData = await location.getLocation();

      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception("Failed to get location coordinates.");
      }
      log(locationData.latitude.toString());
      // Step 4: Get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      String address = "";
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address =
            "${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}";
      }

      // Step 5: Call success
      onSuccess(
        Location(
          latitude: locationData.latitude ?? 0.0,
          longitude: locationData.longitude ?? 0.0,
          address: address,
        ),
      );
    } catch (e) {
      onError(Exception(e.toString()));
    }
  }

  final client = Dio();

  LocationServices();

  final _apiKey = "AIzaSyDbzHog6Ajbe1UGejh8bmMaQzjRnlq673A";

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final sessionToken = const Uuid().v4();

    final response = await client.get(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:in&state=KL&key=$_apiKey&sessiontoken=$sessionToken");

    if (response.statusCode == 200) {
      log(response.data.toString());
      final result = response.data;
      if (result['status'] == 'OK') {
        final datas = result['predictions'];
        // compose suggestions in a list
        return datas is List
            ? (datas
                .map<Suggestion>(
                    (p) => Suggestion(p['place_id'], p['description']))
                .toList())
            : [];
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future getCurrentLocationFromAddress({
    required Suggestion suugession,
    required Function(Location location) onSuccess,
    required Function(Exception e) onError,
  }) async {
    // LocationData locationData;

    try {
      // locationData = await location.getLocation();
      final addresses = await locationFromAddress(suugession.description);
      // log(locationData.toString());
      log(addresses.first.toJson().toString());
      if (addresses.isNotEmpty) {
        onSuccess(Location(
            latitude: addresses.first.latitude,
            longitude: addresses.first.latitude,
            address: suugession.description));
      } else {
        throw "Address is Empty";
      }
    } catch (e) {
      onError(Exception(e.toString()));
    }
  }
}
