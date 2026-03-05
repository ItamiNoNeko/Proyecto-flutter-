import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:safevault/screens/note_editor_page.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteEditorPage()),
              );
            },
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