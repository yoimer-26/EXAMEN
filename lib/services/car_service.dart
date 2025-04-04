import 'dart:convert';
import 'package:http/http.dart' as http;

class CarService {
  Future<List<dynamic>> obtenerCarros(String token) async {
    final url = Uri.parse('https://carros-electricos.wiremockapi.cloud/carros');

    final response = await http.get(
      url,
      headers: {'Authentication': token}


    );

    if (response.statusCode == 200) {
      final carros = json.decode(response.body); 
      
      
      print("Datos recibidos del API: $carros");

      return carros; 
    } else {
      print("Error al obtener los carros: ${response.statusCode}");
      throw Exception('Error al obtener los carros');
    }
  }
}
