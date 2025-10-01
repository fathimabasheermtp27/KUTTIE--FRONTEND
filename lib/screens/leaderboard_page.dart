import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {

  List<dynamic> leaderboard = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    try {
      final response = await http.get(Uri.parse('http://127.0.0.1:8002/api/leaderboard/'));
      if (response.statusCode == 200) {
        setState(() {
          leaderboard = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Failed to load leaderboard: \\${response.statusCode}';
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
        title: const Text('Leaderboard'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      backgroundColor: Colors.orange[50],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: leaderboard.length,
                  itemBuilder: (context, index) {
                    final entry = leaderboard[index];
                    return Card(
                      color: index == 0 ? Colors.amber[100] : Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 28,
                          child: Text(
                            (entry['name'] ?? entry['username'] ?? 'U')[0],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                          ),
                        ),
                        title: Text(
                          entry['name'] ?? entry['username'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(
                          'Points: ${entry['points'] ?? entry['score'] ?? 0}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: index == 0
                            ? Icon(Icons.emoji_events, color: Colors.amber[800], size: 32)
                            : Text('#${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800], fontSize: 18)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    );
                  },
                ),
    );
  }
}
