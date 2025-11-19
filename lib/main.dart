import 'package:flutter/material.dart';

List<String> mockTasks = [
  "Estudar para a prova",
  "Fazer a feira",
];

enum MenuOptions { clearAll, about }

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF7F7FF),
        fontFamily: 'Roboto',
      ),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<String> _taskList = mockTasks;
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    final taskName = _taskController.text.trim();
    if (taskName.isNotEmpty) {
      setState(() {
        _taskList.insert(0, taskName); 
        _taskController.clear();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
  }

  void _clearAllTasks() {
    setState(() {
      _taskList.clear();
    });
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Lista de Tarefas',
      applicationVersion: '1.0.0',
      applicationLegalese: 'Desenvolvido para fins educacionais.',
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text('Este é um aplicativo To-Do simples em Flutter.'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          PopupMenuButton<MenuOptions>(
            icon: const Icon(Icons.more_vert, color: Colors.white), 
            onSelected: (MenuOptions result) {
              switch (result) {
                case MenuOptions.clearAll:
                  _clearAllTasks();
                  break;
                case MenuOptions.about:
                  _showAboutDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.clearAll,
                child: Row(
                  children: [
                    Icon(Icons.close),
                    SizedBox(width: 8),
                    Text('Limpar Todas'),
                  ],
                ),
              ),
              const PopupMenuItem<MenuOptions>(
                value: MenuOptions.about,
                child: Row(
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 8),
                    Text('Sobre'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildNewTaskSection(context),
          
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Suas Tarefas:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              itemCount: _taskList.length,
              itemBuilder: (context, index) {
                return _TaskItem(
                  taskName: _taskList[index],
                  onDelete: () => _removeTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildNewTaskSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Nova Tarefa',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Digite sua tarefa...',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple.shade200, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
                  ),
                ),
                onSubmitted: (_) => _addTask(),
              ),
              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: _addTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple.shade300, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 1,
                ),
                child: const Text(
                  'Adicionar Tarefa',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;

  const _TaskItem({required this.taskName, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.task_alt, 
                color: Colors.blue,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded( 
                child: Text(
                  taskName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis, 
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 24,
                ),
                onPressed: onDelete, 
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}