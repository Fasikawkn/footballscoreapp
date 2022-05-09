import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class ExpansionWrapper extends StatelessWidget {
  const ExpansionWrapper(
      {required this.leadingWidget,
      required this.leadingName,
      required this.subExpansionItems,
      required this.isBottomBorderd,

      Key? key})
      : super(key: key);
  final String leadingName;
  final Widget leadingWidget;
  final List<SubExpansionTileItem> subExpansionItems;
  final bool isBottomBorderd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:isBottomBorderd? BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kgreyColor.shade600,
            width: 0.6
          )
        )
      ): const BoxDecoration(),
      child: ExpansionTile(
        textColor: kWhiteColor,
        iconColor: kgreyColor,
        initiallyExpanded: true,
        collapsedIconColor: kgreyColor,
        collapsedBackgroundColor: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        childrenPadding: EdgeInsets.zero,
        title: Row(
          children: [
            leadingWidget,
           
            const SizedBox(
              width: 20.0,
            ),
            Text(leadingName, style: kLeagueNameTextStyle,)
          ],
        ),
        children: subExpansionItems.map((items) =>  GestureDetector(
          onTap: (){
            items.onPressed();
          },
          child: Container(
              color: kPrimaryColor2,
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  decoration: BoxDecoration(
                    color: kPrimaryColor2,
                    border: Border(
                      bottom: BorderSide(
                        color: kgreyColor.shade600,
                        width: 0.4,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/ball_one.png',
                            width: 20.0,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Text(
                            'LA Galaxy',
                            style: TextStyle(
                              color: kgreyColor,
                              fontSize: 17.0,
                            ),
                          )
                        ],
                      ),
                      Icon(Icons.navigate_next,
                          size: 35.0, color: kgreyColor.shade700)
                    ],
                  ),
                  ),
            ),
        )).toList(),
      ),
    );
  }
}

class SubExpansionTileItem {
  String name;
  IconData icon;
  final Function onPressed;

  SubExpansionTileItem({
    required this.onPressed,
    required this.icon, required this.name});
}
