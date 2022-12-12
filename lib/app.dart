import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/bottom_tab_page.dart';
import 'package:flutter_todo/pages/news_page.dart';
import 'package:flutter_todo/pages/test_async_page.dart';
import 'package:flutter_todo/pages/test_route_page.dart';

import 'main_page.dart';

abstract class IRouterProvider {
  void initRouter(FluroRouter router);
}

class MyRoutes {
  static FluroRouter router = FluroRouter();
  static String root = "/";
  static String tabPage = "/tabPage";
  static String newsPage = "/newsPage";
  static String testRoutePage = "/testRoutePage";
  static String secondPage = "/secondPage";
  static String testAsyncPage = "/testAsyncPage";

  static void configureRoutes() {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const Text("ROUTE WAS NOT FOUND !!!");
    });

    router.define(root, handler: Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return const MainPage();
    }));

    router.define(tabPage,
        handler: Handler(handlerFunc: (_, __) => const BottomTabPage()));

    router.define(newsPage,
        handler: Handler(handlerFunc: (_, params) => const NewsPage()));

    router.define(testRoutePage,
        handler: Handler(handlerFunc: (_, __) => TestRoutePage()));

    router.define(secondPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first ?? "";
      return SecondPage(
        title: title,
      );
    }));

    router.define(testAsyncPage,
        handler: Handler(handlerFunc: (_, __) => TestAsyncPage()));
  }
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    MyRoutes.configureRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 技术实践',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: MyRoutes.router.generator,
      initialRoute: MyRoutes.root,
    );
  }
}
