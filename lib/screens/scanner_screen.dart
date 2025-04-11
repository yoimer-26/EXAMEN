import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/api_service.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      try {
        final car = await ApiService().getCarByQR(scanData.code!);
        if (!mounted) return;

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            title: Text(
              '¿Desea tomar el Carro ${car.plate}?',
              style: const TextStyle(fontSize: 16),
            ),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(60, 36),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  controller.resumeCamera();
                },
                child: const Text('No', style: TextStyle(fontSize: 14)),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  minimumSize: const Size(60, 36),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/car_detail',
                    arguments: car,
                  );
                },
                child: const Text('Sí', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear QR')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}