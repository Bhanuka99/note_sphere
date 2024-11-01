import 'package:flutter/cupertino.dart';
import 'package:notesphere/models/todo_model.dart';

class TodoData extends InheritedWidget {

  final List<Todo> todos;
  final Function(List<Todo>) updateTodos;

  const TodoData({
    super.key, 
    required super.child, 
    required this.todos, 
    required this.updateTodos
  });
  static TodoData? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }
  
  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    return todos != oldWidget.todos;
  }
}