import 'package:flutter/material.dart';
import '../models/carro.dart';
import '../services/carros_service.dart';

class CarrosController extends ChangeNotifier {
  List<Carro> _carros = [];

  List<Carro> get carros => _carros;

  Future<void> cargarCarros(String token) async {
    final lista = await CarrosService.getCarros(token);
    _carros = lista;
    notifyListeners();
  }
}
