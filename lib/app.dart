import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/shell_screen.dart';
import 'screens/match_detail/match_detail_screen.dart';
import 'screens/predict/predict_screen.dart';
import 'screens/trivia/trivia_screen.dart';
import 'screens/polls/polls_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/leaderboard/leaderboard_screen.dart';
import 'screens/auth/auth_screen.dart';
import 'providers/auth_provider.dart';

class CricPulseApp extends StatelessWidget {
  const CricPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    final router = GoRouter(
      refreshListenable: authProvider,
      initialLocation: authProvider.isAuthenticated ? '/' : '/auth',
      redirect: (context, state) {
        final isAuthenticated = authProvider.isAuthenticated;
        final isAuthRoute = state.matchedLocation == '/auth';

        if (authProvider.isLoading) return null;

        if (!isAuthenticated && !isAuthRoute) {
          return '/auth';
        }
        if (isAuthenticated && isAuthRoute) {
          return '/';
        }
        return null;
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const ShellScreen(),
        ),
        GoRoute(
          path: '/match/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return MatchDetailScreen(matchId: id);
          },
        ),
        GoRoute(
          path: '/predict',
          builder: (context, state) => const Scaffold(body: PredictScreen()),
        ),
        GoRoute(
          path: '/trivia',
          builder: (context, state) => const Scaffold(body: TriviaScreen()),
        ),
        GoRoute(
          path: '/polls',
          builder: (context, state) => const Scaffold(body: PollsScreen()),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const Scaffold(body: ChatScreen()),
        ),
        GoRoute(
          path: '/leaderboard',
          builder: (context, state) => const Scaffold(body: LeaderboardScreen()),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'CricPulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routerConfig: router,
    );
  }
}
