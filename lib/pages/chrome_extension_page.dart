import 'package:flutter/material.dart';
import 'package:flutter_todo/utils/url_launcher_util.dart';

// import 'package:url_launcher/url_launcher.dart';
import '../app.dart';

import 'dart:ui' as ui;

class ChromeExtensionPage extends StatelessWidget {
  ChromeExtensionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: const Text("下载 flutter_todo 的 Chrome 扩展程序"),
          onPressed: _launchUrl,
        ),
      ),
    );
  }

  final String _url =
      'assets/assets/file/flutter_todo_extension.zip';

  Future<void> _launchUrl() async {
    Uri uri = Uri(
        scheme: 'https',
        path: _url,
        host: "flutter.nnxkcloud.com");
    await UrlLauncherUtil.openUri(uri);
  }
}
