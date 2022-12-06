import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../app.dart';

/// fluro的路由跳转工具类
class FluroNavigatorUtil {
  
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    MyRoutes.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.cupertino);
  }

  static pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    MyRoutes.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.cupertino).then((result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  /// 返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  static void backToRoot(BuildContext context){
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  static void popWithDelta(BuildContext context, {int delta = 1}) {
    int count = 0;
    Navigator.of(context).popUntil((route) {
      count++;
      return count > delta;
    });
  }
}
