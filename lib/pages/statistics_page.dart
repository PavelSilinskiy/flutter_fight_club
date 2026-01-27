import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _StatisticsPageContent();
  }
}

class _StatisticsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int? wonCount;
    int? drawCount;
    int? lostCount;
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Statistics',
                  style: TextStyle(
                    fontSize: 24,
                    color: FightClubColors.darkGreyText,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 132,
                    child: FutureBuilder(
                      future: SharedPreferences.getInstance().then((
                        sharedPreferences,
                      ) {
                        wonCount = sharedPreferences.getInt('stats_won');
                        drawCount = sharedPreferences.getInt('stats_draw');
                        lostCount = sharedPreferences.getInt('stats_lost');
                      }),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.done) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Won: ${wonCount ?? 0}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: FightClubColors.darkGreyText,
                                ),
                              ),
                              Text(
                                'Draw: ${drawCount ?? 0}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: FightClubColors.darkGreyText,
                                ),
                              ),

                              Text(
                                'Lost: ${lostCount ?? 0}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: FightClubColors.darkGreyText,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SecondaryActionButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: "Back",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
