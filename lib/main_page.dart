import 'package:flutter/material.dart';
import 'package:flutter_todo/app.dart';
import 'package:flutter_todo/language/generated/l10n.dart';
import 'package:flutter_todo/pages/app_download/app_download_page.dart';
import 'package:flutter_todo/pages/bottom_tab_page.dart';
import 'package:flutter_todo/pages/chrome_extension_page.dart';
import 'package:flutter_todo/pages/flexible_list_header_page.dart';
import 'package:flutter_todo/pages/news_page.dart';
import 'package:flutter_todo/pages/test_async_page.dart';
import 'package:flutter_todo/pages/test_language_page.dart';
import 'package:flutter_todo/pages/test_route_page.dart';
import 'package:flutter_todo/resources/styles/app_colors.dart';
import 'package:flutter_todo/utils/fluro_navigator_util.dart';
import 'package:flutter_todo/utils/leancloud_util.dart';
import 'dart:js' as js;

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
        }
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
      backgroundColor: AppColors.current.bgColor,
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView.separated(
                controller: ScrollController(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (ctx, index) {
                  Map<String, dynamic> data = pages[index];
                  return GestureDetector(
                    onTap: () => toPage(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 70,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      child: Text(
                        data["title"].toString(),
                        style: const TextStyle(
                            color: Color(0xFF2131DB),
                            decoration: TextDecoration.underline,
                            fontSize: 16),
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return Container(
                    height: 0.05,
                    color: const Color(0xff000000),
                  );
                },
                itemCount: pages.length),
            Positioned(
                bottom: 20,
                right: 20,
                child: GestureDetector(
                  onTap: (){
                    FluroNavigatorUtil.push(context, MyRoutes.readmePage);
                  },
                  child: Container(
                    height: 38,
                    color: const Color(0xFF2736D9),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: const Text(
                      "关于项目",
                      style: TextStyle(
                          color: Color(0xffe3e3e3),
                          fontSize: 12),
                    ),
                  ),
                ))
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
      js.context.callMethod('open', [path]);
    }
  }
}
