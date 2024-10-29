import 'package:flutter/material.dart';
import 'package:notesphere/utils/text_styles.dart';

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "ToDo Tab",
        style: AppTextStyles.appTitle,  
      ),
    );
  }
}