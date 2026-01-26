import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
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
              bottom: 16,
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
                        return Center(
                          child: Text(
                            'Last result: ${snapshot.data}',
                            style: TextStyle(
                              color: FightClubColors.darkGreyText,
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ActionButton(
                  onTap: () {},
                  color: FightClubColors.blackButton,
                  text: 'Start'.toUpperCase(),
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
