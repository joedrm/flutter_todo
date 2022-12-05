import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
/// 适配Web，使用 universal_platform 解决：Unsupported operation: Platform._operatingSystem 报错问题
/// 参考：https://github.com/flutter/flutter/issues/36126#issuecomment-596215587
class Device {
  static bool get isDesktop => !isWeb && (isWindows || isLinux || isMacOS);

  static bool get isMobile => isAndroid || isIOS;

  static bool get isWeb => UniversalPlatform.isWeb;

  static bool get isWindows => UniversalPlatform.isWindows;

  static bool get isLinux => UniversalPlatform.isLinux;

  static bool get isMacOS => UniversalPlatform.isMacOS;

  static bool get isAndroid => isWeb ? false : UniversalPlatform.isAndroid;

  static bool get isFuchsia => UniversalPlatform.isFuchsia;

  static bool get isIOS => UniversalPlatform.isIOS;

  static bool jumpPlatform() {
    if (isWeb) return false;

    if (UniversalPlatform.isMacOS ||
        UniversalPlatform.isWindows ||
        UniversalPlatform.isFuchsia ||
        UniversalPlatform.isWindows) {
      return true;
    }
    return false;
  }
}
