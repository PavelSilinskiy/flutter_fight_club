import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              //left: 16,
              //right: 16,
              top: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'The\nfight\nclub'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: FightClubColors.darkGreyText,
                    fontSize: 30,
                  ),
                ),
                // Expanded(child: SizedBox()),
                Expanded(
                  child: FutureBuilder<String?>(
                    future: SharedPreferences.getInstance().then((
                      sharedPreferences,
                    ) {
                      return sharedPreferences.getString('last_fight_result');
                    }),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return SizedBox();
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                'Last fight result',
                                style: TextStyle(
                                  color: FightClubColors.darkGreyText,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            FightResultWidget(
                              fightResult: FightResult.fromString(
                                snapshot.data!,
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                SecondaryActionButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticsPage()),
                    );
                  },
                  text: 'Statistics'.toUpperCase(),
                ),
                SizedBox(height: 12),
                ActionButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FightPage()),
                    );
                  },
                  color: FightClubColors.blackButton,
                  text: 'Start'.toUpperCase(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
