import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/screens/aceite_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_admin_screen.dart';
import 'package:flutter_application_1/presentation/screens/dashboard_screen.dart';
import 'package:flutter_application_1/presentation/screens/home_screen.dart';
import 'package:flutter_application_1/presentation/screens/home_screen_admin.dart';
import 'package:flutter_application_1/presentation/screens/login_screen.dart';
import 'package:flutter_application_1/presentation/screens/registro_screen.dart';

Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAn6GUIMiBd4t_OYks5Dw1vP4uuGY5ffGU", // paste your api key here
      appId:  "1:1087925949233:android:264043b70ed9b99923d610", //paste your app id here
      messagingSenderId: "1087925949233", //paste your messagingSenderId here
      projectId: "autostock-5f89d", //paste your project id here
    ),
  );
  runApp(MyApp());
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
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const LoginScreen(),
      '/registro': (context) =>  RegisterScreen(),
      '/dashboard': (context) => const DashboardScreen(),
      '/dashboardAdmin': (context) => const DashboardAdminScreen(),
      '/home': (context) => const HomeScreen(),
      '/homeAdmin': (context) => const HomeAdminScreen(),
    },
    debugShowCheckedModeBanner: false,
    );
  }
}
