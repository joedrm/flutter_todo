import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/resources/flutter_view_extension.dart';

class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  final double radiusCommitButton;
  final EdgeInsets paddingOrderList;

  const AppDimensionsTheme._internal({
    required this.radiusCommitButton,
    required this.paddingOrderList,
  });

  // factory AppDimensionsTheme.main() => const AppDimensionsTheme._internal(
  //       radiusCommitButton: flutterView.isSmallSmartphone ? 8 : 16,
  //       paddingOrderList: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //     );

  factory AppDimensionsTheme.main(FlutterView flutterView) =>
      AppDimensionsTheme._internal(
        radiusCommitButton: flutterView.isSmallSmartphone ? 8 : 16,
        // <- responsive here!
        paddingOrderList:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() {
    return AppDimensionsTheme._internal(
      radiusCommitButton: radiusCommitButton,
      paddingOrderList: paddingOrderList,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
          covariant ThemeExtension<AppDimensionsTheme>? other, double t) =>
      this;
}
