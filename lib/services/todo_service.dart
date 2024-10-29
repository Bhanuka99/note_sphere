import 'package:hive/hive.dart';
import 'package:notesphere/models/todo_model.dart';

class TodoService {


  //dummy todos
  List<Todo> todos = [
    Todo(
      title: "Read a Book", 
      date: DateTime.now(), 
      time: DateTime.now(), 
      isDone: false
    ),
    Todo(
      title: "Go for a Walk", 
      date: DateTime.now(), 
      time: DateTime.now(), 
      isDone: false
    ),
    Todo(
      title: "Complete Assignment", 
      date: DateTime.now(), 
      time: DateTime.now(), 
      isDone: false
    ),
  ];

  //create a database reference for Todos
  final _myBox = Hive.box("todos");

  //check whether the user is new
  Future <bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  //Methods to create initial todos for new users
  Future<void> createInitialTodos() async{
    if(_myBox.isEmpty){
      await _myBox.put("todos", todos);
    }
  } 

  //Method to load todos
  Future <List<Todo>> loadTodos() async{
    final dynamic todos = await _myBox.get("todos");
    if(todos!= null && todos is List<dynamic>){
      return todos.cast<Todo>().toList();
    }
    return [];
  }
}