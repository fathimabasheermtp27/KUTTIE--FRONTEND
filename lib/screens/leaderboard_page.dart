import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final List<Map<String, dynamic>> leaderboard = [
    {
      'name': 'Ayaan',
      'points': 120,
      'avatar': 'https://randomuser.me/api/portraits/lego/1.jpg',
    },
    {
      'name': 'Maya',
      'points': 110,
      'avatar': 'https://randomuser.me/api/portraits/lego/2.jpg',
    },
    {
      'name': 'Zara',
      'points': 100,
      'avatar': 'https://randomuser.me/api/portraits/lego/3.jpg',
    },
    {
      'name': 'Kabir',
      'points': 90,
      'avatar': 'https://randomuser.me/api/portraits/lego/4.jpg',
    },
    {
      'name': 'Riya',
      'points': 80,
      'avatar': 'https://randomuser.me/api/portraits/lego/5.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      backgroundColor: Colors.orange[50],
      body: ListView.builder(
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
                backgroundImage: NetworkImage(entry['avatar']),
                radius: 28,
                backgroundColor: Colors.white,
                child: Text(
                  entry['name'][0],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                ),
              ),
              title: Text(
                entry['name'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                'Points: ${entry['points']}',
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
