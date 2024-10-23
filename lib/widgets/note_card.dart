import 'package:flutter/material.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/text_styles.dart';

class NoteCard extends StatelessWidget {

  final String notesCategory;
  final int numOfNotes;
  const NoteCard(
    {super.key, 
    required this.notesCategory, 
    required this.numOfNotes
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2,
            offset: Offset(0, 5)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notesCategory,
            style: AppTextStyles.appSubtitle.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            "$numOfNotes notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5)
            ),
          ),
        ],
      ),
    );
  }
}