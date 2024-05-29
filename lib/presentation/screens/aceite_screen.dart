import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AceiteScreen extends StatelessWidget {
  
   const AceiteScreen({Key? key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos de Aceite"),
        backgroundColor: Colors.indigo,
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

           // Dividir la lista de productos en pares
           return SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: products.map((product) {
                  return itemDashboard(
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
        if (value['categoria'] == 'Aceites') {
          products.add(value);
        }
      });
    }
    return products;
  }

 Widget itemDashboard(String nombre, String descripcion, String precio, String imagenUrl, String categoria, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width * 0.45, 
      height: MediaQuery.of(context).size.height * 0.30,
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(imagenUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
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
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  descripcion,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$$precio',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    userType == 'admin'
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {},
                          )
                        : ElevatedButton(
                            onPressed: () {},
                            child: Text('Reservar'),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

