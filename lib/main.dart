import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/live_scores_provider.dart';
import 'providers/matches_provider.dart';
import 'providers/rankings_provider.dart';
import 'providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.load();

  final liveScoresProvider = LiveScoresProvider();
  liveScoresProvider.init();

  final matchesProvider = MatchesProvider();
  matchesProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProvider.value(value: liveScoresProvider),
        ChangeNotifierProvider.value(value: matchesProvider),
        ChangeNotifierProvider(create: (_) => RankingsProvider()),
      ],
      child: const CricPulseApp(),
    ),
  );
}
