import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;

class Api {
  Future<http.Response> get(String path, {Map<String, String>? headers}) {
    return http
        .get(_getUrl(path), headers: headers)
        .timeout(const Duration(seconds: 30));
  }

  Future<http.Response> post(String path,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    headers ??= {};
    headers[HttpHeaders.contentTypeHeader] = 'application/json; charset=UTF-8';

    return http.post(_getUrl(path),
        headers: headers, body: jsonEncode(body), encoding: encoding);
  }

  Uri _getUrl(String path) {
    return Uri.parse(_baseURL() + path);
  }

  String _baseURL() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080";
    }
    return "http://localhost:8080";
  }

  Future<http.Response> upload(String path,
      {required File file,
      required String field,
      MediaType? contentType}) async {
    final request = http.MultipartRequest('POST', _getUrl(path));
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
}
