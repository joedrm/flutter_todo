import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as devtools show log;
import 'dart:async' show Future, Stream;

extension Log on Object {
  void log() => devtools.log(toString());
}

class GenericWidgetPage extends StatefulWidget {
  const GenericWidgetPage({Key? key}) : super(key: key);

  @override
  State<GenericWidgetPage> createState() => _GenericWidgetPageState();
}

class _GenericWidgetPageState extends State<GenericWidgetPage> {
  double _progress = 0.0;
  bool _isLogout = false;
  Season _currentSeason = Season.spring;
  int _inputAge = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _logProgress();
  }

  _logProgress() async {
    final task1 = Future.delayed(Duration(minutes: 1), () => 'Result 1');

    var result = await performWithProgress(
      task: task1,
      callBack: (value) {
        print('\t $value');
        _progress = value / 60;
        setState(() {});
      },
    );
    _progress = 1.0;
    setState(() {});
    print('\tTask 3 result: $result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () async {
                  bool isSureLogOut = await showLogOutDialog(context);
                  print("isSureLogOut = $isSureLogOut");
                  setState(() {
                    _isLogout = isSureLogOut;
                  });
                },
                child: Text("是否退出登录？$_isLogout", style: TextStyle(fontSize: 22, color: Colors.blue),),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // TextButton(
              //   onPressed: () async {
              //     Season? _season = await _chooseSeason(
              //       context,
              //       Season.spring,
              //     );
              //     print("_season = $_season");
              //     setState(() {
              //       _currentSeason = _season ?? Season.spring;
              //     });
              //   },
              //   child: Text('选择季节：${_currentSeason.title}'),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // RichTextWidget(
              //   styleForAll:
              //       const TextStyle(fontSize: 12, color: Colors.black87),
              //   texts: [
              //     BaseText.plain(
              //       text: '欢迎来到我博客：',
              //     ),
              //     BaseText.link(
              //       text: 'https://juejin.cn/user/3491704658464014',
              //       onTapped: () {
              //         'Tapped'.log();
              //       },
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // CircularProgressIndicator(
              //   value: _progress,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // FadingNetworkImage(
              //   url:
              //       "https://i.pinimg.com/564x/8f/7e/60/8f7e60a821dcc000ee657d4fe5f18897.jpg",
              // ),

              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  int? _age = await _getAge(context);
                  print("_age = $_age");
                  setState(() {
                    _inputAge = _age ?? 1;
                  });
                },
                child: Text('输入年龄：$_inputAge', style: TextStyle(fontSize: 22, color: Colors.deepPurple),),
              ),

              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  _showCustomDialog();
                },
                child: Text('自定义 Dialog 内容', style: TextStyle(fontSize: 22, color: Colors.deepOrange),),
              ),

              // const SizedBox(
              //   height: 20,
              // ),
              // TextButton(
              //   onPressed: () {
              //     _showDialogWithCallBack((result) {
              //       // throw Exception("Something went wrong!");
              //
              //       print("Result: $result");
              //     });
              //   },
              //   child: Text('Dialog with call back'),
              // ),
              //
              // const SizedBox(
              //   height: 20,
              // ),
              // TextButton(
              //   onPressed: () async {
              //     bool? result = await _showAsyncDialog();
              //     print("Result: $result");
              //   },
              //   child: Text('Async Dialog'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialogWithCallBack(Function(bool) callBack) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                callBack(false);
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                callBack(true);
                Navigator.of(context).pop();
              },
              child: const Text("Sure"),
            )
          ],
        );
      },
    );
  }

  Future<bool?> _showAsyncDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sure"),
            )
          ],
        );
      },
    );
  }

  _showCustomDialog() {
    showDialog(
      context: context,
      // 设置背景透明度
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10),
                Text('Custom Dialog Title', style: TextStyle(fontSize: 20)),
                SizedBox(height: 16),
                Text('This is a custom dialog content.'),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  _showConfirmAlertDialog(){
    showDialog(
      context: context,
      // 设置背景透明度
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container();
      },
    );
  }
}

typedef DialogOptionBuilder<T> = Map<String, T> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys.map(
          (optionTitle) {
            final T value = options[optionTitle];
            return TextButton(
              onPressed: () {
                Navigator.of(context).pop(value);
              },
              child: Text(optionTitle),
            );
          },
        ).toList(),
      );
    },
  );
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: '退出登录',
    content: '确定要退出吗？',
    optionsBuilder: () => {
      '取消': false,
      '确定': true,
    },
  ).then(
    (value) => value ?? false,
  );
}

enum Season { spring, summer, autumn, winter }

extension SeasonTitle on Season {
  String get title {
    switch (this) {
      case Season.spring:
        return "春天";
      case Season.summer:
        return "夏天";
      case Season.autumn:
        return "秋天";
      case Season.winter:
        return "冬天";
    }
  }
}

Future<Season?> _chooseSeason(
  BuildContext context,
  Season currentSeason,
) async {
  return await showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        title: const Text('选择你喜欢的季节：'),
        actions: Season.values
            .map(
              (season) => CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(context).pop(season);
                },
                child: Text(season.title),
              ),
            )
            .toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.of(context).pop(currentSeason);
          },
          child: const Text('取消'),
        ),
      );
    },
  );
}

/// performWithProgress
Future<T> performWithProgress<T>({
  required Future<T> task,
  required Function(int) callBack,
}) {
  final stream = Stream<int>.periodic(
    const Duration(seconds: 1),
    (value) => value,
  );

  final subscription = stream.listen(
    (event) => callBack(event),
  );

  task.whenComplete(() {
    print('\n');
    subscription.cancel();
  });

  return task;
}

Future<int?> _getAge(BuildContext context) {
  final controller = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("How old are you?"),
          content: TextField(
              decoration: const InputDecoration(hintText: "e.g：22"),
              keyboardType: TextInputType.number,
              autofocus: true,
              maxLength: 3,
              controller: controller,
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.text.isEmpty) return newValue;
                  try {
                    final age = int.parse(newValue.text);
                    if (age > 120) return oldValue;
                    return newValue;
                  } catch (err) {
                    return oldValue;
                  }
                })
              ]),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  final age = int.parse(controller.text);
                  Navigator.of(context).pop(age);
                },
                child: const Text("Save"))
          ],
        );
      });
}
