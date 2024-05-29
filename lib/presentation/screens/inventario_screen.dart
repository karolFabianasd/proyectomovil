import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/dbHelper/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class InventarioScreen extends StatefulWidget {
  @override
  _InventarioScreenState createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final controlerDetailsNombre = TextEditingController();
  final controlerDetailsDescripcion = TextEditingController();
  final controlerDetailsPrecio = TextEditingController();
  final controlerDetailsImage = TextEditingController();
  String? selectedCategoria;

  final List<String> categorias = ['Aceites', 'Mantenimiento', 'Lavados'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
         automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextFormFieldNombre("Nombre", Icons.person),
                _buildTextFormFieldDescription("Descripcion", Icons.description),
                _buildTextFormFieldPrecio("Precio", Icons.attach_money),
                _buildTextFormFieldImage("Image", Icons.image),
                _buildDropdownButtonFormField(),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final nombre = controlerDetailsNombre.value.text;
                      final descripcion = controlerDetailsDescripcion.value.text;
                      final precio = controlerDetailsPrecio.value.text;
                      final image = controlerDetailsImage.value.text;
                      final categoria = selectedCategoria;

                      if (categoria != null) {
                        await _guardarProducto(nombre, descripcion, precio, image, categoria);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Producto guardado ')),
                        );
                        // Limpiar los campos después de guardar
                        controlerDetailsNombre.clear();
                        controlerDetailsDescripcion.clear();
                        controlerDetailsPrecio.clear();
                        controlerDetailsImage.clear();
                        setState(() {
                          selectedCategoria = null;
                        });

                      } else {
                             print('else null categoria');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Por favor, selecciona una categoría.'))
                        );
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo),
                    child: const Center(
                      child: Text('Guardar',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 Future<void> _guardarProducto(String nombre, String descripcion, String precio, String image, String categoria) async {
    // Inicializar la referencia de la base de datos de Firebase
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref("inventarios");

    // Crear un nuevo producto
    Map<String, dynamic> producto = {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'image': image,
      'categoria': categoria,
    };

    // Guardar el producto en la base de datos
    await databaseReference.push().set(producto);
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
        controller: controlerDetailsNombre,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa un nombre';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextFormFieldDescription(String titleHint, IconData icon) {
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
        controller: controlerDetailsDescripcion,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una descripción';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextFormFieldPrecio(String titleHint, IconData icon) {
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
        controller: controlerDetailsPrecio,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa un precio';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildTextFormFieldImage(String titleHint, IconData icon) {
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
        controller: controlerDetailsImage,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, ingresa una URL de imagen';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownButtonFormField() {
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
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.category),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        hint: const Text(
          'Categoría',
          style: TextStyle(color: Colors.blueGrey),
        ),
        value: selectedCategoria,
        items: categorias.map((String categoria) {
          return DropdownMenuItem<String>(
            value: categoria,
            child: Text(categoria),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedCategoria = newValue;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Por favor, selecciona una categoría';
          }
          return null;
        },
      ),
    );
  }
}
