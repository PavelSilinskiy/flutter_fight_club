import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(textTheme: GoogleFonts.pressStart2pTextTheme(textTheme)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart whatEnemyAttacks = BodyPart.random();
  int yourLives = maxLives;
  int enemyLives = maxLives;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD5DEF0),
      body: Column(
        children: [
          SizedBox(height: 40),
          FightersInfo(
            maxLives: maxLives,
            yourLives: yourLives,
            enemyLives: enemyLives,
          ),
          Expanded(child: SizedBox()),
          ControlsWidget(
            defendingBodyPart: defendingBodyPart,
            attackingBodyPart: attackingBodyPart,
            selectDefendingBodyPart: _selectDefendingBodyPart,
            selectAttackingBodyPart: _selectAttackingBodyPart,
          ),
          SizedBox(height: 14),
          GoButton(
            text: (enemyLives == 0 || yourLives == 0) ? 'Start new game' : 'Go',
            onTap: _go,
            color: _getGoButtonColor(),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Color _getGoButtonColor() {
    if ((defendingBodyPart != null && attackingBodyPart != null) ||
        enemyLives == 0 ||
        yourLives == 0) {
      return Colors.black87;
    } else {
      return Colors.black38;
    }
  }

  void _selectDefendingBodyPart(BodyPart value) {
    if (enemyLives != 0 && yourLives != 0) {
      setState(() {
        defendingBodyPart = value;
      });
    }
  }

  void _selectAttackingBodyPart(BodyPart value) {
    if (enemyLives != 0 && yourLives != 0) {
      setState(() {
        attackingBodyPart = value;
      });
    }
  }

  void _go() {
    bool enemyLostLife;
    bool youLostLife;
    if (enemyLives == 0 || yourLives == 0) {
      setState(() {
        enemyLives = maxLives;
        yourLives = maxLives;
      });
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        youLostLife = (defendingBodyPart != whatEnemyAttacks);
        enemyLostLife = (attackingBodyPart != whatEnemyDefends);
        if (youLostLife) {
          yourLives -= 1;
        }
        if (enemyLostLife) {
          enemyLives -= 1;
        }
        defendingBodyPart = null;
        attackingBodyPart = null;
        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();
      });
    }
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 40,
              child: ColoredBox(
                color: color,
                child: Center(
                  child: Text(
                    text.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.87),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectAttackingBodyPart;

  const ControlsWidget({
    super.key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attackingBodyPart,
    required this.selectAttackingBodyPart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Defend'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectDefendingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectDefendingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Center(
                  child: Text(
                    'Attack'.toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(height: 13),
              BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectAttackingBodyPart,
              ),
              SizedBox(height: 14),
              BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectAttackingBodyPart,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLives;
  final int yourLives;
  final int enemyLives;

  const FightersInfo({
    super.key,
    required this.maxLives,
    required this.yourLives,
    required this.enemyLives,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Center(child: Text('You')),
              LivesWidget(
                overAllLivesCount: maxLives,
                currentLivesCount: yourLives,
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Center(child: Text('Enemy')),
              LivesWidget(
                overAllLivesCount: maxLives,
                currentLivesCount: enemyLives,
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overAllLivesCount;
  final int currentLivesCount;

  const LivesWidget({
    super.key,
    required this.overAllLivesCount,
    required this.currentLivesCount,
  }) : assert(currentLivesCount >= 0),
       assert(overAllLivesCount >= currentLivesCount),
       assert(overAllLivesCount >= 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(overAllLivesCount, (index) {
        if (index < currentLivesCount) {
          return Text('1');
        } else {
          return Text('0');
        }
      }),
    );
  }
}

class BodyPart {
  //RichEnum
  final String name;

  const BodyPart._(this.name);
  static const head = BodyPart._('Head');
  static const torso = BodyPart._('Torso');
  static const legs = BodyPart._('Legs');

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton({
    super.key,
    required this.bodyPart,
    required this.selected,
    required this.bodyPartSetter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected ? Color(0xFF1C79CE) : Colors.black38,
          child: Center(
            child: Text(
              style: TextStyle(
                color: selected ? Color(0xFFFFFFFF) : Color(0xFF060D14),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
              bodyPart.name.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }
}
