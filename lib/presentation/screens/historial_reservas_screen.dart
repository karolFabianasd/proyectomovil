import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HistorialReservasScreen extends StatefulWidget {
  @override
  _HistorialReservasScreenState createState() => _HistorialReservasScreenState();
}

class _HistorialReservasScreenState extends State<HistorialReservasScreen> {
  late Future<DataSnapshot> _futureReservas;

  @override
  void initState() {
    super.initState();
    _futureReservas = _getReservas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Reservas'),
        backgroundColor: Colors.indigo,
         automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DataSnapshot>(
          future: _futureReservas,
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List<dynamic> reservas = _parseReservas(snapshot.data);
              if (reservas.isEmpty) {
                return Center(child: Text('No hay reservas.'));
              }
              return ListView.builder(
                itemCount: reservas.length,
                itemBuilder: (context, index) {
                  final reserva = reservas[index];
                  return _buildReservaCard(reserva);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<DataSnapshot> _getReservas() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.ref('reservas');
    DatabaseEvent databaseEvent = await databaseReference.once();
    return databaseEvent.snapshot;
  }

  List<dynamic> _parseReservas(DataSnapshot? dataSnapshot) {
    List<dynamic> reservas = [];
    if (dataSnapshot != null && dataSnapshot.value != null) {
      Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        value['key'] = key;
        reservas.add(value);
      });
    }
    return reservas;
  }

  Widget _buildReservaCard(Map<dynamic, dynamic> reserva) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(reserva['imagenUrl']),
                radius: 30,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reserva['nombre'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[800],
                    ),
                  ),
                  Text(
                    reserva['categoria'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.indigo[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            reserva['descripcion'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Fecha: ${reserva['fecha']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Hora: ${reserva['hora']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Precio: \$${reserva['precio']}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[800],
            ),
          ),
        ],
      ),
    );
  }
}
