class FightResult {
  final String result;
  const FightResult._({required this.result});

  static const FightResult draw = FightResult._(result: 'Draw');
  static const FightResult won = FightResult._(result: 'Won');
  static const FightResult lost = FightResult._(result: 'Lost');

  static FightResult? calculateResult(final int yourLives, final int enemyLives) {
    if (enemyLives == 0 && yourLives == 0) {
      return draw;
    } else if (enemyLives == 0) {
      return won;
    } else if (yourLives == 0) {
      return lost;
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return 'FightResult{result: $result}';
  }
}
