import 'package:flutter/material.dart';
import 'package:notesphere/models/note_model.dart';
import 'package:notesphere/models/todo_model.dart';
import 'package:notesphere/pages/todo_data_widget.dart';
import 'package:notesphere/services/note_service.dart';
import 'package:notesphere/services/todo_service.dart';
import 'package:notesphere/utils/constants.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:notesphere/widgets/homescreen_todo_card.dart';
import 'package:notesphere/widgets/notes_todo_card.dart';
import 'package:notesphere/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Note> allNotes = [];
  List<Todo> allTodos = [];
  @override
  void initState() {
    super.initState();
    _checkUserIsNew();
    setState(() {});
  }
  
  //to check the user is new
  void _checkUserIsNew() async {
    final bool isNewUser = 
      await NoteService().isNewUser() || await TodoService().isNewUser();

      if(isNewUser){
        await NoteService().createdInitialNotes();
        await TodoService().createInitialTodos();
      }
      _loadNotes();
      _loadTodos();
  }
  //load notes
  Future<void> _loadNotes() async {
    final List<Note> loadedNotes = await NoteService().loadNotes();
    setState(() {
      allNotes = loadedNotes;
    });
  } 
  //load todos
  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await TodoService().loadTodos();
    setState(() {
      allTodos = loadedTodos;
    });
  } 
  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodos,
      updateTodos: (todos){
        setState(() {
          allTodos = todos;
        });
      },
      child: Scaffold(
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
              ProgressCard(
                completedTask: allTodos.where((todo)=>todo.isDone).length,
                totalTask: allTodos.length,
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
                    child: NotesTodoCard(
                      title: "Note", 
                      descript: "${allNotes.length.toString()} Notes", 
                      icon: Icons.bookmark_add_outlined
                    ),
                  ),
                   GestureDetector(
                    onTap: () {
                      //goto todo page
                      AppRouter.router.push("/todos");
                    },
                     child: NotesTodoCard(
                      title: "To-Do List", 
                      descript: "${allTodos.length.toString()} Tasks", 
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
              ),
              const SizedBox(height: 20,),
              allTodos.isEmpty ? Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                child: Center(
                  child: Column(
                    children: [
                      Text("No tasks for today. Add some to get started",
                        style: AppTextStyles.appDescriptionLarge.copyWith(
                        color: Colors.grey
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.blue)
                        ),
                        onPressed: (){
                          AppRouter.router.push("/todos");
                        }, 
                        child: const Text("Add Task")
                      )
                    ],
                  ),
                ),
              ) :
              Expanded(
                child: ListView.builder(
                  itemCount: allTodos.length,
                  itemBuilder: (context, index){
                    final Todo todo = allTodos[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: HomescreenTodoCard(
                        title: todo.title, 
                        date: todo.date.toString(),  
                        time: todo.time.toString(), 
                        isDone: todo.isDone, 
                      ),
                    );
                  }
                )
              )
            ],
          ), 
        ),
      ),
    );
  }
}