
import 'package:flutter/material.dart';
import 'package:footballscoreapp/src/constants/constants.dart';



class Styles {
  ThemeData themeData(bool isDarkTheme, String fontSize) {
    debugPrint('Is Dark $isDarkTheme');
    return ThemeData(
      primarySwatch: isDarkTheme
          ? createMaterialColor(kPrimaryColor)
          : createMaterialColor(const Color.fromARGB(255, 235, 235, 235)),
      primaryColor: isDarkTheme ? kPrimaryColor : Colors.white,
      iconTheme: IconThemeData(
        color: isDarkTheme ? kWhiteColor : kgreyColor,
      ),
      colorScheme: ColorScheme(
          brightness: isDarkTheme ? Brightness.dark : Brightness.light,
          primary: isDarkTheme ? kPrimaryColor2 : Colors.white,
          onPrimary: isDarkTheme ? kPrimaryColor2 : Colors.white,
          secondary: isDarkTheme
              ? kPrimaryColor
              : const Color.fromARGB(255, 229, 240, 247),
          onSecondary: isDarkTheme
              ? kPrimaryColor
              : const Color.fromARGB(255, 215, 219, 219),
          error: Colors.red,
          onError: Colors.red,
          background: isDarkTheme ? kPrimaryColor2 : const Color(0xffF1F5FB),
          onBackground: isDarkTheme ? kPrimaryColor2 : const Color(0xffF1F5FB),
          surface: isDarkTheme ? Colors.black.withOpacity(0.6) : Color.fromARGB(255, 180, 183, 187),
          onSurface: isDarkTheme ? kPrimaryColor2 : const Color(0xffF1F5FB)),
      backgroundColor: isDarkTheme ? kPrimaryColor2 : const Color(0xffF1F5FB),
      scaffoldBackgroundColor:
          isDarkTheme ? Colors.black : const Color.fromARGB(255, 238, 228, 228),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      textTheme: TextTheme(
          bodyText2:  TextStyle(
            color: kgreyColor,
            fontWeight: FontWeight.w400,
            fontSize: 13.0 + getFontSize(fontSize),
          ),
          bodyText1: TextStyle(
            fontSize: 14.0 + getFontSize(fontSize),
            fontWeight: FontWeight.w600,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          headline1: TextStyle(
              color: isDarkTheme ? Colors.white : Colors.black,
              fontSize: 18.0 + getFontSize(fontSize),
              fontWeight: FontWeight.w700)),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme ? kPrimaryColor2 : Colors.white,
        elevation: 4.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
  int getFontSize(String fontSize){
    if(fontSize == 'M'){
      return 0;
    }else if(fontSize == "L"){
      return 2;
    }else{
      return 4;
    }
  }
}
