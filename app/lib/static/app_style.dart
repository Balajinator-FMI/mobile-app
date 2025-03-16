import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  // Colors
  static const Color bgColor = Color(0xFF070710);
  static const Color secondaryColor1 = Color(0xFF0A0D14);
  static const Color secondaryColor2 = Color(0xFF1E1D2B);
  static const Color contrastColor1 = Color(0xFF005EEC);
  static const Color textColor = Colors.white;
  static final Color textColorWith05Opacity = textColor.withOpacity(0.5);
  static final Color textColorWith07Opacity = textColor.withOpacity(0.7);
  static const Color iconColor = Colors.white;
  static const Color dividerColor = Colors.white;
  static const List<Color> skinColors = [
    Color(0xFFFFDFC4), // Type 1
    Color(0xFFF0D5BE), // Type 2
    Color(0xFFE1B899), // Type 3
    Color(0xFFC68642), // Type 4
    Color(0xFF8D5524), // Type 5
    Color(0xFF5D3A1A), // Type 6
  ];

}