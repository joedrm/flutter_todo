import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {

  static const _colorB0B0B0 = Color(0xFFB0B0B0);
  static const _colorEFEFEF = Color(0xFFEFEFEF);
  static const _color333333 = Color(0xFF333333);


  static const _color6C6C6C = Color(0xFF6C6C6C);
  static const _color7D7D7D = Color(0xFF7d7d7d);
  static const _color676767 = Color(0xFF676767);

  // 页面中真正使用的颜色名称
  final Color backgroundDefault;
  final Color backgroundInput;
  final Color textDefault;

  // 私有的构造函数
  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.textDefault,
  });

  // 浅色主题工厂方法
  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
        backgroundDefault: _colorB0B0B0,
        backgroundInput: _colorEFEFEF,
        textDefault: _color333333);
  }

  // 暗色主题工厂方法
  factory AppColorsTheme.dark() {
    return const AppColorsTheme._internal(
        backgroundDefault: _color6C6C6C,
        backgroundInput: _color7D7D7D,
        textDefault: _color676767);
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
          covariant ThemeExtension<AppColorsTheme>? other, double t) =>
      this;
}
