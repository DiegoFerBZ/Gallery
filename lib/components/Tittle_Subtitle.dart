import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  final String mainTitle;
  final String subtitle;
  final Color? mainTitleColor;
  final Color? subtitleColor;
  final double verticalSpacing;

  const AuthTitle({
    super.key,
    required this.mainTitle,
    required this.subtitle,
    this.mainTitleColor,
    this.subtitleColor,
    this.verticalSpacing = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: verticalSpacing),
          child: Text(
            mainTitle,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: mainTitleColor ?? Colors.blueGrey,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: verticalSpacing),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 16.0,
              color: subtitleColor ?? Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}