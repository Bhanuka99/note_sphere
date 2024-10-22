import 'package:flutter/material.dart';

class AppColors{
  //primary color
  static const Color kBgColor =  Color(0xff202326);
  static const Color kFabColor = Color.fromARGB(255, 204, 17, 237);
  static const Color kCardColor = Color(0xff2f3225);
  static const Color kWhiteColor = Colors.white;

  //gradient colors
  static const int gradientStart = 0xff01F0FF;
  static const int gradientEnd = 0xff4441ED;

  LinearGradient kPrimaryGradient = const LinearGradient(colors: [
    Color(gradientStart),
    Color(gradientEnd)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  );
}