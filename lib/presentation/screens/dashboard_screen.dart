import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/aceite_screen.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/presentation/screens/qr_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}


class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), // HomeScreen incluye tu GridView
    const QrScreen(),
    const HomeScreen(),
  ];



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'MyQr',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range),
            label: "Reservas"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
