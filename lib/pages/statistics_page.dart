import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';

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
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                'Statistics',
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
              Expanded(child: SizedBox()),
              SecondaryActionButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text: "Back",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
