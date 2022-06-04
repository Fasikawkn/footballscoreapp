import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/models/match.dart';
import 'package:footballscoreapp/src/views/views.dart';

class MiddleSliverAppBar extends StatefulWidget {
  const MiddleSliverAppBar({required this.gameMatch, Key? key})
      : super(key: key);
  final GameMatch gameMatch;

  @override
  State<MiddleSliverAppBar> createState() => _MiddleSliverAppBarState();
}

class _MiddleSliverAppBarState extends State<MiddleSliverAppBar> {
  var top = 0.0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      snap: true,
      pinned: true,
      floating: true,
      toolbarHeight: 80.0,
      expandedHeight: 170,
      elevation: 0.0,
      backgroundColor: Theme.of(context).colorScheme.primary,

      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        top = constraints.biggest.height;
        return Container(
          width: top == 80.0 ? 100 : double.infinity,
          decoration:  BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (top > 120)
                            const SizedBox(
                              height: 20.0,
                            ),
                          CustomCachedNetworkImage(
                            width: 35.0,
                            url: widget.gameMatch.teams!.home!.logo!,
                            placeholder:
                                'assets/images/team_placeholder_image.png',
                          ),
                          if (top > 120)
                            const SizedBox(
                              height: 8.0,
                            ),
                          if (top > 120)
                             Flexible(
                              child: Text(
                                widget.gameMatch.teams!.home!.name!,
                                textAlign: TextAlign.center,
                                style:Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 10.0
                                ),
                              ),
                            ),
                          if (top > 120)
                            const SizedBox(
                              height: 3.0,
                            ),
                          if (top > 120)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                TeamShotIndicator(
                                  color: Colors.green,
                                  isSelected: true,
                                ),
                                TeamShotIndicator(
                                  color: Colors.red,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.red,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.green,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.green,
                                  isSelected: false,
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: top == 80.0
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.only(top: 30.0),
                      padding: const EdgeInsets.all(8.0),
                      child:  Column(
                        children: [
                           if (top > 120)
                            const SizedBox(
                              height: 20.0,
                            ),
                          TimeState(
                            fontSize: top /8,
                            match: widget.gameMatch,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (top > 120) const SizedBox(height: 20.0),
                          CustomCachedNetworkImage(
                            width: 35.0,
                            url: widget.gameMatch.teams!.away!.logo!,
                            placeholder:
                                'assets/images/team_placeholder_image.png',
                          ),
                          if (top > 120)
                            const SizedBox(
                              height: 8.0,
                            ),
                          if (top > 120)
                             Flexible(
                              child: Text(
                                widget.gameMatch.teams!.away!.name!,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontSize: 10.0
                                ),
                              ),
                            ),
                          if (top > 120)
                            const SizedBox(
                              height: 3.0,
                            ),
                          if (top > 120)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                TeamShotIndicator(
                                  color: Colors.red,
                                  isSelected: true,
                                ),
                                TeamShotIndicator(
                                  color: Colors.red,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.red,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.green,
                                  isSelected: false,
                                ),
                                TeamShotIndicator(
                                  color: Colors.green,
                                  isSelected: false,
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }), //FlexibleSpaceBar
    );
  }
}
