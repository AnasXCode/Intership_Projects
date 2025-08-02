import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}

class Task {
  String title;
  bool isDone;

  Task(this.title, this.isDone);

  Map<String, dynamic> toJson() => {'title': title, 'isDone': isDone};

  static Task fromJson(Map<String, dynamic> json) =>
      Task(json['title'], json['isDone']);
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = prefs.getString('task_list');
    if (taskList != null) {
      final decoded = json.decode(taskList) as List;
      setState(() {
        tasks = decoded.map((item) => Task.fromJson(item)).toList();
      });
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = json.encode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString('task_list', encoded);
  }

  void addTask(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      tasks.add(Task(title, false));
      taskController.clear();
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
    saveTasks();
  }

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Add Task'),
            content: TextField(
              controller: taskController,
              decoration: const InputDecoration(hintText: 'Enter task'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  taskController.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  addTask(taskController.text);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task Manager',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: showAddTaskDialog),
        ],
      ),
      body:
          tasks.isEmpty
              ? const Center(child: Text('No tasks yet.'))
              : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isDone,
                      onChanged: (_) => toggleTask(index),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteTask(index),
                    ),
                  );
                },
              ),
    );
  }
}
