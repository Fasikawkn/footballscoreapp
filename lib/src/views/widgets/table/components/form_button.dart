import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';



class FormTableButton extends StatelessWidget {
   const FormTableButton({
    Key? key,
    required this.isSelected,
    required this.onPressed,
    }) : super(key: key);
  final bool isSelected;
  final Function onPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 6.0),
        decoration: BoxDecoration(
            color: isSelected
                ? Colors.blue.withOpacity(0.5)
                : Colors.transparent,
            border: isSelected
                ? Border.all(color: Colors.transparent)
                : Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          'FORM',
          style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}