import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetailScreen extends StatelessWidget {
  const CarDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Car car = ModalRoute.of(context)!.settings.arguments as Car;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Carro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Placa: ${car.plate}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('Conductor: ${car.driver}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            Image.network(
              car.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Text('Error al cargar la imagen');
              },
            ),
          ],
        ),
      ),
    );
  }
}