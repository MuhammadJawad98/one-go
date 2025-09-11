import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../utils/api_endpoint.dart';
import '../utils/application_shared_instance.dart';
import '../utils/print_log.dart';

class ApiManager {
  static Future<dynamic> get(String path, {bool byPassBaseUrl = false,Map<String,String> headers =const {}}) async {
    try {
      var url = '${ApiEndpoint.baseUrl}$path';
      if (byPassBaseUrl) {
        url = path;
      }
      // Log curl command
      var tempHeaders = {
        // 'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${DataManager().authToken}",
        ...headers
      };
      _logCurlCommand('GET', url, tempHeaders);
      final response = await http.get(Uri.parse(url),headers:tempHeaders);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ApiException(response.statusCode, 'Failed to load data');
      }
    } catch (e) {
      if (e is SocketException) {
        PrintLogs.printLog("No internet connection");
        return {
          "status": false,
          "message": "You’re offline. Check your internet connection and try again.",
        };
      } else if (e is TimeoutException) {
        PrintLogs.printLog("Request timed out");
        return {
          "status": false,
          "message": "Request timed out. Please try again.",
        };
      } else {
        PrintLogs.printLog("An unknown error occurred: $e");
        return {
          "status": false,
          "message": "Something went wrong. Please try again.",
        };
      }
    }
  }

  static Future<dynamic> post(String path, dynamic data,
      {bool bypassBaseUrl = false,Map<String,String> headers = const {}}) async {
    String url = ApiEndpoint.baseUrl + path;
    if (bypassBaseUrl) {
      url = path;
    }
    // Log curl command
    var tempHeaders = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${DataManager().authToken}",
      ...headers
    };
    _logCurlCommand('POST', url, tempHeaders, body: data);

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: tempHeaders,
        body: (data != null && data.isNotEmpty) ? jsonEncode(data) : null,
      );

      // if (response.statusCode == 200 || response.statusCode == 201) {
        PrintLogs.printLog(response.body);
        return json.decode(response.body);
      // } else {
      //   throw ApiException(response.statusCode, 'Failed to create resource');
      // }
    } catch (e) {
      if (e is SocketException) {
        PrintLogs.printLog("No internet connection");
        return {
          "status": false,
          "message": "You’re offline. Check your internet connection and try again.",
        };
      } else if (e is TimeoutException) {
        PrintLogs.printLog("Request timed out");
        return {
          "status": false,
          "message": "Request timed out. Please try again.",
        };
      } else {
        PrintLogs.printLog("An unknown error occurred: $e");
        return {
          "status": false,
          "message": "Something went wrong. Please try again.",
        };
      }
    }
  }

  static Future<dynamic> update(String path, Map<String, dynamic> data,
      {bool byPassBaseUrl = false}) async {
    try {
      var url = '${ApiEndpoint.baseUrl}$path';
      if (byPassBaseUrl) {
        url = path;
      }
      // Log curl command
      _logCurlCommand('PUT', url, {}, body: data);

      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        PrintLogs.printLog(response.body);
        return json.decode(response.body);
      } else {
        throw ApiException(response.statusCode, 'Failed to update resource');
      }
    } catch (e) {
      if (e is SocketException) {
        PrintLogs.printLog("No internet connection");
        return {
          "status": false,
          "message": "You’re offline. Check your internet connection and try again.",
        };
      } else if (e is TimeoutException) {
        PrintLogs.printLog("Request timed out");
        return {
          "status": false,
          "message": "Request timed out. Please try again.",
        };
      } else {
        PrintLogs.printLog("An unknown error occurred: $e");
        return {
          "status": false,
          "message": "Something went wrong. Please try again.",
        };
      }
    }
  }

  static Future<void> delete(String path, {bool byPassBaseUrl = false}) async {
    try {
      var url = '${ApiEndpoint.baseUrl}$path';
      if (byPassBaseUrl) {
        url = path;
      }

      // Log curl command
      _logCurlCommand('DELETE', url, {});

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode != 204) {
        throw ApiException(response.statusCode, 'Failed to delete resource');
      }
    } catch (e) {
      if (e is SocketException) {
        PrintLogs.printLog("No internet connection");
      } else if (e is TimeoutException) {
        PrintLogs.printLog("Request timed out");
      } else {
        PrintLogs.printLog("An unknown error occurred");
      }
    }
  }

  static Future<dynamic> uploadFile(
      String path,
      File file, {
        String fieldName = "file",
        Map<String, String> fields = const {},
        Map<String, String> headers = const {},
        bool byPassBaseUrl = false,
      }) async {
    try {
      var url = byPassBaseUrl ? path : "${ApiEndpoint.baseUrl}$path";

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers.addAll({
        "Authorization": "Bearer ${DataManager().authToken}",
        ...headers,
      });

      request.fields.addAll(fields);

      // ✅ Correct: attach file with contentType
      final mimeType = file.path.endsWith(".png") || file.path.endsWith(".jpg")
          ? MediaType("image", file.path.endsWith(".png") ? "png" : "jpeg")
          : MediaType("application", "octet-stream");

      request.files.add(await http.MultipartFile.fromPath(
        fieldName,
        file.path,
        contentType: mimeType,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      PrintLogs.printLog("Upload Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw ApiException(response.statusCode, 'Failed to upload file');
      }
    } catch (e) {
      PrintLogs.printLog("Upload error: $e");
      return {};
    }

  }

  static void _logCurlCommand(String method, String url, Map<String, String> headers, { dynamic body}) {
    final headerStrings = headers.entries.map((entry) => '-H "${entry.key}: ${entry.value}"').join(' ');
    // Ensure the body is formatted as raw JSON
    final bodyString = body != null ? "--data-raw '${jsonEncode(body).replaceAll("'", "'\"'\"'")}'" : '';
    final curlCommand = 'curl -X $method $headerStrings $bodyString "$url"';
    PrintLogs.printLog(curlCommand);
  }


}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);
}

class InternetException implements Exception {
  final String message;

  InternetException(this.message);
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}
