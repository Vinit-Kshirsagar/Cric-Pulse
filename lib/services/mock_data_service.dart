import 'dart:async';
import 'dart:math';
import '../models/match.dart';
import '../models/player.dart';
import '../models/score.dart';

class MockDataService {
  static final _rand = Random();

  static final List<Team> teams = [
    const Team(id: 'MI', name: 'Mumbai Indians', shortCode: 'MI', flagEmoji: '🔵', iccRanking: 1, matchesPlayed: 12, wins: 9),
    const Team(id: 'CSK', name: 'Chennai Super Kings', shortCode: 'CSK', flagEmoji: '🟡', iccRanking: 2, matchesPlayed: 12, wins: 8),
    const Team(id: 'RCB', name: 'Royal Challengers Bengaluru', shortCode: 'RCB', flagEmoji: '🔴', iccRanking: 3, matchesPlayed: 12, wins: 7),
    const Team(id: 'KKR', name: 'Kolkata Knight Riders', shortCode: 'KKR', flagEmoji: '🟣', iccRanking: 4, matchesPlayed: 12, wins: 7),
    const Team(id: 'DC', name: 'Delhi Capitals', shortCode: 'DC', flagEmoji: '🔷', iccRanking: 5, matchesPlayed: 12, wins: 6),
    const Team(id: 'RR', name: 'Rajasthan Royals', shortCode: 'RR', flagEmoji: '🩷', iccRanking: 6, matchesPlayed: 12, wins: 6),
    const Team(id: 'SRH', name: 'Sunrisers Hyderabad', shortCode: 'SRH', flagEmoji: '🟠', iccRanking: 7, matchesPlayed: 12, wins: 5),
    const Team(id: 'GT', name: 'Gujarat Titans', shortCode: 'GT', flagEmoji: '🩵', iccRanking: 8, matchesPlayed: 12, wins: 5),
    const Team(id: 'PBKS', name: 'Punjab Kings', shortCode: 'PBKS', flagEmoji: '❤️', iccRanking: 9, matchesPlayed: 12, wins: 4),
    const Team(id: 'LSG', name: 'Lucknow Super Giants', shortCode: 'LSG', flagEmoji: '💙', iccRanking: 10, matchesPlayed: 12, wins: 4),
  ];

  static Team _t(String id) => teams.firstWhere((t) => t.id == id);

