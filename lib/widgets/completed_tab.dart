import 'package:flutter/material.dart';
import 'package:notesphere/helpers/snackbar.dart';
import 'package:notesphere/models/todo_model.dart';
import 'package:notesphere/services/todo_service.dart';
import 'package:notesphere/utils/router.dart';
import 'package:notesphere/widgets/todo_card.dart';

class CompletedTab extends StatefulWidget {
  final List<Todo> completedTodos;
  final List<Todo> incompletedTodos;
  const CompletedTab({
    super.key, 
    required this.completedTodos,
    required this.incompletedTodos
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {

  //mark a todo as done
  void _markTodoAsNotDone (Todo todo) async {
    try{
      final Todo updatedTodo = Todo(
        title: todo.title, 
        date: todo.date, 
        time: todo.time, 
        isDone: false
      );
      await TodoService().markAsDone(updatedTodo);
      setState(() {
        widget.completedTodos.remove(todo);
        widget.incompletedTodos.add(updatedTodo);
      });
      //sankbar
      AppHelpers.showSnackBar(
        context, "Marked as Not Completed"
      );
      AppRouter.router.go("/todos");
    }catch(err){
      //sankbar
      AppHelpers.showSnackBar(
        context, "Fail to Mark as Not Completed"
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.completedTodos.sort((a,b)=>a.time.compareTo(b.time));
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
              itemCount: widget.completedTodos.length,
              itemBuilder: (context, index){
                final Todo todo = widget.completedTodos[index];
                return TodoCard(
                  todo: todo, 
                  isCompleted: false,
                  onCheckeBoxChanged: () => _markTodoAsNotDone(todo),
                );
              }
            )
          )
        ],
      ),
    );
  }
}