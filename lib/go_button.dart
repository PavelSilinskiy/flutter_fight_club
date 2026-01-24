import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        color: color,
        height: 40,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: FightClubColors.whiteText,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
