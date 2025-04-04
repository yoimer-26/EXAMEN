import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'controllers/auth_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carros Eléctricos',
      home: LoginScreen(),
    );
  }
}
