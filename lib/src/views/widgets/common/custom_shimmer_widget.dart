import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class CursomShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

    CursomShimmerWidget.rectangular(
      {this.width = double.infinity, required this.height})
      : this.shapeBorder =   RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)
              );

  const CursomShimmerWidget.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});
  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: kPrimaryColor2,
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
              color: Colors.grey[400]!,
              // shape: shapeBorder,
              shape:  shapeBorder
            
             ),
        ),
      );
}