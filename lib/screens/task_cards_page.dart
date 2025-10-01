import 'package:flutter/material.dart';
import 'task_submission_page.dart';

class TaskCardsPage extends StatefulWidget {
  const TaskCardsPage({super.key});

  @override
  State<TaskCardsPage> createState() => _TaskCardsPageState();
}

class _TaskCardsPageState extends State<TaskCardsPage> {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Letter to a Character',
      'subtitle': 'After reading a book',
      'icon': Icons.mail_outline,
      'color': Colors.purple[100],
    },
    {
      'title': 'Paint an Old T-Shirt',
      'subtitle': 'Get creative with old clothes',
      'icon': Icons.brush,
      'color': Colors.orange[100],
    },
    {
      'title': 'Bottle Art',
      'subtitle': 'Decorate a bottle',
      'icon': Icons.local_drink,
      'color': Colors.blue[100],
    },
    {
      'title': 'Mud Sculpting',
      'subtitle': 'Shape your imagination',
      'icon': Icons.emoji_nature,
      'color': Colors.green[100],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/kuttie_logo.png',
              height: 36,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.child_care, color: Colors.white, size: 36),
            ),
            const SizedBox(width: 12),
            const Text('Kuttie', style: TextStyle(fontFamily: 'ComicSans', fontWeight: FontWeight.bold, fontSize: 26)),
          ],
        ),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      backgroundColor: Colors.purple[50],
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: tasks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, scale, child) {
              return GestureDetector(
                onTapDown: (_) => setState(() {}),
                onTapUp: (_) => setState(() {}),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskSubmissionPage(
                        taskTitle: task['title'],
                        taskSubtitle: task['subtitle'],
                        icon: task['icon'],
                        color: task['color'],
                      ),
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.elasticOut,
                  decoration: BoxDecoration(
                    color: task['color'],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.purple, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.purple, width: 2),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(task['icon'], color: Colors.purple, size: 40),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        task['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontFamily: 'ComicSans',
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        task['subtitle'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.deepPurple,
                          fontFamily: 'ComicSans',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
