import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/material_colors.dart';

class LineUpCoaches extends StatelessWidget {
  const LineUpCoaches({Key? key}) : super(key: key);

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
                _buildCoach('S. Cherundalo'),
                _buildCoach('A. Health')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoach(String name) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: 30.0,
                )),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            name,
            style:
                const TextStyle(color: kgreyColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
