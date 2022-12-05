import 'dart:io';
import 'package:flutter/material.dart';
import 'animation_util.dart';

class NavigatorUtil {
  static Future<T?> push<T extends Object>(
      BuildContext context, Widget scene) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
    return result;
  }

  static Future<T?> pushTransitionLR<T extends Object>(
      BuildContext context, Widget scene) async {
    if (Platform.isIOS) {
      return push(context, scene);
    }

    return await Navigator.push<T>(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation<double> animation, Animation<double> secondaryAnimation) {
          // 跳转的路由对象
          return scene;
        }, transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          return AnimationUtil.createTransitionLR(animation, child);
        }));
  }

  static Future<T?> pushTransitionTB<T extends Object>(
      BuildContext context, Widget scene) async {
    return await Navigator.push<T>(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              // 跳转的路由对象
              return scene;
            },
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return AnimationUtil.createTransitionTB(animation, child);
            }));
  }

  static Future<T?> pushTransitionFade<T extends Object>(
      BuildContext context, Widget scene) async {
    return await Navigator.push<T>(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              // 跳转的路由对象
              return scene;
            },
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return AnimationUtil.fadeTransition(animation, child);
            }));
  }

  static pop<T extends Object>(BuildContext context, {required T returnData}) {
    Navigator.of(context).pop(returnData);
  }
}
