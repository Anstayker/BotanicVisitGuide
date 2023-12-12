import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final IconData? iconData;
  final double verticalPadding;
  final double horizontalPadding;

  const TitleText({
    super.key,
    required this.title,
    this.iconData,
    this.verticalPadding = 0.0,
    this.horizontalPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        children: [
          if (iconData != null)
            Icon(
              iconData,
              size: 24.0,
            ),
          const SizedBox(width: 16.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
