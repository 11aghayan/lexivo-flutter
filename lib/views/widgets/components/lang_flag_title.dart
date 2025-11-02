import 'package:flutter/material.dart';

class LangFlagTitle extends StatelessWidget {
  const LangFlagTitle({
    super.key,
    required this.photoPath,
    this.height = 40,
    this.width = 40,
  });

  final String photoPath;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      photoPath,
      fit: BoxFit.contain,
      height: height,
      width: width,
    );
  }
}
