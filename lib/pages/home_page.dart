import 'package:flutter/material.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: AppConstants.kDefaultPadding
            ),
            const ProgressCard(
              completedTask: 5,
              totalTask: 5,
            ),
            const SizedBox(
              height: AppConstants.kDefaultPadding*1.5
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //goto notes page
                    AppRouter.router.push("/notes");
                  },
                  child: const NotesTodoCard(
                    title: "Note", 
                    descript: "3 Notes", 
                    icon: Icons.bookmark_add_outlined
                  ),
                ),
                 GestureDetector(
                  onTap: () {
                    //goto todo page
                    AppRouter.router.push("/todos");
                  },
                   child: const NotesTodoCard(
                    title: "To-Do List", 
                    descript: "3 Tasks", 
                    icon: Icons.today_outlined
                  ),
                 ),
              ],
            ),
            const SizedBox(
              height: AppConstants.kDefaultPadding
            ),
            const Row(
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