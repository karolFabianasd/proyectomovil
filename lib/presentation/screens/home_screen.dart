import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/aceite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Aplicación"), // Aquí defines el título del AppBar
        backgroundColor: Colors.indigo, // Y el color de fondo, si lo deseas
      ),
      body: _buildGridView(),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 40,
        mainAxisSpacing: 30,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          itemDashboard(context, "Lavado", Icons.local_car_wash, '/lavado'),
          itemDashboard(context, "Aceites", Icons.build, '/aceite'),
          itemDashboard(context, "Mantenimiento", Icons.place, '/lavado'),
          itemDashboard(
              context, "Tapiceria", Icons.miscellaneous_services, '/lavado'),
          itemDashboard(context, "Lavado", Icons.local_car_wash, '/lavado'),
        ],
      ),
    );
  }

  Widget itemDashboard(
      BuildContext context, String title, IconData icon, String path) {
    return InkWell(
      onTap: () {
        // Navega a la pantalla correspondiente según la ruta proporcionada
        switch (path) {
          case '/lavado':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AceiteScreen()),
            );
            break;
          case '/aceites':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AceiteScreen()),
            );
            break;
          case '/mantenimiento':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AceiteScreen()),
            );
            break;
          case '/tapiceria':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AceiteScreen()),
            );
            break;
          case '/accesorios':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AceiteScreen()),
            );
            break;
          default:
            // Si no hay una pantalla definida para la ruta, no hace nada
            break;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(0.2), // Sombra gris
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30, // Tamaño del ícono
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
