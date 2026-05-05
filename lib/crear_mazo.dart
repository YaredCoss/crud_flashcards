import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CrearMazo extends StatefulWidget {
  const CrearMazo({super.key});

  @override
  State<CrearMazo> createState() => _CrearMazoState();
}

class _CrearMazoState extends State<CrearMazo> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  String? id;

  @override
  void didChangeDependencies() {
    final data = ModalRoute.of(context)!.settings.arguments;

    if (data != null) {
      final args = data as Map;

      id = args['id'];
      nombreController.text = (args['nombre'] ?? '').toString();
      descripcionController.text = (args['descripcion'] ?? '').toString();
    }

    super.didChangeDependencies();
  }

  Future<void> guardarMazo() async {
    final nombre = nombreController.text.trim();
    final descripcion = descripcionController.text.trim();

    if (nombre.isEmpty) return;

    if (id == null) {
      await FirebaseFirestore.instance.collection('mazos').add({
        'nombre': nombre,
        'descripcion': descripcion,
      });
    } else {
      await FirebaseFirestore.instance.collection('mazos').doc(id).update({
        'nombre': nombre,
        'descripcion': descripcion,
      });
    }

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id == null ? 'Crear Mazo' : 'Editar Mazo'),
        backgroundColor: const Color(0xFF252525),
      ),

      backgroundColor: const Color(0xFF1E1E1E),

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
                  const Icon(Icons.style, size: 60, color: Color(0xFFFF6D00)),
                  const SizedBox(height: 10),

                  const Text(
                    'Datos del Mazo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 👈 negro
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 👇 NOMBRE
                  TextField(
                    controller: nombreController,
                    style: const TextStyle(color: Colors.black), // texto negro
                    decoration: InputDecoration(
                      labelText: 'Nombre del mazo',
                      labelStyle: const TextStyle(color: Colors.black), // negro
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 👇 DESCRIPCIÓN
                  TextField(
                    controller: descripcionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.black), // texto negro
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: const TextStyle(color: Colors.black), // negro
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black26),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.black),
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
                      onPressed: guardarMazo,
                      child: Text(
                        id == null ? 'CREAR MAZO' : 'ACTUALIZAR',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
