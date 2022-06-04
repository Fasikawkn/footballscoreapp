import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/models.dart';
import 'package:footballscoreapp/src/views/views.dart';

class ExpansionWrapper extends StatelessWidget {
  const ExpansionWrapper(
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          childrenPadding: EdgeInsets.zero,
          title: Row(
            children: [
              leadingWidget,
              const SizedBox(
                width: 20.0,
              ),
              Text(
                leadingName,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
          children: children,
              ),
    );
  }
}

class SubExpansionItem extends StatelessWidget {
  const SubExpansionItem({required this.league, Key? key})
      : super(key: key);
  final League league;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.primary,
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
            Expanded(
              child: Row(
                children: [
                  CustomCachedNetworkImage(
                      url: league.league!.logo.toString(),
                      placeholder: 'assets/images/ball_one.png',
                      width: 20.0),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Text(
                      league.league!.name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.navigate_next, size: 35.0, color: kgreyColor.shade700)
          ],
        ),
      ),
    );
  }
}
