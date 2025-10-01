import 'package:flutter/material.dart';
import 'screens/task_cards_page.dart';
import 'screens/leaderboard_page.dart';
import 'screens/task_submission_page.dart';
import 'widgets/magical_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(KuttieApp());
}

class KuttieApp extends StatelessWidget {
  const KuttieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuttie',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'ComicSans',
        scaffoldBackgroundColor: Colors.purple[50],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.deepPurple),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          elevation: 0,
        ),
      ),
      home: const MagicalHomePage(),
      routes: {
        '/tasks': (_) => TaskCardsPage(),
        '/leaderboard': (_) => LeaderboardPage(),
        '/submit': (_) => TaskSubmissionPage(),
      },
    );
  }
}

class MagicalHomePage extends StatelessWidget {
  const MagicalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient sky background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8EC5FC), // sky blue
                    Color(0xFFE0C3FC), // lavender
                    Color(0xFFFFE2EC), // pink
                  ],
                ),
              ),
            ),
          ),
          // Playful cartoon SVG
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SvgPicture.asset(
                'assets/images/cartoon_hero.svg',
                height: 220,
                semanticsLabel: 'Cartoon Hero',
              ),
            ),
          ),
          // Animated clouds (placeholder with Opacity)
          Positioned(
            top: 60,
            left: 30,
            child: Opacity(
              opacity: 0.7,
              child: Icon(Icons.cloud, size: 80, color: Colors.white),
            ),
          ),
          Positioned(
            top: 120,
            right: 40,
            child: Opacity(
              opacity: 0.6,
              child: Icon(Icons.cloud, size: 60, color: Colors.white),
            ),
          ),
          // Castle (placeholder with emoji)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text('🏰', style: TextStyle(fontSize: 80, shadows: [Shadow(color: Colors.purple, blurRadius: 12)])),
            ),
          ),
          // Balloons (placeholder with emoji)
          Positioned(
            left: 60,
            bottom: 180,
            child: Text('🎈', style: TextStyle(fontSize: 40)),
          ),
          Positioned(
            right: 60,
            bottom: 200,
            child: Text('🎈', style: TextStyle(fontSize: 32)),
          ),
          // Cute animal (placeholder with emoji)
          Positioned(
            left: 30,
            bottom: 80,
            child: Text('🐰', style: TextStyle(fontSize: 36)),
          ),
          Positioned(
            right: 30,
            bottom: 90,
            child: Text('🐦', style: TextStyle(fontSize: 32)),
          ),
          // Stars and sparkles (placeholder with emoji)
          Positioned(
            top: 40,
            left: 120,
            child: Text('✨', style: TextStyle(fontSize: 28)),
          ),
          Positioned(
            top: 100,
            right: 120,
            child: Text('⭐', style: TextStyle(fontSize: 24)),
          ),
          // App title with crown
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('K', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.purple, fontFamily: 'ComicSans', shadows: [Shadow(color: Colors.white, blurRadius: 8)])),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32, left: 2),
                      child: Text('👑', style: TextStyle(fontSize: 28)),
                    ),
                    const Text('uttie', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.purple, fontFamily: 'ComicSans', shadows: [Shadow(color: Colors.white, blurRadius: 8)])),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('A Magical World for Kids!', style: TextStyle(fontSize: 20, color: Colors.deepPurple, fontFamily: 'ComicSans')),
              ],
            ),
          ),
          // Main buttons
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MagicalButton(
                  label: 'View Tasks',
                  icon: Icons.star,
                  gradientColors: [Color(0xFFFFA6C1), Color(0xFFB993D6)],
                  onTap: () => Navigator.pushNamed(context, '/tasks'),
                ),
                const SizedBox(height: 32),
                MagicalButton(
                  label: 'Leaderboard',
                  icon: Icons.emoji_events,
                  gradientColors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
                  onTap: () => Navigator.pushNamed(context, '/leaderboard'),
                ),
                const SizedBox(height: 32),
                MagicalButton(
                  label: 'Submit Task',
                  icon: Icons.send,
                  gradientColors: [Color(0xFFB6F492), Color(0xFFFFE2EC)],
                  onTap: () => Navigator.pushNamed(context, '/submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
