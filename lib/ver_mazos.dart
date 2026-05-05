import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerMazos extends StatelessWidget {
  const VerMazos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Mazos')),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6D00),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/crearMazo');
        },
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('mazos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 80, color: Colors.white54),
                  SizedBox(height: 16),
                  Text(
                    'No hay mazos registrados.',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data();

              final nombre = data['nombre'] ?? 'Sin nombre';
              final descripcion = data['descripcion'] ?? 'Sin descripción';

              return Card(
                color: Colors.white,
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  // 🔵 CÍRCULO IZQUIERDO
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFFF6D00),
                    radius: 24,
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  // 🧠 TEXTO
                  title: Text(
                    nombre,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      descripcion,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),

                  isThreeLine: true,

                  // 👉 BOTONES DERECHA
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDITAR
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/crearMazo',
                            arguments: {
                              'id': doc.id,
                              'nombre': nombre,
                              'descripcion': descripcion,
                            },
                          );
                        },
                      ),

                      // ELIMINAR
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.orange),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('mazos')
                              .doc(doc.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
