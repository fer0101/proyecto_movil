import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spiner/dto/api_responce.dart';

class LoginService {
  static Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('http://localhost:9999/api/v1/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body =
        jsonEncode(LoginRequest(username: username, password: password));

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final loginResponse = LoginResponse.fromJson(jsonResponse);
      return loginResponse;
    } else {
      throw Exception('Error al realizar login');
    }
  }
}
