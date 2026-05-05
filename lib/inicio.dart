import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flashcards Estudio")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://raw.githubusercontent.com/YaredCoss/Imagenes-para-flutter-6J-11-02-2026/refs/heads/main/Captura3.PNG",
                height: 200,
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                ),
                icon: const Icon(Icons.layers),
                label: const Text("Mazos"),
                onPressed: () {
                  Navigator.pushNamed(context, '/verMazos');
                },
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(200, 50),
                ),
                icon: const Icon(Icons.style),
                label: const Text("Tarjetas"),
                onPressed: () {
                  Navigator.pushNamed(context, '/verTarjetas');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
