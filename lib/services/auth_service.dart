import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String _url = "https://carros-electricos.wiremockapi.cloud/auth";

  Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"]; 
    } else {
      return null; 
    }
  }
}
