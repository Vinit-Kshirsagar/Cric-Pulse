import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'live_scores/live_scores_screen.dart';
import 'matches/matches_screen.dart';
import 'rankings/rankings_screen.dart';
import 'settings/settings_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    LiveScoresScreen(),
    MatchesScreen(),
    RankingsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerLow,
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.06))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.scoreboard_outlined), activeIcon: Icon(Icons.scoreboard), label: 'Live'),
            BottomNavigationBarItem(icon: Icon(Icons.sports_cricket_outlined), activeIcon: Icon(Icons.sports_cricket), label: 'Matches'),
            BottomNavigationBarItem(icon: Icon(Icons.leaderboard_outlined), activeIcon: Icon(Icons.leaderboard), label: 'Rankings'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
