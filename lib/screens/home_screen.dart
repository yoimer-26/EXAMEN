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
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerListaCarros();
  }

  void obtenerListaCarros() async {
    print("🔄 Cargando carros...");
    try {
      CarService carService = CarService();
      List<dynamic> carros = await carService.obtenerCarros(widget.token);

      setState(() {
        _carros = carros;
        _cargando = false;
      });
    } catch (e) {
      print("❌ Error al obtener carros: $e");
      setState(() {
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Carros')),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : _carros.isEmpty
              ? const Center(child: Text("No hay carros disponibles"))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _carros.length,
                  itemBuilder: (context, index) {
                    final carro = _carros[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: carro['imagen'] != null &&
                                carro['imagen'].toString().isNotEmpty
                            ? Image.network(
                                carro['imagen'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print('❌ Error cargando imagen: $error');
                                  return const Icon(Icons.electric_car,
                                      color: Colors.green);
                                },
                              )
                            : const Icon(Icons.electric_car,
                                color: Colors.green),
                        title: Text(
                          carro['placa'] ?? "Sin placa",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Conductor: ${carro['conductor'] ?? 'Desconocido'}",
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
