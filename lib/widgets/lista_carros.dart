import 'package:flutter/material.dart';
import 'tarjeta_carro.dart';

class ListaCarros extends StatelessWidget {
  const ListaCarros({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> carros = [
      {"placa": "C01", "conductor": "Juan"},
      {"placa": "C02", "conductor": "Pedro"},
      {"placa": "C03", "conductor": "Luis"},
    ];

    return ListView.builder(
      itemCount: carros.length,
      itemBuilder: (context, index) {
        return TarjetaCarro(
          placa: carros[index]["placa"]!,
          conductor: carros[index]["conductor"]!,
        );
      },
    );
  }
}
