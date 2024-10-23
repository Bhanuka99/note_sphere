import 'package:flutter/material.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/services/note_service.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:notesphere/widgets/note_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  final NoteService noteService = NoteService();
  List<Note> allNotes = [];
  Map<String, List<Note>> notesWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkAndCreateNotes();
  }

  //check whether the user is new
  void _checkAndCreateNotes() async {
    final bool isNewUser = await noteService.isNewUser();
    //if the user is new create initial notes
    if(isNewUser){
      await noteService.createdInitialNotes();
    }

    //load the notes
    _loadNotes();

  }
  //method for load notes
  Future<void> _loadNotes () async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    final Map<String, List<Note>> notesByCategory = 
          noteService.getNotesByCategoryMap(loadedNotes);
    setState(() {
      allNotes = loadedNotes;
      notesWithCategory = notesByCategory;
    });
  }

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
        body: Padding(
          padding:const EdgeInsets.all(AppConstants.kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notes",
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              allNotes.isEmpty ? SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: Center(
                  child: Text(
                      "No notes available , click on the + button to add a new note",
                      style: TextStyle(
                      color: AppColors.kWhiteColor.withOpacity(0.7),
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ) : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: 
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstants.kDefaultPadding,
                  mainAxisSpacing: AppConstants.kDefaultPadding,
                  childAspectRatio: 6/4
                ),
                itemCount: notesWithCategory.length, 
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: () {
                      //go to notes by category page
                      AppRouter.router.push(
                        "/category",
                        extra: notesWithCategory.keys.elementAt(index)
                        );
                    },
                    child: NoteCard(
                      notesCategory: notesWithCategory.keys.elementAt(index), 
                      numOfNotes: notesWithCategory.values.elementAt(index).length
                    ),
                  );
                }
                )
            ],
          ), 
        ),
    );
  }
}