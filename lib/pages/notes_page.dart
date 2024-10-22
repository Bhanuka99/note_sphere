import 'package:flutter/material.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          //goto home page
          AppRouter.router.go("/");
        }, 
        icon: const Icon(Icons.arrow_back)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          )
        ),
        child: const Icon(Icons.add,
        color: AppColors.kWhiteColor,
        size: 30,
        ),
        ),
        body: const Padding(
          padding:EdgeInsets.all(AppConstants.kDefaultPadding),
          child: Column(
            children: [
              Text(
                "Notes",
                style: AppTextStyles.appTitle,
              ),
            ],
          ), 
        ),
    );
  }
}