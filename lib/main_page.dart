import 'package:flutter/material.dart';
import 'package:flutter_todo/app.dart';
import 'package:flutter_todo/pages/bottom_tab_page.dart';
import 'package:flutter_todo/pages/chrome_extension_page.dart';
import 'package:flutter_todo/pages/news_page.dart';
import 'package:flutter_todo/pages/test_async_page.dart';
import 'package:flutter_todo/pages/test_route_page.dart';
import 'package:flutter_todo/utils/fluro_navigator_util.dart';
import 'package:flutter_todo/utils/leancloud_util.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> pages = [
    {
      "title": "tab 页面",
      "page": const BottomTabPage(),
      "route": MyRoutes.tabPage
    },
    {"title": "新闻列表", "page": const NewsPage(), "route": MyRoutes.newsPage},
    {
      "title": "路由导航及传参",
      "page": TestRoutePage(),
      "route": MyRoutes.testRoutePage
    },
    {
      "title": "Flutter异步编程中Completer和compute的使用",
      "page": const TestAsyncPage(),
      "route": MyRoutes.testAsyncPage
    },
    {
      "title": "Chrome 扩展程序",
      "page": ChromeExtensionPage(),
      "route": MyRoutes.chromeExtensionPage
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
      // bottomNavigationBar: bottomBar(),
      body: ListView.separated(
          controller: ScrollController(),
          itemBuilder: (ctx, index) {
            Map<String, dynamic> data = pages[index];
            return GestureDetector(
              onTap: () => toPage(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 70,
                alignment: Alignment.centerLeft,
                child: Text(data["title"].toString()),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const Divider(
              height: 0.1,
              color: Color(0xff999999),
            );
          },
          itemCount: pages.length),
    );
  }

  toPage(int index) {
    Map<String, dynamic> data = pages[index];
    FluroNavigatorUtil.push(context, data["route"]);
    // NavigatorUtil.push(context, (data["page"] as Widget));
  }
}
