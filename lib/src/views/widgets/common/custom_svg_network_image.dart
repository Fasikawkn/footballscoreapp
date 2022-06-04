import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
class CustomeFlag extends StatelessWidget {
  const CustomeFlag({Key? key, required this.size, required this.imageData})
      : super(key: key);

  final double size;
  final String imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
       
      ),
      child: ClipOval(
        clipBehavior: Clip.hardEdge,
        child: Transform.scale(
          scale: 1.5,
          child: SizedBox(
            height: size * 0.2,
            width: size * 0.2,
            child: SvgPicture.network(
      imageData,
      
      placeholderBuilder: (context) => Image.asset(
        'assets/images/ball_one.png',
      ),
      height: size * 0.2,
      width: size * 0.2,
      fit: BoxFit.fill,
      allowDrawingOutsideViewBox: true,
    ),
          ),
        ),
      ),
    );
    
  }
}