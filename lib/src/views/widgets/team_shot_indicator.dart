import 'package:flutter/material.dart';


class TeamShotIndicator extends StatelessWidget {
  const TeamShotIndicator(
      {Key? key, required this.isSelected, required this.color})
      : super(key: key);
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4.0,
            width: 4.0,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 0.7),
              width: 3,
              height: 1.5,
              decoration:
                  BoxDecoration(color: color, shape: BoxShape.rectangle),
            )
        ],
      ),
    );
  }
}
