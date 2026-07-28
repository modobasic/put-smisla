import 'package:flutter/material.dart';

import '../../db/app_database.dart';
import 'note_edit.dart';

class NotesListScreen extends StatefulWidget {
  final int userId;

  const NotesListScreen({
    super.key,
    required this.userId,
  });

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  Future<List<Map<String, Object?>>> _load() =>
      AppDatabase.instance.getNotes(widget.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moje refleksije"),
        centerTitle: true,
      ),

      // ➕ DODAVANJE NOVE
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NoteEditScreen(
                userId: widget.userId,
              ),
            ),
          );
          if (mounted) setState(() {});
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text("Dodaj"),
      ),

      body: FutureBuilder<List<Map<String, Object?>>>(
        future: _load(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snap.data!;

          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Još nema refleksija.\nZapiši svoju prvu misao ✍️",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 90),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),

            itemBuilder: (context, i) {
              final row = items[i];
              final id = row['id'] as int;
              final text = row['text'] as String;
              final createdAt = row['createdAt'] as String;

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

                  title: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  subtitle: Text(
                    createdAt.split('T').first,
                  ),

                  // ✏️ EDIT
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteEditScreen(
                          userId: widget.userId,
                          id: id,
                          initialText: text,
                        ),
                      ),
                    );

                    if (mounted) setState(() {});
                  },

                  // 🗑 DELETE
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () async {
                      await AppDatabase.instance.deleteNote(id);

                      if (mounted) setState(() {});
                    },
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