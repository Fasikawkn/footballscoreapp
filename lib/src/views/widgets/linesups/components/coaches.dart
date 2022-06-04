import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';
import 'package:footballscoreapp/src/models/fixture_lineups.dart';
import 'package:footballscoreapp/src/views/views.dart';

class LineUpCoaches extends StatelessWidget {
  const LineUpCoaches(
      {required this.awayCoach, required this.homeCoach, Key? key})
      : super(key: key);
  final Coach homeCoach;
  final Coach awayCoach;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            decoration: const BoxDecoration(color: kPrimaryColor),
            child: const Text(
              'COACH',
              style: TextStyle(
                color: kgreyColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          Container(
            color: kPrimaryColor2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCoach(homeCoach),
                _buildCoach(awayCoach)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoach(Coach coach) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ContactNetworkImage(url: coach.photo.toString(), width: 30),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            coach.name.toString(),
            style:
                const TextStyle(color: kgreyColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
