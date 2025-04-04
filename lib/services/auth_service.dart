import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String _url = "https://carros-electricos.wiremockapi.cloud/auth";

  static Future<String?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["token"]; // Extrae solo el token
      } else {
        print("Error en login: ${response.body}"); 
        return null; 
      }
    } catch (e) {
      print("Excepción en login: $e");
      return null;
    }
  }
}
