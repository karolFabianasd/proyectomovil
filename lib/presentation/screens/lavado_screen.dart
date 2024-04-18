import 'package:flutter/material.dart';

class LavadoScreen extends StatelessWidget {
  const LavadoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero, children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: height * 0.4,
          width: width,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100),
              topRight: Radius.circular(30),
            ),
          ),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 40,
            mainAxisSpacing: 30,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // Añadido para mejorar el desplazamiento
            children: [
              itemDashboard("Title 1", Icons.star),
              itemDashboard("Title 2", Icons.favorite),
              itemDashboard("Title 3", Icons.place),
              itemDashboard("Title 4", Icons.notifications),
              itemDashboard("Title 5", Icons.home),
              itemDashboard("Title 6", Icons.settings),
            ],
          ),
        ),
      ]),
    );
  }

  Widget itemDashboard(String title, IconData icon) {
    return Container(
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
    );
  }
}
