import "dart:convert";
import "dart:io";

import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import "package:mascotas/utils/storage_key.dart";

class Api {
  final storage = const FlutterSecureStorage();

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    headers ??= {};
    await addAuthorizationHeader(headers);

    return http
        .get(
          _getUrl(path, queryParameters: queryParameters),
          headers: headers,
        )
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> post(String path,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    headers ??= {};
    headers[HttpHeaders.contentTypeHeader] = "application/json; charset=UTF-8";
    await addAuthorizationHeader(headers);

    return http.post(_getUrl(path),
        headers: headers, body: jsonEncode(body), encoding: encoding);
  }

  Future<http.Response> put(String path,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    headers ??= {};
    headers[HttpHeaders.contentTypeHeader] = "application/json; charset=UTF-8";
    await addAuthorizationHeader(headers);

    return http.put(_getUrl(path),
        headers: headers, body: jsonEncode(body), encoding: encoding);
  }

  Future<http.Response> upload(String path,
      {required File file,
        required String field,
        MediaType? contentType}) async {
    final request = http.MultipartRequest("POST", _getUrl(path));
    final Map<String, String> headers = {};
    await addAuthorizationHeader(headers);
    request.headers.addAll(headers);
    request.files.add(http.MultipartFile(
      field,
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split("/").last,
      contentType: contentType,
    ));
    final response = await request.send();
    return http.Response.fromStream(response);
  }

  Uri _getUrl(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri.http(_baseURL(), path, queryParameters);
  }

  String _baseURL() {
    if (Platform.isAndroid) {
      return "10.0.2.2:8080";
    }
    return "localhost:8080";
  }

  Future<void> addAuthorizationHeader(Map<String, String> headers) async {
    final String? token = await storage.read(key: StorageKey.tokenStorageKey);
    if (token != null) {
      headers[HttpHeaders.authorizationHeader] = "Bearer $token";
    }
  }
}
