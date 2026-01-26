import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';

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
                Expanded(child: SizedBox()),
                ActionButton(
                  onTap: () {},
                  color: FightClubColors.blackButton,
                  text: 'Start'.toUpperCase(),
                ),
                SizedBox(height: 12),
                ActionButton(
                  onTap: () {},
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
