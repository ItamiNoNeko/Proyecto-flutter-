import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteListPage extends StatelessWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Notas"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.note),
            title: Text("Nota ${index + 1}"),
            subtitle: const Text("Contenido privado..."),
            onTap: () => context.go('/editor'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/editor'),
        child: const Icon(Icons.add),
      ),
    );
  }
}