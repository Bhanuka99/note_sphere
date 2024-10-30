import 'package:flutter/material.dart';
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
        onPressed: (){},
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