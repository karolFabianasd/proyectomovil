import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final controlerDetailsNombre = TextEditingController();
  final controlerDetailsApellido = TextEditingController();
  final controlerDetailsTelefono = TextEditingController();
  final controlerDetailsCorreo = TextEditingController();
  final controlerDetailsPass = TextEditingController();
   FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextFormFieldNombre("Nombre", Icons.person),
              _buildTextFormFieldApellido("Apellido", Icons.person),
              _buildTextFormFieldTelefono("Telefono", Icons.phone),
              _buildTextFormFieldCorreo("Correo", Icons.email),
              _buildTextFormFieldPassword("Contraseña", Icons.lock),
              GestureDetector(
                onTap: () {
                  final nombre = controlerDetailsNombre.value.text;
                  final apellido = controlerDetailsApellido.value.text;
                  final tel = controlerDetailsTelefono.value.text;
                  final correo = controlerDetailsCorreo.value.text;
                  final pass = controlerDetailsPass.value.text;

               
                    _signUp(nombre, correo,pass,context);
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.indigo),
                  child: const Center(
                    child: Text('Registrarse',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormFieldNombre(String titleHint, IconData icon) {
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
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        onChanged: (value) {
          print(value);
        },
        controller: controlerDetailsNombre,
      ),
    );
  }

  Widget _buildTextFormFieldApellido(String titleHint, IconData icon) {
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
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        onChanged: (value) {
          print(value);
        },
        controller: controlerDetailsApellido,
      ),
    );
  }

  Widget _buildTextFormFieldTelefono(String titleHint, IconData icon) {
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
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        onChanged: (value) {
          print(value);
        },
        controller: controlerDetailsTelefono,
      ),
    );
  }

  Widget _buildTextFormFieldCorreo(String titleHint, IconData icon) {
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
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        onChanged: (value) {
          print(value);
        },
        controller: controlerDetailsCorreo,
      ),
    );
  }

  Widget _buildTextFormFieldPassword(String titleHint, IconData icon) {
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
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          hintText: titleHint,
          hintStyle: const TextStyle(color: Colors.blueGrey),
        ),
        onChanged: (value) {
          print(value);
        },
        controller: controlerDetailsPass,
      ),
    );
  }

   void _signUp(String user,String correo, String pass,  context) async {
    User? user = await _auth.signUpWithEmail(correo, pass);
    
    if (user!=null){
 Navigator.pushNamed(context, '/');
    }else{
      print('algo salio mal');
    }
  }
}
