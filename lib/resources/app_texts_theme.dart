import 'package:flutter/material.dart';

class AppTextsTheme extends ThemeExtension<AppTextsTheme> {
  static const _baseFamily = "Base";

  final TextStyle labelH1;
  final TextStyle labelH2;
  final TextStyle labelTextDefault;

  const AppTextsTheme._internal(
      {required this.labelH1,
      required this.labelH2,
      required this.labelTextDefault});

  factory AppTextsTheme.main() => const AppTextsTheme._internal(
      labelH1: TextStyle(
        fontFamily: _baseFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18,
        height: 1.4,
      ),
      labelH2: TextStyle(
        fontFamily: _baseFamily,
        fontWeight: FontWeight.w300,
        fontSize: 16,
        height: 1.4,
      ),
      labelTextDefault: TextStyle(
        fontFamily: _baseFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.2,
      ));

  @override
  ThemeExtension<AppTextsTheme> copyWith() {
    return AppTextsTheme._internal(
      labelH1: labelH1,
      labelH2: labelH2,
      labelTextDefault: labelTextDefault,
    );
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(
          covariant ThemeExtension<AppTextsTheme>? other, double t) =>
      this;
}
