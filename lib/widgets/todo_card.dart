import 'package:flutter/material.dart';
import 'package:notesphere/models/todo_model.dart';
import 'package:notesphere/utils/colors.dart';
import 'package:notesphere/utils/text_styles.dart';

class TodoCard extends StatefulWidget {
  final Todo todo;
  final bool isCompleted;
  final Function() onCheckeBoxChanged;
  const TodoCard({
    super.key, 
    required this.todo, 
    required this.isCompleted, 
    required this.onCheckeBoxChanged
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15
      ),
      decoration:  BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        title: Text(
          widget.todo.title,
          style: AppTextStyles.appDescriptionLarge,
        ),
        subtitle: Row(
          children: [
            Text(
              "${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5)
              ),
            ),
            const SizedBox(width: 10,),
            Text(
              "${widget.todo.time.hour}:${widget.todo.time.minute}",
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.5)
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted, 
          onChanged: (value) => widget.onCheckeBoxChanged(),
        ),
      ),
    );
  }
}