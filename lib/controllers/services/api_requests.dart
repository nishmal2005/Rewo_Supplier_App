import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:rewo_supplier/configs/constants.dart';
import 'package:rewo_supplier/controllers/implementations/user_controller.dart';

class ApiRequests {
  static final Dio dio = Dio()..interceptors.add(_authInterceptor());

  static InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final controller = Get.find<UserController>();
        final token = controller.userData?.token;
        if (token != null && token.isNotEmpty) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
      onError: (DioError error, handler) {
        log("API Error: ${error.message}");
        return handler.next(error);
      },
    );
  }

  static Future<Response> getRequest(String urlEnd) async {
    final url = "${Constants.api}$urlEnd";
    dio.options.validateStatus = (_) => true;

    final response = await dio.get(url);

    await handleUnAutherized(response);
    return response;
  }

  static Future<void> postRequest(
    String urlEnd,
    Object data, {
    bool? json,
    required Function(Response response) onSuccess,
    Function(String error)? onFailure,
    Function(Response response)? onNotFound,
  }) async {
    final url = "${Constants.api}$urlEnd";
    log(data.toString());
    dio.options.validateStatus = (_) => true;

    try {
      final response = await dio.post(
        url,
        data: data,
        onReceiveProgress: (count, total) {},
      );

      log(response.data.toString());
      await handleUnAutherized(response);

      if (response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          onSuccess(response);
        } else if (response.statusCode == 404) {
          if (onNotFound != null) {
            onNotFound(response);
          } else if (onFailure != null) {
            final message = _extractMessage(response);
            onFailure(message);
          }
        } else {
          if (onFailure != null) {
            final message = _extractMessage(response);
            onFailure(message);
          }
        }
      } else {
        if (onFailure != null) {
          onFailure("Something went wrong");
        }
      }
    } catch (error) {
      if (onFailure != null) {
        onFailure(error.toString());
      }
      log(error.toString());
    }
  }

  static String _extractMessage(Response response) {
    log(response.data.toString());
    try {
      if (response.data is Map && response.data["message"] != null) {
        return response.data["message"].toString();
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  static Future<void> postWithMedia(
    String urlEnd,
    FormData formData, {
    required Function(Response response) onSuccess,
    Function(String error)? onFailure,
    Function(Response response)? onNotFound,
    Function(int sent, int total)? onSendProgress,
    Function(int received, int total)? onReceiveProgress,
  }) async {
    final url = "${Constants.api}$urlEnd";
    dio.options.validateStatus = (_) => true;
    dio.options.headers["Content-Type"] = "multipart/form-data";
    log(url);
    try {
      final response = await dio.post(
        url,
        data: formData,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      log(response.statusCode.toString());
      await handleUnAutherized(response);

      if (response.statusCode != null) {
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          onSuccess(response);
        } else if (response.statusCode == 404) {
          if (onNotFound != null) {
            onNotFound(response);
          } else if (onFailure != null) {
            final message = _extractMessage(response);
            onFailure(message);
          }
        } else {
          if (onFailure != null) {
            final message = _extractMessage(response);
            onFailure(message);
          }
        }
      } else {
        if (onFailure != null) {
          onFailure("Something went wrong");
        }
      }
    } catch (error) {
      if (onFailure != null) {
        onFailure(error.toString());
      }
      log(error.toString());
    }
  }

  static Future<Response> getRequestUsingParams(
      String urlEnd, Map<String, dynamic> queryParams) async {
    dio.options.validateStatus = (_) => true;
    final url = "${Constants.api}$urlEnd";
    final uri = Uri.parse(url).replace(queryParameters: queryParams);
    final response = await dio.getUri(uri);
    await handleUnAutherized(response);
    log("$uri user");
    return response;
  }

  static Future<void> handleUnAutherized(Response response) async {
    if (response.statusCode == 401) {
      log("Unauthorized - handle redirection or token clear here.");
      // Example: Logout or redirect to login screen
      // Get.find<UserController>().clearToken();
      // Get.offAllNamed('/login');
    }
  }
}
