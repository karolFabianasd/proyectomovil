import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/admin_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_admin_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_screen.dart';
import 'package:flutter_application_1/presentation/screens/registro_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerUsername = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 252, 252),
        title: const Text('Inicio De Sesión'),
      ),
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
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

                  if (username == 'admin' && password == 'admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardAdminScreen(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  }
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
}
