import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/url_launcher_util.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text("TestRoutePage"),
              onPressed: () {
                // 跳转到 SecondPage，传参方式和get请求很像
                MyRoutes.router
                    .navigateTo(context, MyRoutes.secondPage + "?title=hello")
                    .then((value) => print(value));
              },
            ),
            const SizedBox(
              height: 80,
            ),
            MaterialButton(
              child: const Text("文章地址"),
              onPressed: _launchUrl,
            ),
          ],
        ),
      ),
    );
  }

  final String _url =
      '__biz=Mzg2Mjg3Nzg3NA==&mid=2247483724&idx=1&sn=5a30947fa11f0cc8e94b7f6a9bb78a53&chksm=ce006091f977e987ae70707ba95d9f34523ee3164a3ffcd0a70fff9d7cee2b18616b3dd018e4&token=1501996251&lang=zh_CN#rd';

  Future<void> _launchUrl() async {
    await UrlLauncherUtil.openWXArticle(_url);
  }
}

class SecondPage extends StatelessWidget {
  String? title;

  SecondPage({Key? key, this.title = "第二个页面"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text(title ?? ""),
          onPressed: () {
            Navigator.pop(context, "SecondPage pop 参数");
          },
        ),
      ),
    );
  }
}
