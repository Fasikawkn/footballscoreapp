import 'package:flutter/material.dart';


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}



const kPrimaryColor = Color(0xff191A1D);
const kPrimaryColor2 = Color(0xff1F1F26);

const kgreyColor = Colors.grey;
const kWhiteColor = Colors.white;
const kScaffoldBackGroundColor = Colors.black;
const kBlueColor = Colors.blue;

// about app
const appName = 'Foot Ball Score App';
const aboutAppText = 'Football Score App is an app the gives guide about matches in popular leagues, countries and mathes';
const mainAppFeature = 'Main app feature';
const featureDetail = 'Fixture, result, stats, table and top scorers data.';
const appBuildText = 'App Build Version 1.0.0';