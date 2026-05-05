import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearTarjeta extends StatefulWidget {
  const CrearTarjeta({super.key});

  @override
  State<CrearTarjeta> createState() => _CrearTarjetaState();
}

class _CrearTarjetaState extends State<CrearTarjeta> {
  final palabra = TextEditingController();
  final definicion = TextEditingController();

  String? id;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    if (args != null) {
      id = args['id'];
      palabra.text = args['palabra'] ?? '';
      definicion.text = args['definicion'] ?? '';
    }

    super.didChangeDependencies();
  }

  void guardar() async {
    if (id == null) {
      await FirebaseFirestore.instance.collection('tarjetas').add({
        'palabra': palabra.text,
        'definicion': definicion.text,
      });
    } else {
      await FirebaseFirestore.instance.collection('tarjetas').doc(id).update({
        'palabra': palabra.text,
        'definicion': definicion.text,
      });
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF252525),
        title: Text(id == null ? "Crear Tarjeta" : "Editar Tarjeta"),
        centerTitle: true,
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.style, size: 70, color: Color(0xFFFF6D00)),

                  const SizedBox(height: 10),

                  const Text(
                    "Datos de la Tarjeta",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🟠 PALABRA
                  TextField(
                    controller: palabra,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "Palabra",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 🟠 DEFINICIÓN
                  TextField(
                    controller: definicion,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: "Definición",
                      labelStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6D00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: guardar,
                      child: Text(
                        id == null ? "CREAR TARJETA" : "ACTUALIZAR",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
