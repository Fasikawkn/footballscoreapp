import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/models/route_league_model.dart';
import 'package:footballscoreapp/src/views/views.dart';

class TopSliverAppBar extends StatelessWidget {
  const TopSliverAppBar({required this.leagueModel, Key? key})
      : super(key: key);
  final RouteLeagueModel leagueModel;

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
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20.0)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 1,
              child: CustomCachedNetworkImage(
                  url: leagueModel.logo.toString(),
                  placeholder: 'assets/images/ball_one.png',
                  width: 20),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                width: 100,
                child: Text(
                  leagueModel.name.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
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
        backgroundColor: Theme.of(context).colorScheme.primary);
  }
}
