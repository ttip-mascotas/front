import 'dart:io';
import 'package:http/http.dart' as http;

class Api {

  Future<http.Response> get(String path, { Map<String, String>? headers}) {
    return http.get(_getUrl(path), headers: headers);
  }

  Uri _getUrl(String path) {
    return Uri.parse(_baseURL() + path);
  }

  String _baseURL() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080';
    }

    return 'http://localhost:8080';
  }

}