import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum HttpMethod { get, post, put, delete, patch }

class ApiService {
  final String _baseUrl = dotenv.env['API_BASE_URL']!;

  Future<dynamic> _request(
      HttpMethod method,
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // if (_token != null && _token!.isNotEmpty) {
    //   headers['Authorization'] = 'Bearer $_token';
    // }

    final uri = Uri.parse('$_baseUrl$endpoint');
    final encodedBody = body != null ? jsonEncode(body) : null;
    http.Response response;

    try {
      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: headers);
          break;
        case HttpMethod.post:
          response = await http.post(uri, headers: headers, body: encodedBody);
          break;
        case HttpMethod.put:
          response = await http.put(uri, headers: headers, body: encodedBody);
          break;
        case HttpMethod.delete:
          response = await http.delete(uri, headers: headers);
          break;
        case HttpMethod.patch:
          response = await http.patch(uri, headers: headers, body: encodedBody);
          break;
      }

      return _handleResponse(response);

    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception(
          'Falha na requisição: ${response.statusCode}\nCorpo: ${response.body}'
      );
    }
  }

  Future<dynamic> get(String endpoint) =>
      _request(HttpMethod.get, endpoint);

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) =>
      _request(HttpMethod.post, endpoint, body: body);

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) =>
      _request(HttpMethod.put, endpoint, body: body);

  Future<dynamic> delete(String endpoint) =>
      _request(HttpMethod.delete, endpoint);

  Future<dynamic> patch(String endpoint, {Map<String, dynamic>? body}) =>
      _request(HttpMethod.patch, endpoint, body: body);
}