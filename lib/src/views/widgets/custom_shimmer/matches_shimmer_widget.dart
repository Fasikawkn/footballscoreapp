import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/views/widgets/widgets.dart';

class MatchesShimmerWidget extends StatelessWidget {
  const MatchesShimmerWidget({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      width: size.width,
      margin: const EdgeInsets.only(top: 4.0),
      decoration: const BoxDecoration(
        color: kPrimaryColor2,
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CursomShimmerWidget.circular(
                      height: 20,
                      width: 20,
                    ),
                    CursomShimmerWidget.rectangular(
                      height: 10.0,
                      width: size.width - 120,
                    ),
                     CursomShimmerWidget.rectangular(
                      height: 10.0,
                      width: 20,
                    ),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     CursomShimmerWidget.rectangular(
                      height: 10.0,
                      width: 50.0,
                    ),
                    //  const Padding(padding:  EdgeInsets.symmetric(horizontal:10.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CursomShimmerWidget.rectangular(
                          height: 10.0,
                          width: size.width * 0.4,
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0)),
                        CursomShimmerWidget.rectangular(
                          height: 10.0,
                          width: size.width * 0.4,
                        ),
                      ],
                    ),
                     CursomShimmerWidget.rectangular(
                      height: 20.0,
                      width: 20.0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
