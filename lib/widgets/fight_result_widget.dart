import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';

import '../resources/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({super.key, required this.fightResult});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12.0,
                  left: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'You',
                        style: TextStyle(color: FightClubColors.darkGreyText),
                      ),
                    ),
                    SizedBox(
                      height: 92,
                      width: 92,
                      child: Image.asset(FightClubImages.youAvatar),
                    ),
                  ],
                ),
              ),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: _getStadiumColor(fightResult),
                ),
                child: Center(
                  child: Text(
                    fightResult.toString().toLowerCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: FightClubColors.circlVSText,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  bottom: 12.0,
                  right: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        'Enemy',
                        style: TextStyle(color: FightClubColors.darkGreyText),
                      ),
                    ),
                    SizedBox(
                      height: 92,
                      width: 92,
                      child: Image.asset(FightClubImages.enemyAvatar),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStadiumColor(FightResult fightResult) {
    switch (fightResult) {
      case FightResult.won:
        return FightClubColors.wonStadium;
      case FightResult.lost:
        return FightClubColors.lostStadium;
      case FightResult.draw:
        return FightClubColors.drawStadium;
      default:
        throw ArgumentError('Unknown FightResult: $fightResult');
    }
  }
}
