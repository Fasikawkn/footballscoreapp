import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';
import 'package:footballscoreapp/src/config/routes/routes.dart';

void main() {
  runApp(const FootballScoreApp());
}

class FootballScoreApp extends StatelessWidget {
  const FootballScoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoute.generateRoute,
      theme: ThemeData(
        primarySwatch: createMaterialColor(kPrimaryColor2),
        primaryColor: kPrimaryColor
      ),
    );
  }
}
