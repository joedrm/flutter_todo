import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

Future<void> main() async {
  // if (!kIsWeb) {
  //   if (kDebugMode) {
  //     print("Isolate.current = ${Isolate.current.debugName}");
  //   }
  //
  //   Isolate timerIsolate;
  //   final mainControlPort = ReceivePort()
  //     ..listen((message) {
  //       print("sending back to MainIsolate: $message");
  //     });
  //
  //   timerIsolate = await Isolate.spawn(
  //     timerTick,
  //     mainControlPort.sendPort,
  //     debugName: "TimerIsolate",
  //   );
  // }

  /// 去掉 url 中的 "#"
  // setPathUrlStrategy();

  runApp(App());
}

void timerTick(SendPort mainPort) async {
  print("${Isolate.current.debugName} started");
  Timer.periodic(const Duration(seconds: 1), (timer) {
    final ts = DateTime.now().toIso8601String();
    mainPort.send(ts);
  });
}
