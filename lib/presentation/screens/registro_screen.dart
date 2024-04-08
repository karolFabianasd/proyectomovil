import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextFormField("Nombre",Icons.person),
            _buildTextFormField("Apellido",Icons.person),
            _buildTextFormField("Telefono",Icons.phone),
            _buildTextFormField("Correo",Icons.email),
            _buildTextFormField("Contraseña",Icons.lock),
            Container(
               margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo

              ),
              child: const Center(
                child: Text('Registrarse', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String titleHint, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon:  Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
