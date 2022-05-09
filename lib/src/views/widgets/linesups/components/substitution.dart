import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class Substitution extends StatelessWidget {
  const Substitution({Key? key}) : super(key: key);

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
              'SUBSTITUTION ON BENCH',
              style: TextStyle(
                color: kgreyColor,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
          
          Container(
              // height: 500,
              color: kPrimaryColor2,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 0,
                childAspectRatio: 3/2,
                crossAxisSpacing: 0.0,
                crossAxisCount: 2,
                children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
                    .map((item) =>
                        _buildSubstitution('77. John McCarthy', 'GoalKeeper'))
                    .toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildSubstitution(String name, String role) {
    return SizedBox(
      // height: 100,
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
            style: const TextStyle(
              color: kgreyColor,
            ),
          ),
          Text(
            role,
            style: const TextStyle(
                color: kWhiteColor, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