  static final List<Player> players = [
    Player(id: 'p1', name: 'Rohit Sharma', teamId: 'MI', role: PlayerRole.batsman, battingRank: 1, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 520, highScore: 92, average: 43.3, strikeRate: 152.9, fifties: 5, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p2', name: 'Jasprit Bumrah', teamId: 'MI', role: PlayerRole.bowler, battingRank: 0, bowlingRank: 1, battingStats: const BattingStats(matches: 12, innings: 3, runs: 12, highScore: 8, average: 4.0, strikeRate: 80.0, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 22, economy: 6.2, average: 14.8, bestFigures: '4/18')),
    Player(id: 'p3', name: 'Suryakumar Yadav', teamId: 'MI', role: PlayerRole.batsman, battingRank: 2, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 485, highScore: 103, average: 40.4, strikeRate: 168.4, fifties: 3, hundreds: 1), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p4', name: 'MS Dhoni', teamId: 'CSK', role: PlayerRole.wicketKeeper, battingRank: 8, bowlingRank: 0, battingStats: const BattingStats(matches: 10, innings: 8, runs: 180, highScore: 45, average: 36.0, strikeRate: 158.0, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 10, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p5', name: 'Ruturaj Gaikwad', teamId: 'CSK', role: PlayerRole.batsman, battingRank: 3, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 468, highScore: 108, average: 42.5, strikeRate: 141.8, fifties: 3, hundreds: 1), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p6', name: 'Virat Kohli', teamId: 'RCB', role: PlayerRole.batsman, battingRank: 4, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 498, highScore: 113, average: 45.3, strikeRate: 145.6, fifties: 3, hundreds: 1), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p7', name: 'Rajat Patidar', teamId: 'RCB', role: PlayerRole.batsman, battingRank: 7, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 380, highScore: 88, average: 34.5, strikeRate: 155.1, fifties: 3, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p8', name: 'Sunil Narine', teamId: 'KKR', role: PlayerRole.allRounder, battingRank: 5, bowlingRank: 3, battingStats: const BattingStats(matches: 12, innings: 12, runs: 432, highScore: 85, average: 36.0, strikeRate: 182.3, fifties: 4, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 14, economy: 6.8, average: 22.1, bestFigures: '3/18')),
    Player(id: 'p9', name: 'Andre Russell', teamId: 'KKR', role: PlayerRole.allRounder, battingRank: 9, bowlingRank: 5, battingStats: const BattingStats(matches: 12, innings: 11, runs: 340, highScore: 72, average: 34.0, strikeRate: 195.4, fifties: 2, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 12, economy: 8.9, average: 26.0, bestFigures: '3/25')),
    Player(id: 'p10', name: 'Rishabh Pant', teamId: 'DC', role: PlayerRole.wicketKeeper, battingRank: 6, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 410, highScore: 95, average: 37.3, strikeRate: 162.7, fifties: 3, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p11', name: 'Kuldeep Yadav', teamId: 'DC', role: PlayerRole.bowler, battingRank: 0, bowlingRank: 4, battingStats: const BattingStats(matches: 12, innings: 4, runs: 18, highScore: 10, average: 4.5, strikeRate: 72.0, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 16, economy: 7.4, average: 20.5, bestFigures: '4/20')),
    Player(id: 'p12', name: 'Sanju Samson', teamId: 'RR', role: PlayerRole.wicketKeeper, battingRank: 10, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 365, highScore: 82, average: 33.2, strikeRate: 148.0, fifties: 3, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p13', name: 'Yuzvendra Chahal', teamId: 'RR', role: PlayerRole.bowler, battingRank: 0, bowlingRank: 2, battingStats: const BattingStats(matches: 12, innings: 2, runs: 5, highScore: 3, average: 2.5, strikeRate: 55.6, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 19, economy: 7.1, average: 16.8, bestFigures: '5/16')),
    Player(id: 'p14', name: 'Heinrich Klaasen', teamId: 'SRH', role: PlayerRole.wicketKeeper, battingRank: 11, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 452, highScore: 104, average: 41.1, strikeRate: 175.2, fifties: 2, hundreds: 1), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p15', name: 'Pat Cummins', teamId: 'SRH', role: PlayerRole.bowler, battingRank: 0, bowlingRank: 6, battingStats: const BattingStats(matches: 12, innings: 6, runs: 85, highScore: 32, average: 17.0, strikeRate: 145.0, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 15, economy: 8.2, average: 24.0, bestFigures: '3/22')),
    Player(id: 'p16', name: 'Shubman Gill', teamId: 'GT', role: PlayerRole.batsman, battingRank: 12, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 398, highScore: 89, average: 36.2, strikeRate: 138.9, fifties: 4, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p17', name: 'Rashid Khan', teamId: 'GT', role: PlayerRole.bowler, battingRank: 0, bowlingRank: 7, battingStats: const BattingStats(matches: 12, innings: 5, runs: 65, highScore: 28, average: 16.3, strikeRate: 185.7, fifties: 0, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 18, economy: 6.5, average: 17.2, bestFigures: '4/15')),
    Player(id: 'p18', name: 'Shikhar Dhawan', teamId: 'PBKS', role: PlayerRole.batsman, battingRank: 13, bowlingRank: 0, battingStats: const BattingStats(matches: 11, innings: 11, runs: 310, highScore: 78, average: 28.2, strikeRate: 130.3, fifties: 2, hundreds: 0), bowlingStats: const BowlingStats(matches: 11, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p19', name: 'KL Rahul', teamId: 'LSG', role: PlayerRole.wicketKeeper, battingRank: 14, bowlingRank: 0, battingStats: const BattingStats(matches: 12, innings: 12, runs: 375, highScore: 91, average: 34.1, strikeRate: 136.4, fifties: 3, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 0, economy: 0, average: 0, bestFigures: '-')),
    Player(id: 'p20', name: 'Ravindra Jadeja', teamId: 'CSK', role: PlayerRole.allRounder, battingRank: 15, bowlingRank: 8, battingStats: const BattingStats(matches: 12, innings: 10, runs: 240, highScore: 55, average: 30.0, strikeRate: 148.1, fifties: 1, hundreds: 0), bowlingStats: const BowlingStats(matches: 12, wickets: 13, economy: 7.2, average: 23.8, bestFigures: '3/19')),
  ];

  static final now = DateTime.now();

  static List<Match> getMatches() {
    return [
      // Live matches
      Match(id: 'm1', homeTeam: _t('MI'), awayTeam: _t('CSK'), venue: 'Wankhede Stadium, Mumbai', dateTime: now, status: MatchStatus.live, format: MatchFormat.t20,
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'CSK', runs: 185, wickets: 4, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: ['1', '4', '0', 'W', '6', '2']),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'MI', runs: 142, wickets: 3, overs: 16.2, isCompleted: false,
          batsmen: [const BatsmanScore(name: 'Suryakumar Yadav', runs: 68, balls: 42, fours: 6, sixes: 3, isStriker: true), const BatsmanScore(name: 'Hardik Pandya', runs: 31, balls: 18, fours: 2, sixes: 2, isStriker: false)],
          bowlers: [const BowlerScore(name: 'Ravindra Jadeja', overs: 4, maidens: 0, runsConceded: 28, wickets: 1)],
          recentBalls: ['1', '4', '0', '6', '2', '1'],
          striker: const BatsmanScore(name: 'Suryakumar Yadav', runs: 68, balls: 42, fours: 6, sixes: 3, isStriker: true),
          nonStriker: const BatsmanScore(name: 'Hardik Pandya', runs: 31, balls: 18, fours: 2, sixes: 2, isStriker: false),
          currentBowler: const BowlerScore(name: 'Ravindra Jadeja', overs: 3.2, maidens: 0, runsConceded: 28, wickets: 1))),
      Match(id: 'm2', homeTeam: _t('RCB'), awayTeam: _t('KKR'), venue: 'M. Chinnaswamy Stadium, Bengaluru', dateTime: now, status: MatchStatus.live, format: MatchFormat.t20,
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'RCB', runs: 210, wickets: 5, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: []),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'KKR', runs: 148, wickets: 4, overs: 14.3, isCompleted: false,
          batsmen: [const BatsmanScore(name: 'Sunil Narine', runs: 72, balls: 38, fours: 5, sixes: 5, isStriker: true), const BatsmanScore(name: 'Andre Russell', runs: 35, balls: 14, fours: 2, sixes: 3, isStriker: false)],
          bowlers: [const BowlerScore(name: 'Mohammed Siraj', overs: 3, maidens: 0, runsConceded: 32, wickets: 2)],
          recentBalls: ['6', '4', '1', '0', '6', '2'],
          striker: const BatsmanScore(name: 'Sunil Narine', runs: 72, balls: 38, fours: 5, sixes: 5, isStriker: true),
          nonStriker: const BatsmanScore(name: 'Andre Russell', runs: 35, balls: 14, fours: 2, sixes: 3, isStriker: false),
          currentBowler: const BowlerScore(name: 'Mohammed Siraj', overs: 3.3, maidens: 0, runsConceded: 32, wickets: 2))),

      // Upcoming
      Match(id: 'm3', homeTeam: _t('DC'), awayTeam: _t('RR'), venue: 'Arun Jaitley Stadium, Delhi', dateTime: now.add(const Duration(days: 1)), status: MatchStatus.upcoming, format: MatchFormat.t20),
      Match(id: 'm4', homeTeam: _t('SRH'), awayTeam: _t('GT'), venue: 'Rajiv Gandhi Intl Stadium, Hyderabad', dateTime: now.add(const Duration(days: 2)), status: MatchStatus.upcoming, format: MatchFormat.t20),
      Match(id: 'm5', homeTeam: _t('PBKS'), awayTeam: _t('LSG'), venue: 'IS Bindra Stadium, Mohali', dateTime: now.add(const Duration(days: 3)), status: MatchStatus.upcoming, format: MatchFormat.t20),
      Match(id: 'm6', homeTeam: _t('CSK'), awayTeam: _t('RCB'), venue: 'MA Chidambaram Stadium, Chennai', dateTime: now.add(const Duration(days: 5)), status: MatchStatus.upcoming, format: MatchFormat.t20),
      Match(id: 'm7', homeTeam: _t('MI'), awayTeam: _t('KKR'), venue: 'Wankhede Stadium, Mumbai', dateTime: now.add(const Duration(days: 7)), status: MatchStatus.upcoming, format: MatchFormat.t20),

      // Completed
      Match(id: 'm8', homeTeam: _t('MI'), awayTeam: _t('RCB'), venue: 'Wankhede Stadium, Mumbai', dateTime: now.subtract(const Duration(days: 2)), status: MatchStatus.completed, format: MatchFormat.t20, result: 'MI won by 7 wickets',
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'RCB', runs: 178, wickets: 8, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: []),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'MI', runs: 182, wickets: 3, overs: 18.4, isCompleted: true, batsmen: [], bowlers: [], recentBalls: [])),
      Match(id: 'm9', homeTeam: _t('CSK'), awayTeam: _t('DC'), venue: 'MA Chidambaram Stadium, Chennai', dateTime: now.subtract(const Duration(days: 3)), status: MatchStatus.completed, format: MatchFormat.t20, result: 'CSK won by 25 runs',
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'CSK', runs: 198, wickets: 5, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: []),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'DC', runs: 173, wickets: 8, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: [])),
      Match(id: 'm10', homeTeam: _t('KKR'), awayTeam: _t('SRH'), venue: 'Eden Gardens, Kolkata', dateTime: now.subtract(const Duration(days: 5)), status: MatchStatus.completed, format: MatchFormat.t20, result: 'KKR won by 5 wickets',
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'SRH', runs: 188, wickets: 6, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: []),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'KKR', runs: 192, wickets: 5, overs: 19.3, isCompleted: true, batsmen: [], bowlers: [], recentBalls: [])),
      Match(id: 'm11', homeTeam: _t('RR'), awayTeam: _t('GT'), venue: 'Sawai Mansingh Stadium, Jaipur', dateTime: now.subtract(const Duration(days: 7)), status: MatchStatus.completed, format: MatchFormat.t20, result: 'RR won by 12 runs',
        innings1: InningsData(inningsNumber: 1, battingTeamId: 'RR', runs: 205, wickets: 4, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: []),
        innings2: InningsData(inningsNumber: 2, battingTeamId: 'GT', runs: 193, wickets: 9, overs: 20.0, isCompleted: true, batsmen: [], bowlers: [], recentBalls: [])),
    ];
  }

  static Stream<Map<String, InningsData>> liveScoreStream() {
    return Stream.periodic(const Duration(seconds: 5), (_) {
      final outcomes = ['0', '1', '1', '2', '4', '4', '6', 'W', '0', '1', '2', '0'];
      final Map<String, InningsData> updates = {};
      for (final m in getMatches().where((m) => m.status == MatchStatus.live)) {
        final inn = m.activeInnings;
        if (inn == null || inn.isCompleted) continue;
        final ball = outcomes[_rand.nextInt(outcomes.length)];
        int addRuns = 0;
        int addWickets = 0;
        if (ball == 'W') {
          addWickets = 1;
        } else {
          addRuns = int.parse(ball);
        }
        final newBalls = [...inn.recentBalls, ball];
        if (newBalls.length > 6) newBalls.removeAt(0);
        double newOvers = inn.overs;
        final currentBall = ((newOvers * 10) % 10).round();
        if (currentBall >= 5) {
          newOvers = (newOvers.floor() + 1).toDouble();
        } else {
          newOvers = newOvers.floor() + (currentBall + 1) / 10;
        }
        updates[m.id] = inn.copyWith(
          runs: inn.runs + addRuns,
          wickets: inn.wickets + addWickets,
          overs: newOvers,
          recentBalls: newBalls,
        );
      }
      return updates;
    });
  }
}
