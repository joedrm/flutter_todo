import 'package:flutter/material.dart';
import 'package:flutter_todo/app.dart';
import 'package:flutter_todo/language/generated/l10n.dart';
import 'package:flutter_todo/utils/fluro_navigator_util.dart';
import 'package:flutter_todo/utils/leancloud_util.dart';
// import 'dart:js' as js;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

enum PageType { native, web }

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> get pages => [
        {
          "title": S.of(context).nav_tab,
          "type": PageType.native,
          "route": MyRoutes.tabPage
        },
        {
          "title": S.of(context).nav_news,
          "type": PageType.native,
          "route": MyRoutes.newsPage
        },
        {
          "title": S.of(context).nav_route,
          "type": PageType.native,
          "route": MyRoutes.testRoutePage
        },
        {
          "title": S.of(context).nav_completer,
          "type": PageType.native,
          "route": MyRoutes.testAsyncPage
        },
        {
          "title": S.of(context).nav_extension,
          "type": PageType.native,
          "route": MyRoutes.chromeExtensionPage
        },
        {
          "title": "Flexible ListView Header",
          "type": PageType.native,
          "route": MyRoutes.flexibleListHeaderPage
        },
        {
          "title": S.of(context).nav_intl,
          "type": PageType.native,
          "route": MyRoutes.testLanguagePage
        },
        {
          "title": S.of(context).ftool,
          "type": PageType.web,
          "route": "https://ftool.nnxkcloud.com"
        },
        {
          "title": S.of(context).tips,
          "type": PageType.native,
          "route": MyRoutes.dartTipsPage
        },
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LeanCloudUtil.initSDK();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                FluroNavigatorUtil.push(context, MyRoutes.readmePage);
              },
              child: Container(
                color: const Color(0xFF2736D9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).about_project,
                      style: const TextStyle(
                          color: Color(0xffFFFFFF), fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  controller: ScrollController(),
                  itemBuilder: (ctx, index) {
                    Map<String, dynamic> data = pages[index];
                    return GestureDetector(
                      onTap: () => toPage(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        // height: 50,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Text(
                          data["title"].toString(),
                          style: const TextStyle(
                              color: Color(0xFF2131DB),
                              decoration: TextDecoration.underline,
                              fontSize: 18),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return Container(
                      height: 0.05,
                      // color: const Color(0xff666666),
                    );
                  },
                  itemCount: pages.length),
            ),
            // Positioned(
            //     bottom: 20,
            //     right: 20,
            //     child: GestureDetector(
            //       onTap: (){
            //         FluroNavigatorUtil.push(context, MyRoutes.readmePage);
            //       },
            //       child: Container(
            //         height: 38,
            //         color: const Color(0xFF2736D9),
            //         alignment: Alignment.center,
            //         padding: const EdgeInsets.symmetric(horizontal: 14),
            //         child: const Text(
            //           "关于项目",
            //           style: TextStyle(
            //               color: Color(0xffe3e3e3),
            //               fontSize: 12),
            //         ),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }

  toPage(int index) {
    Map<String, dynamic> data = pages[index];
    PageType pageType = data["type"];
    String path = data["route"];
    if (pageType == PageType.native) {
      FluroNavigatorUtil.push(context, path);
    } else {
      // js.context.callMethod('open', [path]);
    }
  }
}
