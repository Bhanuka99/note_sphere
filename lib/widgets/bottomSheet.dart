import 'package:flutter/material.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/text_styles.dart';

class CategoryInputBottomSheet extends StatefulWidget {

  final Function() onNewNote;
  final Function() onNewCategory;
  const CategoryInputBottomSheet({
    super.key, 
    required this.onNewNote, 
    required this.onNewCategory
  });

  @override
  State<CategoryInputBottomSheet> createState() => _CategoryInputBottomSheetState();
}

class _CategoryInputBottomSheetState extends State<CategoryInputBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.5,
      decoration: const BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadding*1.5),
        child: Column(
          children: [
            GestureDetector(
              onTap: widget.onNewNote,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create a New Note",
                  style: AppTextStyles.appDescriptionLarge,
                  ),
                  Icon(
                    Icons.arrow_right_outlined,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Divider(
              color: AppColors.kWhiteColor.withOpacity(0.3),
              thickness: 1,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onNewCategory,

              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create a New Note Category",
                  style: AppTextStyles.appDescriptionLarge,
                  ),
                  Icon(
                    Icons.arrow_right_outlined,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}