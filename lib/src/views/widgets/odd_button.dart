import 'package:flutter/material.dart';

class OddButton extends StatelessWidget {
  const OddButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);
  final Color color;
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 25.0,
        decoration: BoxDecoration(
            color: color,
             borderRadius: BorderRadius.circular(3.0)),
        child:  Center(
          child:  Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
