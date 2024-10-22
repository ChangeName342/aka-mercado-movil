import 'package:flutter/material.dart';

String uri = 'http://192.168.0.21:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(220, 53, 69, 1),
      Color.fromRGBO(220, 53, 69, 1),
    ],
    stops: [0.5, 1.0],
  );
  
  static const secondaryColor = Color.fromRGBO(220, 53, 69, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromRGBO(220, 53, 69, 1)!;
  static const unselectedNavBarColor = Colors.black87;
}