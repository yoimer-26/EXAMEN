import 'package:flutter/material.dart';
import '../services/car_service.dart'; 

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _carros = []; 

  @override
  void initState() {
    super.initState();
    obtenerListaCarros();
  }

  // Función para obtener los carros
  void obtenerListaCarros() async {
    try {
      CarService carService = CarService();
      List<dynamic> carros = await carService.obtenerCarros(widget.token);
      setState(() {
        _carros = carros;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Carros')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Lista de Carros',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _carros.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_carros[index]['nombre']),
                  subtitle: Text('Modelo: ${_carros[index]['modelo']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
