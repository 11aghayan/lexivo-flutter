import 'package:flutter/material.dart';

class AccountBox extends StatelessWidget {
  const AccountBox({super.key});

  final double borderRadius = 15.0;
  final double iconSize = 30.0;
  final double padding = 10.0;
  final double height = 50.0;
  final double width = 50.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //TODO: Add real profile pic if it's there
      child: Container(
        padding: EdgeInsets.all(padding),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          // color: ThemeColorsLight.primary,
        ),
        child: Center(
          child: Icon(
            Icons.person,
            size: iconSize,
            // color: ThemeColorsLight.contrastPrimary,
          ),
        ),
      ),
    );
  }
}
