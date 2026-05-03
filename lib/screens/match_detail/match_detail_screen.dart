import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/match.dart';
import '../../providers/live_scores_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/live_score_chip.dart';

class MatchDetailScreen extends StatelessWidget {
  final String matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Consumer<LiveScoresProvider>(
      builder: (context, prov, _) {
        final match = prov.allMatches.where((m) => m.id == matchId).firstOrNull;
        if (match == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Match')),
            body: const Center(child: Text('Match not found')),
          );
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text('${match.homeTeam.shortCode} vs ${match.awayTeam.shortCode}'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // Status & format
              Row(
                children: [
                  _statusChip(match, cs, tt),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(match.formatLabel, style: tt.labelSmall),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Scoreboard
              GlassCard(
                glowColor: match.status == MatchStatus.live ? cs.primaryContainer : null,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(match.homeTeam.flagEmoji, style: const TextStyle(fontSize: 40)),
                              const SizedBox(height: 8),
                              Text(match.homeTeam.name, style: tt.titleMedium, textAlign: TextAlign.center),
                              const SizedBox(height: 4),
                              if (match.innings1 != null)
                                Text(match.innings1!.scoreString, style: tt.headlineLarge!.copyWith(color: cs.primary)),
                              if (match.innings1 != null)
                                Text(match.innings1!.oversString, style: tt.labelSmall),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('VS', style: tt.labelLarge!.copyWith(color: cs.onSurfaceVariant)),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(match.awayTeam.flagEmoji, style: const TextStyle(fontSize: 40)),
                              const SizedBox(height: 8),
                              Text(match.awayTeam.name, style: tt.titleMedium, textAlign: TextAlign.center),
                              const SizedBox(height: 4),
                              if (match.innings2 != null)
                                Text(match.innings2!.scoreString, style: tt.headlineLarge!.copyWith(color: cs.secondary)),
                              if (match.innings2 != null)
                                Text(match.innings2!.oversString, style: tt.labelSmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (match.result != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: cs.secondary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(match.result!, style: tt.labelLarge!.copyWith(color: cs.secondary)),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Recent balls
              if (match.activeInnings != null && match.activeInnings!.recentBalls.isNotEmpty) ...[
                Text('Recent Deliveries', style: tt.headlineSmall),
                const SizedBox(height: 12),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: match.activeInnings!.recentBalls
                        .map((b) => LiveScoreChip(text: b))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Current batting
              if (match.activeInnings?.striker != null) ...[
                Text('At the Crease', style: tt.headlineSmall),
                const SizedBox(height: 12),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _batsmanRow(match.activeInnings!.striker!, true, cs, tt),
                      if (match.activeInnings!.nonStriker != null) ...[
                        Divider(height: 20, color: cs.outlineVariant.withValues(alpha: 0.3)),
                        _batsmanRow(match.activeInnings!.nonStriker!, false, cs, tt),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Current bowling
              if (match.activeInnings?.currentBowler != null) ...[
                Text('Bowling', style: tt.headlineSmall),
                const SizedBox(height: 12),
                GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: _bowlerRow(match.activeInnings!.currentBowler!, cs, tt),
                ),
                const SizedBox(height: 20),
              ],

              // Innings breakdown
              if (match.innings1 != null) ...[
                Text('Innings Breakdown', style: tt.headlineSmall),
                const SizedBox(height: 12),
                _inningsCard(match, 1, cs, tt),
                if (match.innings2 != null) ...[
                  const SizedBox(height: 12),
                  _inningsCard(match, 2, cs, tt),
                ],
                const SizedBox(height: 20),
              ],

              // Venue
              GlassCard(
                padding: const EdgeInsets.all(16),
                borderRadius: 16,
                child: Row(
                  children: [
                    Icon(Icons.stadium, color: cs.primaryContainer, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Venue', style: tt.labelSmall),
                          Text(match.venue, style: tt.titleSmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Widget _statusChip(Match m, ColorScheme cs, TextTheme tt) {
    Color c;
    switch (m.status) {
      case MatchStatus.live:
        c = cs.error;
        break;
      case MatchStatus.upcoming:
        c = cs.primaryContainer;
        break;
      case MatchStatus.completed:
        c = cs.secondary;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(9999)),
      child: Text(m.statusLabel, style: tt.labelSmall!.copyWith(color: c, fontWeight: FontWeight.w700)),
    );
  }

  Widget _batsmanRow(dynamic b, bool isStriker, ColorScheme cs, TextTheme tt) {
    return Row(
      children: [
        if (isStriker) Icon(Icons.sports_cricket, size: 16, color: cs.primary),
        if (isStriker) const SizedBox(width: 8),
        Expanded(child: Text(b.name, style: tt.titleSmall!.copyWith(fontWeight: isStriker ? FontWeight.w700 : FontWeight.w400))),
        Text('${b.runs}', style: tt.headlineSmall!.copyWith(color: cs.primary)),
        Text(' (${b.balls})', style: tt.labelMedium!.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(width: 12),
        Text('4s: ${b.fours}', style: tt.labelSmall!.copyWith(color: cs.secondary)),
        const SizedBox(width: 8),
        Text('6s: ${b.sixes}', style: tt.labelSmall!.copyWith(color: cs.tertiary)),
      ],
    );
  }

  Widget _bowlerRow(dynamic b, ColorScheme cs, TextTheme tt) {
    return Row(
      children: [
        Expanded(child: Text(b.name, style: tt.titleSmall)),
        Text('${b.wickets}/${b.runsConceded}', style: tt.headlineSmall!.copyWith(color: cs.tertiary)),
        const SizedBox(width: 12),
        Text('${b.overs} ov', style: tt.labelMedium!.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }

  Widget _inningsCard(Match m, int innNum, ColorScheme cs, TextTheme tt) {
    final inn = innNum == 1 ? m.innings1! : m.innings2!;
    final team = inn.battingTeamId == m.homeTeam.id ? m.homeTeam : m.awayTeam;
    return GlassCard(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(team.flagEmoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${team.name} – Innings $innNum', style: tt.titleSmall),
                Text(inn.isCompleted ? 'Completed' : 'In progress', style: tt.labelSmall!.copyWith(color: inn.isCompleted ? cs.secondary : cs.tertiary)),
              ],
            ),
          ),
          Text(inn.scoreString, style: tt.headlineMedium!.copyWith(color: cs.primary)),
          const SizedBox(width: 8),
          Text(inn.oversString, style: tt.labelSmall),
        ],
      ),
    );
  }
}
