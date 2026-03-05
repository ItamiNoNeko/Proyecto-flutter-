import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({super.key});

  @override
  State<NoteEditorPage> createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('La nota está vacía')));
      return;
    }

    // Aquí va tu lógica real de guardar (Firebase, local storage, etc.)
    print('Nota guardada: $text');

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nota guardada')));

    context.pop(); // Regresa después de guardar
  }

  Future<bool> _onWillPop() async {
    if (_controller.text.trim().isEmpty) {
      return true; // Deja que regrese sin preguntar si está vacío
    }

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Descartar cambios?'),
        content: const Text('La nota no se ha guardado.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // No descartar
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Sí descartar
            child: const Text('Descartar'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Para manejar el back button físico en Android
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Nueva Nota"),
          // La flecha de regreso aparece automáticamente si hay ruta anterior
          // No necesitas poner 'leading' manualmente a menos que quieras customizarla
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveNote,
              tooltip: 'Guardar nota',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: "Escribe tu nota aquí...",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _saveNote,
          tooltip: 'Guardar',
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
