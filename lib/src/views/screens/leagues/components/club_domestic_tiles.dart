import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class ClubDomesticTile extends StatefulWidget {
  const ClubDomesticTile(
      {required this.leadingWidget,
      required this.leadingName,
      required this.subExpansionItems,
      required this.isBottomBorderd,
      required this.collapsedBackgroundColor,

      Key? key})
      : super(key: key);
  final String leadingName;
  final Widget leadingWidget;
  final List<Widget> subExpansionItems;
  final bool isBottomBorderd;
  final Color collapsedBackgroundColor;

  @override
  State<ClubDomesticTile> createState() => _ClubDomesticTileState();
}

class _ClubDomesticTileState extends State<ClubDomesticTile> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.isBottomBorderd
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: kgreyColor.shade600, width: 0.6)))
          : const BoxDecoration(),
      child: ExpansionTile(
        
          textColor: kWhiteColor,
          iconColor: kgreyColor,
          initiallyExpanded: true,
          collapsedIconColor: kgreyColor,
          collapsedBackgroundColor: widget.collapsedBackgroundColor,
          backgroundColor: kPrimaryColor2,
          childrenPadding: EdgeInsets.zero,
          title: Row(
            children: [
              widget.leadingWidget,
              const SizedBox(
                width: 20.0,
              ),
              Text(
                widget.leadingName,
                style: kLeagueNameTextStyle,
              )
            ],
          ),
          children: widget.subExpansionItems,
          ),
    );
  }
}



