import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';

class TopSliverAppBar extends StatelessWidget {
  const TopSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        elevation: 0.0,
        leadingWidth: 40,
        automaticallyImplyLeading: false,
        expandedHeight: 20,
        leading: Container(),
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(20.0)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.ballot,
                color: kWhiteColor,
                size: 25.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Expanded(
              flex: 5,
              child: SizedBox(
                width: 100,
                child: Text(
                  'World UEFA - Champions league',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: kgreyColor,
                ),
                onTap: () {},
              ),
            ),
          ]),
        ),
        actions: [
          IconButton(onPressed: (() {}), icon: const Icon(Icons.notifications)),
          IconButton(
              onPressed: (() {}),
              icon: const Icon(Icons.screen_share_outlined)),
        ],
        backgroundColor: kPrimaryColor2);
  }
}
