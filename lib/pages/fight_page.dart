import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/resources/fight_club_icons.dart';
import 'package:flutter_fight_club/resources/fight_club_images.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  static const int maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;
  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart whatEnemyAttacks = BodyPart.random();
  String centralText = '';
  bool enemyLostLife = false;
  bool youLostLife = false;
  int yourLives = maxLives;
  int enemyLives = maxLives;
  // bool isnewGame = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLives: maxLives,
              yourLives: yourLives,
              enemyLives: enemyLives,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 30,
                    horizontal: 16,
                  ),
                  child: ColoredBox(
                    color: FightClubColors.centerBackground,
                    child: Center(
                      child: Text(
                        centralText,
                        //_getCentralText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FightClubColors.darkGreyText,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectDefendingBodyPart: _selectDefendingBodyPart,
              selectAttackingBodyPart: _selectAttackingBodyPart,
            ),
            SizedBox(height: 14),
            ActionButton(
              text: (enemyLives == 0 || yourLives == 0)
                  ? 'Start new game'
                  : 'Go',
              onTap: _go,
              color: _getGoButtonColor(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if ((defendingBodyPart != null && attackingBodyPart != null) ||
        enemyLives == 0 ||
        yourLives == 0) {
      return FightClubColors.blackButton;
    } else {
      return FightClubColors.greyButton;
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
    if (enemyLives == 0 || yourLives == 0) {
      Navigator.pop(context);
    } else if (defendingBodyPart != null && attackingBodyPart != null) {
      setState(() {
        // isnewGame = false;
        youLostLife = (defendingBodyPart != whatEnemyAttacks);
        enemyLostLife = (attackingBodyPart != whatEnemyDefends);
        if (enemyLostLife) {
          enemyLives -= 1;
          centralText =
              'You hit enemy\'s ${attackingBodyPart!.name.toLowerCase()}.';
        } else {
          centralText = 'Your attack was blocked.';
        }
        if (youLostLife) {
          yourLives -= 1;
          centralText =
              '$centralText\nEnemy hit your ${defendingBodyPart!.name.toLowerCase()}.';
        } else {
          centralText = '$centralText\nEnemy\'s attack was blocked.';
        }

        if (enemyLives == 0 && yourLives == 0) {
          centralText = 'Draw';
        } else if (enemyLives == 0) {
          centralText = 'You won';
        } else if (yourLives == 0) {
          centralText = 'You lost';
        }

        defendingBodyPart = null;
        attackingBodyPart = null;
        whatEnemyDefends = BodyPart.random();
        whatEnemyAttacks = BodyPart.random();
      });
    }
  }

  // String _getCentralText() {
  //   String text = '';
  //   if (isnewGame) {
  //     return '';
  //   }
  //   if (enemyLives == 0 && yourLives == 0) {
  //     return 'Draw';
  //   }
  //   if (enemyLives == 0) {
  //     return 'You won';
  //   }
  //   if (yourLives == 0) {
  //     return 'You lost';
  //   }
  //   if (enemyLostLife) {
  //     text = 'You hit enemy\'s ${attackingBodyPart!.name}.';
  //   } else {
  //     text = 'Your attack was blocked.';
  //   }
  //   if (youLostLife) {
  //     text = '$text\nEnemy hit your ${defendingBodyPart!.name}.';
  //   } else {
  //     text = '$text\nEnemy\'s attack was blocked.';
  //   }

  //   return 'Error';
  // }
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

                    style: TextStyle(
                      color: FightClubColors.darkGreyText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
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
                    style: TextStyle(
                      color: FightClubColors.darkGreyText,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
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
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.33, 0.5),
                  end: Alignment(0.33, 0.5),
                  colors: [
                    FightClubColors.yourBackground,
                    FightClubColors.enemyBackground,
                  ],
                ),
              ),
            ),
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: [
          //     Expanded(
          //       child: ColoredBox(color: FightClubColors.yourBackground),
          //     ),
          //     Expanded(
          //       child: ColoredBox(color: FightClubColors.enemyBackground),
          //     ),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                overAllLivesCount: maxLives,
                currentLivesCount: yourLives,
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'You',
                      style: TextStyle(color: FightClubColors.darkGreyText),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 92,
                    width: 92,
                    child: Image.asset(FightClubImages.youAvatar),
                  ),
                ],
              ),
              SizedBox(
                height: 44,
                width: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: FightClubColors.circlVS,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(
                    child: Text(
                      'vs',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: FightClubColors.circlVSText,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Enemy',
                      style: TextStyle(color: FightClubColors.darkGreyText),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 92,
                    width: 92,
                    child: Image.asset(FightClubImages.enemyAvatar),
                  ),
                ],
              ),
              LivesWidget(
                overAllLivesCount: maxLives,
                currentLivesCount: enemyLives,
              ),
            ],
          ),
        ],
      ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(overAllLivesCount, (index) {
        if (index < currentLivesCount) {
          return Image.asset(FightClubIcons.heartFull, width: 18);
        } else {
          return Image.asset(FightClubIcons.heartEmpty, width: 18);
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected
                ? FightClubColors.blueButton
                : FightClubColors.transparentButton,
            border: !selected
                ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                : null,
          ),
          child: Center(
            child: Text(
              style: TextStyle(
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText,
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
