import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../app.dart';

import 'dart:ui' as ui;

class TestRoutePage extends StatelessWidget {
  TestRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              child: const Text("TestRoutePage"),
              onPressed: () {
                // 跳转到 SecondPage，传参方式和get请求很像
                MyRoutes.router
                    .navigateTo(context, MyRoutes.secondPage + "?title=hello")
                    .then((value) => print(value));
              },
            ),
            // MaterialButton(
            //   child: const Text("文章地址"),
            //   onPressed: _launchUrl,
            // ),
          ],
        ),
      ),
    );
  }

  final Uri _url = Uri.parse(
      'https://mp.weixin.qq.com/s?__biz=Mzg2Mjg3Nzg3NA==&mid=2247483724&idx=1&sn=5a30947fa11f0cc8e94b7f6a9bb78a53&chksm=ce006091f977e987ae70707ba95d9f34523ee3164a3ffcd0a70fff9d7cee2b18616b3dd018e4&token=1501996251&lang=zh_CN#rd');

  Future<void> _launchUrl() async {
    // if (!await launchUrl(_url)) {
    //   throw 'Could not launch $_url';
    // }
  }
}

class SecondPage extends StatelessWidget {
  String? title;

  SecondPage({Key? key, this.title = "第二个页面"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text(title ?? ""),
          onPressed: () {
            Navigator.pop(context, "SecondPage pop 参数");
          },
        ),
      ),
    );
  }
}
