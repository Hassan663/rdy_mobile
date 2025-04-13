import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ryd4ride/constants/libraries/app_libraries.dart';

class ApiService extends GetxService {
  static const String baseUrl = "http://209.38.67.76:5000/";

  // 🟢 GET Request with Logs
  Future<Map<String, dynamic>> getRequest(String endpoint,
      {Map<String, String>? params}) async {
    try {
      Uri uri = Uri.parse("$baseUrl$endpoint").replace(queryParameters: params);
      print("[ApiService] GET Request: $uri");

      http.Response response = await http.get(uri, headers: _getHeaders());
      print("[ApiService] GET Response: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("[ApiService] GET Request Error: $e");
      return _handleError(e);
    }
  }

  // 🔵 POST Request with Logs
  Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Uri uri = Uri.parse("$baseUrl$endpoint");
      print("[ApiService] POST Request: $uri");
      print("[ApiService] POST Payload: $data");

      http.Response response =
          await http.post(uri, headers: _getHeaders(), body: jsonEncode(data));
      print("[ApiService] POST Response: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("[ApiService] POST Request Error: $e");
      return _handleError(e);
    }
  }

  // 🟠 UPDATE (PUT) Request with Logs
  Future<Map<String, dynamic>> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Uri uri = Uri.parse("$baseUrl$endpoint");
      print("[ApiService] PUT Request: $uri");
      print("[ApiService] PUT Payload: $data");

      http.Response response =
          await http.put(uri, headers: _getHeaders(), body: jsonEncode(data));
      print("[ApiService] PUT Response: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("[ApiService] PUT Request Error: $e");
      return _handleError(e);
    }
  }

  // 🔴 DELETE Request with Logs
  Future<Map<String, dynamic>> deleteRequest(String endpoint) async {
    try {
      Uri uri = Uri.parse("$baseUrl$endpoint");
      print("[ApiService] DELETE Request: $uri");

      http.Response response = await http.delete(uri, headers: _getHeaders());
      print("[ApiService] DELETE Response: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("[ApiService] DELETE Request Error: $e");
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> patchRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      Uri uri = Uri.parse("$baseUrl$endpoint");
      print("[ApiService] PATCH Request: $uri");
      print("[ApiService] PATCH Payload: $data");

      http.Response response =
          await http.patch(uri, headers: _getHeaders(), body: jsonEncode(data));
      print("[ApiService] PATCH Response: ${response.body}");

      return _handleResponse(response);
    } catch (e) {
      print("[ApiService] PATCH Request Error: $e");
      return _handleError(e);
    }
  }

  // 🛑 Handle API Response
  Map<String, dynamic> _handleResponse(http.Response response) {
    print("[ApiService] Handling Response - Status: ${response.statusCode}");
    print("[ApiService] Raw Response Body: ${response.body}");

    try {
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return {
          "success": true,
          "data": decodedResponse,
          "status": response.statusCode
        };
      } else {
        // 🔹 Extract error message if present
        String errorMessage =
            decodedResponse["message"] ?? decodedResponse["data"]?["message"];

        print("[ApiService] Error Response: $errorMessage");

        return {
          "success": false,
          "message": errorMessage,
          "status": response.statusCode
        };
      }
    } catch (e) {
      print("[ApiService] JSON Decode Error: ${e.toString()}");
      return {
        "success": false,
        "message": "Error parsing response",
        "status": response.statusCode
      };
    }
  }

  // ⚠️ Handle Errors with Logs
  Map<String, dynamic> _handleError(dynamic error) {
    print("[ApiService] Error: $error");
    return {"success": false, "message": error.toString(), "status": 500};
  }

  // 🛡️ Common Headers
  // 🛡️ Common Headers
  Map<String, String> _getHeaders({bool needsAuth = true}) {
    var headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (needsAuth) {
      String? token = GetStorage()
          .read<String>('access_token'); // Get token from local storage
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      } else {
        print(
            "[ApiService] Warning: No token found, request will be unauthenticated.");
      }
    }

    print("[ApiService] Headers: $headers");
    return headers;
  }
}
