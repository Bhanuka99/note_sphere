import 'package:flutter/material.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:notesphere/widgets/notes_todo_card.dart';
import 'package:notesphere/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "NoteSphere",
          style: AppTextStyles.appTitle
          ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: AppConstants.kDefaultPadding
            ),
            ProgressCard(
              completedTask: 5,
              totalTask: 5,
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding*1.5
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NotesTodoCard(
                  title: "Note", 
                  descript: "3 Notes", 
                  icon: Icons.bookmark_add_outlined
                ),
                NotesTodoCard(
                  title: "To-Do List", 
                  descript: "3 Tasks", 
                  icon: Icons.today_outlined
                ),
              ],
            ),
            SizedBox(
              height: AppConstants.kDefaultPadding
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress",style: AppTextStyles.appSubtitle,),
                Text("See All",style: AppTextStyles.appButton,),
              ],
            )
          ],
        ), 
      ),
    );
  }
}