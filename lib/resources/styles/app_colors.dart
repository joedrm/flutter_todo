import 'package:flutter/material.dart';
import 'package:flutter_todo/resources/styles/app_themes.dart';

class AppColors {
  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryGradient,
    required this.bgColor,
    required this.tabItemNormalColor,
    required this.tabItemSelectedColor,
  });

  static late AppColors current;

  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  final Color bgColor;
  final Color tabItemNormalColor;
  final Color tabItemSelectedColor;

  /// gradient
  final LinearGradient primaryGradient;

  static const AppColors defaultAppColor = AppColors(
    primaryColor: Color(0xFFFF1F1F),
    secondaryColor: Color(0xFFFFA5A5),
    primaryTextColor: Color.fromARGB(255, 62, 62, 70),
    secondaryTextColor: Color.fromARGB(255, 166, 168, 254),
    primaryGradient:
        LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
    bgColor: Color(0xffeeeeee),
    tabItemNormalColor: Color(0xFFCCCCCC),
    tabItemSelectedColor: Color(0xFF2D2D2D),
  );

  static const darkThemeColor = AppColors(
    primaryColor: Color.fromARGB(255, 62, 62, 70),
    secondaryColor: Color.fromARGB(255, 166, 168, 254),
    primaryTextColor: Color.fromARGB(255, 166, 168, 254),
    secondaryTextColor: Color.fromARGB(255, 62, 62, 70),
    primaryGradient:
        LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
    bgColor: Color(0xff222222),
    tabItemNormalColor: Color(0xFF2D2D2D),
    tabItemSelectedColor: Color(0xFFCCCCCC),
  );

  static AppColors of(BuildContext context) {
    final appColor = Theme.of(context).appColor;

    current = appColor;

    return current;
  }

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    LinearGradient? primaryGradient,
    Color? tabItemNormalColor,
    Color? tabItemSelectedColor,
    Color? bgColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      tabItemNormalColor: tabItemNormalColor ?? this.tabItemNormalColor,
      tabItemSelectedColor: tabItemSelectedColor ?? this.tabItemSelectedColor,
      bgColor: bgColor ?? this.bgColor,
    );
  }
}
