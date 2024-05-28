import 'package:flutter/material.dart';
import 'package:flutter_todo/resources/app_colors_theme.dart';
import 'package:flutter_todo/resources/app_dimensions_theme.dart';
import 'package:flutter_todo/resources/app_texts_theme.dart';

extension ThemeDataExtension on ThemeData {
  AppDimensionsTheme get appDimensions => extension<AppDimensionsTheme>()!;

  AppColorsTheme get appColors => extension<AppColorsTheme>()!;

  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}
