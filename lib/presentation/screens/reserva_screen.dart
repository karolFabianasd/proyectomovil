import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReservaScreen extends StatefulWidget {
  final String nombre;
  final String descripcion;
  final String precio;
  final String imagenUrl;
  final String categoria;

  ReservaScreen({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenUrl,
    required this.categoria,
  });

  @override
  _ReservaScreenState createState() => _ReservaScreenState();
}

class _ReservaScreenState extends State<ReservaScreen> {
  late TimeOfDay _selectedTime;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Inicializar la hora con la hora actual
    _selectedTime = TimeOfDay.now();
    // Inicializar la fecha con la fecha actual
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar ${widget.categoria}'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.indigo[50], // Color indigo claro
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.nombre}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo[800]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Descripción: ${widget.descripcion}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Precio: \$${widget.precio}',
                      style: TextStyle(fontSize: 16, color: Colors.indigo[800]),
                    ),
                    SizedBox(height: 16),
                    // Campo de texto para la fecha
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Fecha de reserva',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      ),
                    ),
                    SizedBox(height: 16),
                    // Campo de texto para la hora
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Hora de reserva',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            _selectTime(context);
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _selectedTime.format(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveReservation();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo, // Color indigo para el fondo
              ),
              child: const Text(
                'Reservar',
                style: TextStyle(
                  color: Colors.white, // Texto blanco
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para mostrar el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // Función para mostrar el selector de hora
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  // Función para guardar la reserva
  Future<void> _saveReservation() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref("reservas");

    Map<String, dynamic> reserva = {
      'nombre': widget.nombre,
      'descripcion': widget.descripcion,
      'precio': widget.precio,
      'imagenUrl': widget.imagenUrl,
      'categoria': widget.categoria,
      'fecha': '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
      'hora': _selectedTime.format(context),
    };

    // Guardar la reserva en la base de datos
    await databaseReference.push().set(reserva);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reserva guardada')),
    );

    Navigator.pop(context);
  }
}
