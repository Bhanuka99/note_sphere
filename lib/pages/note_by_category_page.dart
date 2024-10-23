import 'package:flutter/material.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/services/note_service.dart';

class NoteByCategoryPage extends StatefulWidget {
  final String category;
  const NoteByCategoryPage({super.key, required this.category});

  @override
  State<NoteByCategoryPage> createState() => _NoteByCategoryPageState();
}

class _NoteByCategoryPageState extends State<NoteByCategoryPage> {

  final NoteService noteService = NoteService();
  List<Note> notelist = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //load all notes by category
  Future <void> _loadNotesByCategory () async {
    notelist = await noteService.getNotesByCategoryName(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
    );
  }
}