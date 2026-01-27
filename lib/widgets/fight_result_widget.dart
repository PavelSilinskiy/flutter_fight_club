import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

import '../resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({
    super.key,
    required this.fightResult,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
            ],
          ),
        ],
      ),
    );
  }
}