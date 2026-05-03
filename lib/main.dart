import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/live_scores_provider.dart';
import 'providers/matches_provider.dart';
import 'providers/rankings_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/poll_provider.dart';
import 'providers/trivia_provider.dart';
import 'providers/predict_provider.dart';
import 'providers/chat_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase - Replace with your project details
  await Supabase.initialize(
    url: 'https://uwixygonzdoyayybfqxo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV3aXh5Z29uemRveWF5eWJmcXhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyODk2MTgsImV4cCI6MjA5MDg2NTYxOH0.-XJEBZ8C57v1e8a3zHxmW8I-qTywmyx2xmHRtgAIOKU',
  );

  final authProvider = AuthProvider();

  final settingsProvider = SettingsProvider();
  await settingsProvider.load();

  final liveScoresProvider = LiveScoresProvider();
  liveScoresProvider.init();

  final matchesProvider = MatchesProvider();
  matchesProvider.init();

  final pollProvider = PollProvider();
  pollProvider.init();

  final predictProvider = PredictProvider();
  predictProvider.setLiveProvider(liveScoresProvider);

  final chatProvider = ChatProvider();
  // Pass your Gemini API key here to enable AI responses:
  // chatProvider.initialize(apiKey: 'YOUR_GEMINI_API_KEY');
  chatProvider.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: settingsProvider),
        ChangeNotifierProvider.value(value: liveScoresProvider),
        ChangeNotifierProvider.value(value: matchesProvider),
        ChangeNotifierProvider(create: (_) => RankingsProvider()),
        ChangeNotifierProvider.value(value: pollProvider),
        ChangeNotifierProvider(create: (_) => TriviaProvider()),
        ChangeNotifierProvider.value(value: predictProvider),
        ChangeNotifierProvider.value(value: chatProvider),
      ],
      child: const CricPulseApp(),
    ),
  );
}
