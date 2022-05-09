import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class SubExpansionItems extends StatelessWidget {
  const SubExpansionItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor2,
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color: kPrimaryColor2,
          border: Border(
            top: BorderSide(
              color: kgreyColor.shade600,
              width: 0.4,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children:const [
                
                 SizedBox(
                  width: 40.0,
                ),
                 Text(
                  'LA Galaxy',
                  style: TextStyle(
                    color: kgreyColor,
                    fontSize: 17.0,
                  ),
                )
              ],
            ),
            Icon(Icons.navigate_next, size: 35.0, color: kgreyColor.shade700)
          ],
        ),
      ),
    );
  }
}
