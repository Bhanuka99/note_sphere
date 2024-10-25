import 'package:flutter/material.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/services/note_service.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:notesphere/widgets/note_category_card.dart';

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
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            //goto notes page
            AppRouter.router.go("/notes");
          }, 
          icon: const Icon(
            Icons.arrow_back
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.symmetric(
            horizontal: AppConstants.kDefaultPadding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 7/11,
                ),
                itemCount: notelist.length, 
                itemBuilder: (context, index){
                  return NoteCategoryCard(
                    noteTitle: notelist[index].title, 
                    noteContent: notelist[index].content, 
                    removeNote: ()async{}, 
                    editNote: ()async{},
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}