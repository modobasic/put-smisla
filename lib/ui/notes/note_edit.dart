import 'package:flutter/material.dart';

import '../../db/app_database.dart';

class NoteEditScreen extends StatefulWidget {
  final int userId;
  final int? id; // null = nova refleksija
  final String? initialText;

  const NoteEditScreen({
    super.key,
    required this.userId,
    this.id,
    this.initialText,
  });

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _c;

  @override
  void initState() {
    super.initState();
    _c = TextEditingController(text: widget.initialText ?? "");
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.id != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Uredi refleksiju" : "Nova refleksija"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _c,
                minLines: 6,
                maxLines: 12,
                decoration: const InputDecoration(
                  labelText: "Tekst refleksije",
                  hintText: "Zapiši svoju misao, uvid ili zaključak...",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return "Upiši nešto";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final text = _c.text.trim();

                  if (isEdit) {
                    await AppDatabase.instance.updateNote(
                      id: widget.id!,
                      text: text,
                    );
                  } else {
                    await AppDatabase.instance.insertNote(
                      userId: widget.userId,
                      text: text,
                    );
                  }

                  if (mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save_rounded),
                label: const Text("Spremi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}