class FightResult {
  final String result;

  static const FightResult draw = FightResult._(result: 'Draw');
  static const FightResult youWon = FightResult._(result: 'You won');
  static const FightResult youLost = FightResult._ (result: 'You lost');

  const FightResult._({
    required this.result
  });
}