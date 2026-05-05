import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'inicio.dart';
import 'crear_mazo.dart';
import 'ver_mazos.dart';
import 'crear_tarjeta.dart';
import 'ver_tarjetas.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards Estudio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        primaryColor: Colors.orange,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const Inicio(),
        '/crearMazo': (context) => const CrearMazo(),
        '/verMazos': (context) => const VerMazos(),
        '/crearTarjeta': (context) => const CrearTarjeta(),
        '/verTarjetas': (context) => const VerTarjetas(),
      },
    );
  }
}
