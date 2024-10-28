import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/text_styles.dart';

class ViewNotePage extends StatefulWidget {
  final Note note;
  const ViewNotePage({super.key, required this.note});

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  @override
  Widget build(BuildContext context) {
    //formatted date
    final formattedDate = DateFormat.yMMMd().format(widget.note.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.title,
              style: AppTextStyles.appTitle,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.note.category,
              style: AppTextStyles.appButton.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5)
              )
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              formattedDate,
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kFabColor
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.note.content,
              style: AppTextStyles.appDescriptionLarge.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.4),
              )
            ),
          ],
        ),
      ),
    );
  }
}