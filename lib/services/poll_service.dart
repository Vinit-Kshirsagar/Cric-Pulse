import 'dart:async';
import 'dart:math';
import '../models/poll.dart';

/// Poll service — uses local mock with simulated real-time updates.
/// Swap internals for Supabase real-time when project is connected.
class PollService {
  static final _rand = Random();

  static final List<Poll> _mockPolls = [
    Poll(
      id: 'poll1',
      question: 'Will MI chase 186 against CSK tonight?',
      options: ['Yes, MI will win', 'No, CSK will defend'],
      votes: {'Yes, MI will win': 342, 'No, CSK will defend': 278},
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      matchId: 'm1',
    ),
    Poll(
      id: 'poll2',
      question: 'Who will score more tonight — SKY or Ruturaj?',
      options: ['Suryakumar Yadav', 'Ruturaj Gaikwad'],
      votes: {'Suryakumar Yadav': 487, 'Ruturaj Gaikwad': 334},
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      matchId: 'm1',
    ),
    Poll(
      id: 'poll3',
      question: 'Will Bumrah take 3+ wickets in this match?',
      options: ['Yes 🔥', 'No'],
      votes: {'Yes 🔥': 512, 'No': 198},
      createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
      matchId: 'm1',
    ),
    Poll(
      id: 'poll4',
      question: 'Predict KKR\'s final score chasing 211 vs RCB',
      options: ['Under 180', '180-200', '200-210', 'Chase it down!'],
      votes: {'Under 180': 89, '180-200': 156, '200-210': 234, 'Chase it down!': 312},
      createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
      matchId: 'm2',
    ),
    Poll(
      id: 'poll5',
      question: 'Who will win the Orange Cap in IPL 2026?',
      options: ['Virat Kohli', 'Rohit Sharma', 'Suryakumar Yadav', 'Ruturaj Gaikwad'],
      votes: {'Virat Kohli': 623, 'Rohit Sharma': 412, 'Suryakumar Yadav': 534, 'Ruturaj Gaikwad': 287},
      createdAt: DateTime.now(),
    ),
    Poll(
      id: 'poll6',
      question: 'Will Narine smash a 50 in the powerplay today?',
      options: ['Yes, easy!', 'No chance', 'He\'ll get close'],
      votes: {'Yes, easy!': 245, 'No chance': 167, 'He\'ll get close': 312},
      createdAt: DateTime.now(),
      matchId: 'm2',
    ),
    Poll(
      id: 'poll7',
      question: 'Which team will finish at the top of the IPL 2026 table?',
      options: ['MI', 'CSK', 'RCB', 'KKR', 'Other'],
      votes: {'MI': 345, 'CSK': 298, 'RCB': 267, 'KKR': 234, 'Other': 156},
      createdAt: DateTime.now(),
    ),
  ];

  List<Poll> getActivePolls() => List.from(_mockPolls);

  /// Simulates real-time vote updates.
  Stream<List<Poll>> pollStream() {
    return Stream.periodic(const Duration(seconds: 3), (_) {
      for (int i = 0; i < _mockPolls.length; i++) {
        final poll = _mockPolls[i];
        final newVotes = Map<String, int>.from(poll.votes);
        final optionIndex = _rand.nextInt(poll.options.length);
        final option = poll.options[optionIndex];
        newVotes[option] = (newVotes[option] ?? 0) + _rand.nextInt(5) + 1;
        _mockPolls[i] = poll.copyWith(votes: newVotes);
      }
      return List<Poll>.from(_mockPolls);
    });
  }

  /// Vote on a poll.
  Future<Poll> vote(String pollId, String option) async {
    final idx = _mockPolls.indexWhere((p) => p.id == pollId);
    if (idx == -1) throw Exception('Poll not found');
    final poll = _mockPolls[idx];
    final newVotes = Map<String, int>.from(poll.votes);
    newVotes[option] = (newVotes[option] ?? 0) + 1;
    _mockPolls[idx] = poll.copyWith(votes: newVotes);
    return _mockPolls[idx];
  }
}
