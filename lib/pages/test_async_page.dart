import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show File, Platform;
import 'dart:typed_data' show Uint8List;
import 'dart:async' show Completer;
import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;
// import 'package:image_picker/image_picker.dart';

class TestAsyncPage extends StatefulWidget {
  const TestAsyncPage({Key? key}) : super(key: key);

  @override
  _TestAsyncPageState createState() => _TestAsyncPageState();
}

class _TestAsyncPageState extends State<TestAsyncPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();

    if (kIsWeb) {
      // 运行在Web上
    } else if (Platform.isAndroid) {
      // 运行在Android设备上
    } else if (Platform.isIOS) {
      // 运行在iOS设备上
    } else if (Platform.isMacOS) {
      // 运行在Mac设备上
    } else if (Platform.isWindows) {
      // 运行在Windows设备上
    } else if (Platform.isLinux) {
      // 运行在Linux设备上
    } else {}
  }

  test() async {
    int result = await doAction();
    print("result: $result");

    String? result2 = await AsyncOperation<String>().doOperation();
    print("result2: $result2");

    var aspectRatio = await Image.asset("assets/images/tabs/home_normal.png")
        .getAspectRatio();
    print("aspectRatio: $aspectRatio");

    await ViewUtil.initFinish();

    ///下面可以使用加载弹窗等
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<int> doAction() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      print("doAction");
    });
    return 1;
  }

  Future<void> testCompute() async {
    final Response<String> response = await Dio().request<String>("", data: {});
    try {
      final String data = response.data.toString();

      /// 使用compute条件：数据大于10KB（粗略使用10 * 1024）
      /// 主要目的减少不必要的性能开销
      final bool isCompute = data.length > 10 * 1024;
      final Map<String, dynamic> _map =
          isCompute ? await compute(parseData, data) : parseData(data);
      debugPrint("data: $_map");
    } catch (e) {
      debugPrint("error: ${e.toString()}");
    }
  }

  Map<String, dynamic> parseData(String data) {
    return json.decode(data) as Map<String, dynamic>;
  }
}

class AsyncOperation<T> {
  Completer<T>? _completer;

  Future<T>? doOperation() {
    _startOperation();
    // 立即向调用方回传completer的future对象，不会等complete方法的调用
    _completer ??= Completer<T>();
    return _completer!.future;
  }

  // 此处执行是耗时的异步操作
  _startOperation() {
    // 模拟执行耗时操作
    Future.delayed(const Duration(milliseconds: 300), () {
      // 模拟执行完成
      _finishOperation("执行完成");
    }).catchError((err) => _errorHappened(err));
  }

  // 异步操作执行完成时调用此方法，返回结果
  _finishOperation(result) {
    if (_completer != null) {
      _completer!.complete(result);
      _completer = null;
    }
  }

  // 异步操作执行出错调用此方法
  _errorHappened(error) {
    if (_completer != null) {
      _completer!.completeError(error);
      _completer = null;
    }
  }
}

extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() {
    final completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final aspectRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.image.dispose();
          completer.complete(aspectRatio);
        },
      ),
    );
    return completer.future;
  }
}

class ViewUtil {
  static Future<void> initFinish() async {
    Completer<void> completer = Completer();
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        completer.complete();
      });
    }
    return completer.future;
  }
}

// class ImagePickerUtil {
//   static Future<File> openImagePicker(BuildContext context) async {
//     Completer<File> completer = Completer<File>();
//     ImagePicker.pickImage(
//       source: ImageSource.camera,
//     ).then((value) {
//       completer.complete(value);
//     }).catchError((err) {
//       completer.completeError(err);
//     });
//     return completer.future;
//   }
// }
