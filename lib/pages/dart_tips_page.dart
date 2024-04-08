import 'package:flutter/material.dart';
import 'package:flutter_todo/helper/row_spacing.dart';
import 'package:flutter_todo/helper/safe_list.dart';
import 'package:flutter_todo/pages/test_async_page.dart';

class DartTipsPage extends StatefulWidget {
  const DartTipsPage({Key? key}) : super(key: key);

  @override
  State<DartTipsPage> createState() => _DartTipsPageState();
}

class _DartTipsPageState extends State<DartTipsPage> {
  @override
  void initState() {
    super.initState();

    String text = "hello";
    print(text.capitalize()); // 输出 "Hello"

    _click.delayedCall(const Duration(seconds: 1));

    List<int> numbers = [1, 2, 3, 4, 5];
    // print(numbers[5]);

    // print(numbers?.elementAt(5));

    const notFound = 'Value Not Found';
    const defaultString = '';

    final SafeList<String> myList = SafeList(
      defaultValue: defaultString,
      absentValue: notFound,
      values: ['Flutter', 'iOS', 'Android'],
    );

    print(myList[0]); // Flutter
    print(myList[1]); // iOS
    print(myList[2]); // Android
    print(myList[3]); // Value Not Found

    myList.length = 5;
    print(myList[4]); // ''

    myList.length = 0;
    print(myList.first); // Value Not Found
    print(myList.last); // Value Not Found

    _getImageAspectRatio(); // 2.8160919540229883
  }

  _getImageAspectRatio() async {
    Image wxIcon = Image.asset("assets/images/wx_icon.png");
    var aspectRatio = await wxIcon.getAspectRatio();
    print(aspectRatio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child:
        Container(
          color: Colors.yellow,
          height: 100,
          width: 340,
          child: RowWithSpacing(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            existLeadingSpace: true,
            spacing: 40,
            children: const [
              Text("Flutter", style: TextStyle(color: Colors.blue),),
              Text("ReactNative", style: TextStyle(color: Colors.red),),
              Text("uni-app", style: TextStyle(color: Colors.green),),
            ],
          ),
        ),
      ),
    );
  }


  _click() {
    print("delayedCall");
  }
}

extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1);
  }
}

extension on VoidCallback {
  Future<void> delayedCall(
    Duration duration,
  ) =>
      Future<void>.delayed(duration, this);
}


