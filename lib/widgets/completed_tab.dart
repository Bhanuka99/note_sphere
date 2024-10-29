import 'package:flutter/material.dart';
import 'package:notesphere/utils/text_styles.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Completed Tab",
        style: AppTextStyles.appTitle,
      ),
    );
  }
}