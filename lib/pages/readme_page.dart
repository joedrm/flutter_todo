import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:flutter_todo/utils/device_utils.dart';

class ReadmePage extends StatefulWidget {
  const ReadmePage({Key? key}) : super(key: key);

  @override
  State<ReadmePage> createState() => _ReadmePageState();
}

class _ReadmePageState extends State<ReadmePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Center(
        child: Container(
          // width: Device.isWeb
          //     ? MediaQuery.of(context).size.width * 0.5
          //     : MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "本项目是公众号 \"Flutter技术实践\" 系列文章里所实现的 Demo 效果。",
                style: TextStyle(color: Color(0xff010101), fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  js.context.callMethod(
                      'open', ["https://github.com/joedrm/flutter_todo"]);
                },
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: const Text(
                    "源码",
                    style: TextStyle(
                        color: Color(0xFF2131DB),
                        decoration: TextDecoration.underline,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "公众号",
                style: TextStyle(color: Color(0xff010101), fontSize: 16),
              ),
              Image.network(
                "https://s2.loli.net/2022/12/12/EWvyFX2LgiaeZ3d.jpg",
                fit: BoxFit.fill,
                width: 200,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   "加我微信，拉进群交流",
              //   style: TextStyle(color: Color(0xff010101), fontSize: 16),
              // ),
              // Image.network(
              //   "https://s2.loli.net/2024/03/25/t6qMd5HU3WxLuTl.jpg",
              //   fit: BoxFit.fill,
              //   width: 200,
              //   loadingBuilder: (BuildContext context, Widget child,
              //       ImageChunkEvent? loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return Center(
              //       child: CircularProgressIndicator(
              //         value: loadingProgress.expectedTotalBytes != null
              //             ? loadingProgress.cumulativeBytesLoaded /
              //                 loadingProgress.expectedTotalBytes!
              //             : null,
              //       ),
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
