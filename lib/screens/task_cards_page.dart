import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'task_submission_page.dart';

class TaskCardsPage extends StatefulWidget {
  const TaskCardsPage({super.key});

  @override
  State<TaskCardsPage> createState() => _TaskCardsPageState();
}

class _TaskCardsPageState extends State<TaskCardsPage> {

  List<dynamic> tasks = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8002/api/tasks/'));
      if (response.statusCode == 200) {
        setState(() {
          tasks = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load tasks: \\${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: \\${e.toString()}';
        isLoading = false;
      });
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : GridView.builder(
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskSubmissionPage(
                                  taskTitle: task['title'] ?? task['name'] ?? '',
                                  taskSubtitle: task['subtitle'] ?? '',
                                  icon: Icons.star,
                                  color: Colors.purple[100],
                                ),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.elasticOut,
                            decoration: BoxDecoration(
                              color: Colors.purple[100],
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
                                  child: Icon(Icons.star, color: Colors.purple, size: 40),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  task['title'] ?? task['name'] ?? '',
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
                                  task['subtitle'] ?? '',
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
