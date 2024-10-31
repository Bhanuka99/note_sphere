import 'package:flutter/material.dart';
import 'package:notesphere/helpers/snackbar.dart';
import 'package:notesphere/models/todo_model.dart';
import 'package:notesphere/services/todo_service.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/utils/text_styles.dart';
import 'package:notesphere/widgets/completed_tab.dart';
import 'package:notesphere/widgets/todo_tab.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Todo> allTodos = [];
  late List<Todo> incompletedTodos = [];
  late List<Todo> completedTodos = [];
  TodoService todoService = TodoService();
  TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _taskController.dispose();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _isUserNew();
  }
  //check the user is new
  void _isUserNew () async {
    final bool isNewUser = await todoService.isNewUser();
    if(isNewUser){
      await todoService.createInitialTodos();
    }
    _loadTodos();
  }
  //load todos
  Future<void> _loadTodos() async {
    final List<Todo> loadedTodos = await todoService.loadTodos();
    setState(() {
      allTodos = loadedTodos;
      //incompleted todos
      incompletedTodos = allTodos.where((todo) => !todo.isDone).toList();
      //incompleted todos
      completedTodos = allTodos.where((todo) => todo.isDone).toList();
    });
  }
  //add new task
  void _addTask () async {
    try{
      if(_taskController.text.isNotEmpty){
      final Todo newTodo = Todo(
        title: _taskController.text, 
        date: DateTime.now(), 
        time: DateTime.now(),  
        isDone: false,
      );
      await todoService.addTodo(newTodo);
      setState(() {
        allTodos.add(newTodo);
        incompletedTodos.add(newTodo);
      });

      AppHelpers.showSnackBar(context, "Task added successfully");

      Navigator.pop(context);
      
    }
    }catch(err){
      AppHelpers.showSnackBar(context, "Fail to add task");
    }
  }
  void opeMessageModel (BuildContext context){
    showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Add Task",
              style: AppTextStyles.appDescriptionLarge.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _taskController,
              style: const TextStyle(
                color: AppColors.kWhiteColor,
                fontSize: 20
              ),
              decoration: InputDecoration(
                hintText: "Enter your task",
                hintStyle: AppTextStyles.appDescriptionSmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: (){
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: const WidgetStatePropertyAll(AppColors.kFabColor),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))
              )
              ), 
              child: const Text(
                "Add Task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              }, 
              child: const Text(
                "Cancel",
                style: AppTextStyles.appButton,
              ),
            )
          ],
        );
      }
    );
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
        bottom: TabBar(
          dividerHeight: 0,
          controller: _tabController,
          tabs: const [
            Tab(
              child: Text(
                "ToDo",
                style: AppTextStyles.appDescriptionLarge,
                ),
            ),
            Tab(
              child: Text(
                "Completed",
                style: AppTextStyles.appDescriptionLarge,
                ),
            ),
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          opeMessageModel(context);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100)
          ),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2
          )
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:[
          TodoTab(
            incompletedTodos: incompletedTodos,
            completedTodos: completedTodos,
          ),
          CompletedTab(
            completedTodos: completedTodos,
            incompletedTodos: incompletedTodos,
          ),
        ]
      ),
    );
  }
}