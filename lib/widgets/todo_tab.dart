import 'package:flutter/material.dart';
import 'package:notesphere/helpers/snackbar.dart';
import 'package:notesphere/models/todo_model.dart';
import 'package:notesphere/services/todo_service.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/widgets/todo_card.dart';

class TodoTab extends StatefulWidget {
  final List<Todo> incompletedTodos;
  final List<Todo> completedTodos;
  const TodoTab({
    super.key, 
    required this.incompletedTodos, 
    required this.completedTodos
  });

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {

  //mark a todo as done
  void _markTodoAsDone (Todo todo) async {
    try{
      final Todo updatedTodo = Todo(
        title: todo.title, 
        date: todo.date, 
        time: todo.time, 
        isDone: true
      );
      await TodoService().markAsDone(updatedTodo);

      //sankbar
      AppHelpers.showSnackBar(
        context, "Marked as Completed"
      );
      setState(() {
        widget.incompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTodo);
      });
      //navigate
      AppRouter.router.go("/todos"); 
    }catch(err){
      //sankbar
      AppHelpers.showSnackBar(
        context, "Fail to Mark as Completed"
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.incompletedTodos.sort((a,b)=>a.time.compareTo(b.time));
    });
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.incompletedTodos.length,
              itemBuilder: (context, index){
                final Todo todo = widget.incompletedTodos[index];
                return TodoCard(
                  todo: todo, 
                  isCompleted: false,
                  onCheckeBoxChanged: () => _markTodoAsDone(todo),
                );
              }
            )
          )
        ],
      ),
    );
  }
}