import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/use_case/failure.dart';

abstract class HttpServiceBase {
  Future<Map<String, dynamic>> get(
      {required String url, Map<String, String>? headers});

  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  });
}

class HttpService extends HttpServiceBase {
  final http.Client httpClient;

  HttpService({required this.httpClient});

  @override
  Future<Map<String, dynamic>> get(
      {required String url, Map<String, String>? headers}) async {
    final response = await httpClient.get(Uri.parse(url), headers: headers);
    _checkStatusCode(response.statusCode, response.body);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    final response = await httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );
    _checkStatusCode(response.statusCode, response.body);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  void _checkStatusCode(int statusCode, String body) {
    if (statusCode == 200) return;

    throw UnhandledFailure(message: body);
  }
}
