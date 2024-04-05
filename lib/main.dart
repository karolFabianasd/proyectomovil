import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/aceite_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_screen.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/presentation/screens/registro_screen.dart';

void main() {
  runApp(const MyApp());
}
// final GoRouter _router = GoRouter(
//   routes: <GoRoute>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) =>  const LoginScreen(),
//       routes: <GoRoute>[
//         GoRoute(
//           path: 'home',
//           builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
//         ),
//         GoRoute(
//           path: 'lavado',
//           builder: (BuildContext context, GoRouterState state) => const LavadoScreen(),
//         ),
//         // GoRoute(
//         //   path: 'aceites',
//         //   builder: (BuildContext context, GoRouterState state) => const AceiteScreen(),
//         // ),
//         // GoRoute(
//         //   path: 'mantenimiento',
//         //   builder: (BuildContext context, GoRouterState state) => const MantenimientoScreen(),
//         // ),
//         // GoRoute(
//         //   path: 'tapiceria',
//         //   builder: (BuildContext context, GoRouterState state) => const TapiceriaScreen(),
//         // ),
//       ],
//     ),
//   ],
// );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const LoginScreen(),
      '/registro': (context) => const RegisterScreen(),
      '/dashboard': (context) => const DashboardScreen(),
      '/aceite': (context) => const AceiteScreen(),
    });
  }
}
