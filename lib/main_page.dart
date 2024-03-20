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

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> get pages => [
        {
          "title": S.of(context).nav_tab,
          "page": const BottomTabPage(),
          "route": MyRoutes.tabPage
        },
        {
          "title": S.of(context).nav_news,
          "page": const NewsPage(),
          "route": MyRoutes.newsPage
        },
        {
          "title": S.of(context).nav_route,
          "page": TestRoutePage(),
          "route": MyRoutes.testRoutePage
        },
        {
          "title": S.of(context).nav_completer,
          "page": const TestAsyncPage(),
          "route": MyRoutes.testAsyncPage
        },
        {
          "title": S.of(context).nav_extension,
          "page": ChromeExtensionPage(),
          "route": MyRoutes.chromeExtensionPage
        },
        {
          "title": "Flexible ListView Header",
          "page": const FlexibleListHeaderPage(),
          "route": MyRoutes.flexibleListHeaderPage
        },
        {
          "title": S.of(context).nav_intl,
          "page": const TestLanguagePage(),
          "route": MyRoutes.testLanguagePage
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
                color: Colors.transparent,
                child: Text(
                  data["title"].toString(),
                  style: TextStyle(color: AppColors.current.primaryTextColor),
                ),
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
