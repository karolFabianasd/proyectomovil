import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_admin_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_screen.dart';
import 'package:flutter_application_1/presentation/screens/registro_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
   FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 252, 252, 252),
        title: const Text('Inicio De Sesión'),
      ),
      backgroundColor: const Color.fromARGB(255, 252, 252, 252),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://drive.google.com/uc?export=view&id=1IJTiWrWq5j7DBJ16OUrSrjaeJ30YfmsV',
                width: 180,
                height: 180,
              ),
              _buildTextFormField("Usuario", Icons.person, controllerUsername),
              _buildTextFormField("Contraseña", Icons.lock, controllerPassword),
              GestureDetector(
                onTap: () {
                  final username = controllerUsername.text;
                  final password = controllerPassword.text;
                  _signIn(username,password,context);
               
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.indigo,
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Registrate',
                  style: TextStyle(color: Colors.indigo, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      String titleHint, IconData icon, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 10),
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
        controller: controller,
      ),
    );
  }

   void _signIn(correo, pass , context) async {
   
 

    User? user = await _auth.signInWithEmail(correo, pass);
    
    if (user!=null){
 Navigator.pushNamed(context, '/home');
    }else{
      print('algo salio mal');
    }
  }
}
