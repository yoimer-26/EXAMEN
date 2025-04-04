import 'package:flutter/material.dart';

class TarjetaCarro extends StatelessWidget {
  final String placa;
  final String conductor;

  const TarjetaCarro({super.key, required this.placa, required this.conductor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          color: Colors.grey.shade300,
        ),
        title: Text("Placa: $placa"),
        subtitle: Text("Conductor: $conductor"),
      ),
    );
  }
}
