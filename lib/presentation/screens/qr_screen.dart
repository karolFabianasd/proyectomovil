import 'package:flutter/material.dart';
import 'package:flutter_application_1/modelo/user.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
           automaticallyImplyLeading: false,
          title: const Text('Mi QR',style:TextStyle(color: Colors.white)),
          backgroundColor: Colors.indigo,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reserva Generada',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.indigo,
                  fontSize: 28,
                ),
              ),
              const SizedBox(height: 30), // Espacio entre el título y el QR
              // Código QR
              QrImageView(
                data: 'juan@17:30#servicio',
                version: QrVersions.auto,
                size: 280.0,
              ),
              const SizedBox(height: 39), // Espacio entre el QR y el mensaje
              // Mensaje descriptivo
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Este código QR será utilizado por nuestro equipo para procesar tu reserva de manera rápida y eficiente. ¡Gracias por confiar en nosotros!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.indigo,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}