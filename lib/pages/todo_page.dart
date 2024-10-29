import 'package:flutter/material.dart';
import 'package:notesphere/utils/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        children: const [
          TodoTab(),
          CompletedTab(),
        ]
      ),
    );
  }
}