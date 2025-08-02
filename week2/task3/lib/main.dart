import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<String> tasks = [];
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = prefs.getString('tasks');
    if (taskString != null) {
      setState(() {
        tasks = List<String>.from(json.decode(taskString));
      });
    }
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tasks', json.encode(tasks));
  }

  void addTask(String task) {
    if (task.trim().isNotEmpty) {
      setState(() {
        tasks.add(task.trim());
        taskController.clear();
      });
      saveTasks();
    }
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: const InputDecoration(
                      hintText: 'Enter task...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addTask(taskController.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                tasks.isEmpty
                    ? const Center(child: Text('No tasks yet'))
                    : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder:
                          (context, index) => ListTile(
                            title: Text(tasks[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeTask(index),
                            ),
                          ),
                    ),
          ),
        ],
      ),
    );
  }
}
