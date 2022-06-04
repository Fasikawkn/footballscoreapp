import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';


class TeamsExpansionWraper extends StatelessWidget {

  const TeamsExpansionWraper(
      {required this.leadingWidget,
      required this.leadingName,
      required this.children,
      required this.isBottomBorderd,
      Key? key})
      : super(key: key);
  final String leadingName;
  final Widget leadingWidget;
  final bool isBottomBorderd;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isBottomBorderd
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: kgreyColor.shade600, width: 0.6)))
          : const BoxDecoration(),
      child: ExpansionTile(
          textColor: kWhiteColor,
          iconColor: kgreyColor,
          initiallyExpanded: false,
          collapsedIconColor: kgreyColor,
          collapsedBackgroundColor: Theme.of(context).colorScheme.secondary,
          backgroundColor:  Theme.of(context).colorScheme.secondary,
          childrenPadding: EdgeInsets.zero,
          title: Row(
            children: [
              leadingWidget,
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Text(
                  leadingName,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
          children: children
          ),
    );
  }
}