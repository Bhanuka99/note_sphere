import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesphere/helpers/snackbar.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/services/note_service.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

class CreateNewNote extends StatefulWidget {
  
  final  bool isNewCategory;
  const CreateNewNote({super.key, required this.isNewCategory});

  @override
  State<CreateNewNote> createState() => _CreateNewNoteState();
}

class _CreateNewNoteState extends State<CreateNewNote> {

  List<String> categories = [];
  final NoteService noteService = NoteService();

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  String category = "";

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();
    _noteCategoryController.dispose();
    super.dispose();
  }
  

  Future _loadCategories () async {
    categories = await noteService.getAllCategories();
    setState(() {});
  }
  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a Note",
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
                    widget.isNewCategory ? 
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _noteCategoryController,
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please Enter a Category";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          color: AppColors.kWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                        decoration: InputDecoration(
                          hintText: "New Category",
                          hintStyle: TextStyle(
                            color: AppColors.kWhiteColor.withOpacity(0.5),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: GoogleFonts.dmSans().fontFamily,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                              width: 2,
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                              color: AppColors.kWhiteColor,
                              width: 2
                            )
                          )
                        ),
                      ),
                    ):
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
                        hint: const Text("Category"),
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

                            //save the notes
                            if(_formkey.currentState!.validate()){
                              try{
                                noteService.addNote(
                                  Note(
                                    title: _noteTitleController.text, 
                                    category: widget.isNewCategory ? _noteCategoryController.text : category, 
                                    content: _noteContentController.text, 
                                    date: DateTime.now(),
                                    id:const Uuid().v4()
                                  )
                                );
                                //snakbar
                                AppHelpers.showSnackBar(context, "Note saved successfully!!!");

                                _noteTitleController.clear();
                                _noteContentController.clear();
                                AppRouter.router.push("/notes");
                              }catch(err){
                                AppHelpers.showSnackBar(context, "Fail to save Note!!!");

                              }
                            }

                          }, 
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
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