import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/device_utils.dart';

class AppDownloadPage extends StatefulWidget {
  const AppDownloadPage({Key? key}) : super(key: key);

  @override
  State<AppDownloadPage> createState() => _AppDownloadPageState();
}

class _AppDownloadPageState extends State<AppDownloadPage> {
  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    double width = screenW;
    if (Device.isWeb && screenW > 1000) width = screenW * 0.5;
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

        ],
      ),
    );
  }
}
