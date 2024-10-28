import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesphere/helpers/snackbar.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/services/note_service.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';

class EditNotePage extends StatefulWidget {
  
  final  Note note;
  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {

  List<String> categories = [];
  final NoteService noteService = NoteService();

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  String category = "";

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }
  

  Future _loadCategories () async {
    categories = await noteService.getAllCategories();
    setState(() {});
  }
  @override
  void initState() {
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    category = widget.note.category;
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Note",
          style: AppTextStyles.appSubtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.kDefaultPadding*0.5,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    //drop down
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if(value == null  || value.isEmpty){
                            return "please select a Category";
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                        isExpanded: false,
                        hint: Text(category),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                            width: 2
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstants.kDefaultPadding
                            ),
                            borderSide: const BorderSide(
                              color: AppColors.kWhiteColor,
                            width: 1
                            ),
                          ),
                        ),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: category,
                            child: Text(category,
                            style: AppTextStyles.appButton,
                            ),
                          );
                        }).toList(), 
                        onChanged: (String? value){
                          setState(() {
                            category = value!;
                          });
                        }
                      ),
                    ),
                    const SizedBox(height: 10,),
                    //title field
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if(value == null  || value.isEmpty){
                            return "please enter a Title";
                          }
                          return null;
                      },
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    //content
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if(value == null  || value.isEmpty){
                            return "please enter your Content";
                          }
                          return null;
                      },
                      maxLines: 12,
                      style: const TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    //button
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll((AppColors.kFabColor)),
                          ),
                          onPressed: (){
                            if(_formkey.currentState!.validate()){
                              try{
                                noteService.updateNote(
                                  Note(
                                    title: _noteTitleController.text, 
                                    category: category, 
                                    content: _noteContentController.text, 
                                    date: DateTime.now(),
                                    id: widget.note.id
                                  )
                                );
                                //show snack bar
                                AppHelpers.showSnackBar(context, "Note updated successfully");

                                _noteTitleController.clear();
                                _noteContentController.clear();
                                //navigate to note page
                                AppRouter.router.push("/notes");
                              }catch(err){
                                AppHelpers.showSnackBar(context, "Fail to update note");

                              }
                            }
                          }, 
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}