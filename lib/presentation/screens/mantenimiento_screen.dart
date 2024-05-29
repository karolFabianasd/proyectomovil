import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MantenimientoScreen extends StatelessWidget {
  const MantenimientoScreen({Key? key, required String userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos de Aceite"),
        backgroundColor: Colors.indigo,
         automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<DataSnapshot>(
        future: _getAceiteProducts(), // Llama a la función que obtiene los productos de aceite
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<dynamic> products = _filterProducts(snapshot.data);

            if (products.isEmpty) {
              return Center(child: Text('No hay productos de aceite disponibles.'));
            }

            return SingleChildScrollView(
              child: GridView.count(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: products.map((product) {
                    return 
                     itemDashboard(
                        product['nombre'],
                        product['descripcion'],
                        product['precio'],
                        product['image'],
                        product['categoria'],
                         context,
                      );
                    
                  }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  // Función para obtener los productos de aceite desde la base de datos
  Future<DataSnapshot> _getAceiteProducts() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('inventarios');
    DatabaseEvent databaseEvent = await databaseReference.once();
    DataSnapshot dataSnapshot = databaseEvent.snapshot;
    return dataSnapshot;
  }

  // Función para filtrar los productos de aceite
  List<dynamic> _filterProducts(DataSnapshot? dataSnapshot) {
    List<dynamic> products = [];
    if (dataSnapshot != null && dataSnapshot.value != null) {
      Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        if (value['categoria'] == 'Mantenimiento') {
          products.add(value);
        }
      });
    }
    return products;
  }

Widget itemDashboard(String nombre, String descripcion, String precio, String imagenUrl, String categoria, BuildContext context) {
  return Container(
    margin: EdgeInsets.all(10), // Margen entre las tarjetas
    width: MediaQuery.of(context).size.width * 0.45, // Ancho del contenedor principal
    decoration: BoxDecoration(
      color: Colors.white, // Color de fondo
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          offset: const Offset(0, 5),
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagenUrl), // Carga la imagen desde la URL
                fit: BoxFit.cover, // Ajusta el tamaño de la imagen para que cubra el contenedor
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                descripcion,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '\$$precio',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                categoria,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


}
