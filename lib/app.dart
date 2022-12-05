import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/bottom_tab_page.dart';
import 'package:flutter_todo/pages/news_page.dart';

import 'main_page.dart';

class Application {
  static FluroRouter router = FluroRouter();
}

abstract class IRouterProvider {
  void initRouter(FluroRouter router);
}

class MyRoutes {
  static String root = "/";
  static String tabPage = "/tabPage";
  static String newsPage = "/newsPage";

  static final List<IRouterProvider> _listRouter = [];

  static void configureRoutes(FluroRouter router) {
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
        handler: Handler(handlerFunc: (_, __) => const NewsPage()));

    // _listRouter.clear();
    //
    // /// 初始化路由
    // _listRouter.forEach((routerProvider) {
    //   routerProvider.initRouter(router);
    // });
  }
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    MyRoutes.configureRoutes(Application.router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
      initialRoute: MyRoutes.root,
    );
  }
}
