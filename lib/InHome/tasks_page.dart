import 'package:flutter/material.dart';
import 'package:task_tamer/InHome/TasksWidgets/simple_user_stats.dart';
import 'package:task_tamer/InHome/TasksWidgets/task_tile.dart';

class TasksPage extends StatelessWidget {
  TasksPage({super.key});
  final List<TaskTile> tasks = List.generate(10, (value) => TaskTile());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: tasks.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () {},
              heroTag: "add",
              child: Icon(Icons.add),
            ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          SimpleUserStats(),
          tasks.isEmpty
              ? Column(
                  spacing: 16,
                  children: [
                    Center(child: Text('No tasks yet')),
                    FilledButton(
                      onPressed: () {},
                      child: Text("Create new task"),
                    ),
                  ],
                )
              : Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return tasks[index];
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
