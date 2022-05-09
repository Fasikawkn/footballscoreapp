import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/views/views.dart';

class MiddleSliverAppBar extends StatefulWidget {
  const MiddleSliverAppBar({ Key? key }) : super(key: key);

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
                  
          
    
                  flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                    top = constraints.biggest.height;
                    print('THe height is $top');
                    return Container(
                      width: top == 80.0 ? 100 : double.infinity,
                      decoration: const BoxDecoration(
                        color: kPrimaryColor2,
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
                                      Image.asset(
                                        'assets/images/ball_one.png',
                                        width: 25,
                                      ),
                                      if (top > 120)
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      if (top > 120)
                                        const Flexible(
                                          child: Text(
                                            'Manchester City',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      if (top > 120)
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                      if (top > 120)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                  child: const Text(
                                    '10:00 AM',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      if (top > 120) const SizedBox(height: 20.0),
                                      Image.asset(
                                        'assets/images/ball_two.png',
                                        width: 25,
                                      ),
                                      if (top > 120)
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                      if (top > 120)
                                        const Flexible(
                                          child: Text(
                                            'Manchester City',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      if (top > 120)
                                        const SizedBox(
                                          height: 3.0,
                                        ),
                                      if (top > 120)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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