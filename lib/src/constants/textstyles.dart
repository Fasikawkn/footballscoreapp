
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

const kTeamNameTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Colors.white
);

// const kLeagueNameTextStyle = TextStyle(
//   fontSize: 14.0,
//   fontWeight: FontWeight.w600,
//   color: Colors.white
// );

const kTeamMatchPlayTimeTextStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

const kTeamMatchSponsorName = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  color: Colors.blue
);


GroupButtonOptions groupButtonOptions() {
    return GroupButtonOptions(
        borderRadius: BorderRadius.circular(20.0),
        buttonHeight: 30.0,
        textPadding: EdgeInsets.zero,
        groupingType: GroupingType.wrap,
        spacing: 5.0,
        // alignment: Alignment.centerLeft,
        mainGroupAlignment: MainGroupAlignment.end,
        unselectedBorderColor: Colors.grey,
        unselectedColor: Colors.transparent,
        selectedBorderColor: Colors.transparent,
        unselectedTextStyle:
            const TextStyle(color: Color.fromARGB(255, 164, 132, 132)),
        selectedColor: Colors.blue.withOpacity(0.5),
        selectedTextStyle: const TextStyle(color: Colors.blue));
  }