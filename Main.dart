import 'package:flutter/material.dart';
import 'storage_service.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // Deep dark theme
        colorSchemeSeed: Colors.teal,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StorageService _storage = StorageService();
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _taskList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final data = await _storage.getTasks();
    setState(() => _taskList = data);
  }

  // Create
  void _addTask() async {
    if (_controller.text.isNotEmpty) {
      _taskList.add({'title': _controller.text, 'isDone': false});
      await _storage.saveTasks(_taskList);
      _controller.clear();
      _loadData();
    }
  }

  // Update
  void _toggleTask(int index) async {
    setState(() {
      _taskList[index]['isDone'] = !_taskList[index]['isDone'];
    });
    await _storage.saveTasks(_taskList);
  }

  // Delete
  void _deleteTask(int index) async {
    setState(() {
      _taskList.removeAt(index);
    });
    await _storage.saveTasks(_taskList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SharedPrefs Tasker'), centerTitle: true),
      body: _taskList.isEmpty 
          ? const Center(child: Text("No tasks yet!"))
          : ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                final task = _taskList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Checkbox(
                      value: task['isDone'],
                      onChanged: (_) => _toggleTask(index),
                    ),
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: task['isDone'] ? TextDecoration.lineThrough : null,
                        color: task['isDone'] ? Colors.grey : Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => _deleteTask(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayInput(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _displayInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(controller: _controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () { _addTask(); Navigator.pop(context); }, 
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
