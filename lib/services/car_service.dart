import 'dart:convert';
import 'package:http/http.dart' as http;

class CarService {
  Future<List<Map<String, dynamic>>> obtenerCarros(String token) async {
    final url = Uri.parse('https://carros-electricos.wiremockapi.cloud/carros');

    final response = await http.get(
      url,
      headers: {
        'Authorization': token, 
        'Content-Type': 'application/json'
      },
    );

    print('TOKEN ENVIADO: $token');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => {
        'placa': item['placa'] ?? 'Sin placa',
        'conductor': item['conductor'] ?? 'Desconocido',
        'imagen': item['imagen'] ?? '',
      }).toList();
    } else {
      print("Error al obtener los carros: ${response.statusCode}");
      throw Exception('Error al obtener los carros');
    }
  }
}
