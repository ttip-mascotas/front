import 'package:http/http.dart';
import 'api.dart';

class PetsDatasource {
  final Api api;

  PetsDatasource({required this.api});

  Future<String> getPets() async {
    final response = await api.get("/pets");

    return _manageResponse<String>(
      response,
      parseJson: (json) => json,
      message: 'Failed to load pets',
    );
  }

  T _manageResponse<T>(Response response,
      {required T Function(dynamic) parseJson, required String message}) {
    if (_isSuccessful(response)) {
      return parseJson(response.body);
    } else {
      throw Exception(message);
    }
  }

  bool _isSuccessful(Response response) => response.statusCode >= 200 || response.statusCode < 300;
}
