import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VerTarjetas extends StatelessWidget {
  const VerTarjetas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252525),
        title: const Text("Tarjetas"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF6D00),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/crearTarjeta');
        },
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tarjetas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card, size: 80, color: Colors.white54),
                  SizedBox(height: 12),
                  Text(
                    "No hay tarjetas registradas",
                    style: TextStyle(color: Colors.white70),
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

              final palabra = data['palabra'] ?? '';
              final definicion = data['definicion'] ?? '';

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),

                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFFF6D00),
                    child: Icon(Icons.style, color: Colors.white),
                  ),

                  title: Text(
                    palabra,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 👈 negro
                    ),
                  ),

                  subtitle: Text(
                    definicion,
                    style: const TextStyle(
                      color: Colors.black, // 👈 negro
                    ),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/crearTarjeta',
                            arguments: {
                              'id': doc.id,
                              'palabra': palabra,
                              'definicion': definicion,
                            },
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('tarjetas')
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
