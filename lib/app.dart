import 'dart:developer';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/language/generated/l10n.dart';
import 'package:flutter_todo/pages/app_download/app_download_page.dart';
import 'package:flutter_todo/pages/bottom_tab_page.dart';
import 'package:flutter_todo/pages/chrome_extension_page.dart';
import 'package:flutter_todo/pages/dart_tips_page.dart';
import 'package:flutter_todo/pages/flexible_list_header_page.dart';
import 'package:flutter_todo/pages/news_page.dart';
import 'package:flutter_todo/pages/readme_page.dart';
import 'package:flutter_todo/pages/test_async_page.dart';
import 'package:flutter_todo/pages/test_language_page.dart';
import 'package:flutter_todo/pages/test_route_page.dart';
import 'package:flutter_todo/providers/app_language_provider.dart';
import 'package:flutter_todo/resources/styles/app_colors.dart';
import 'package:flutter_todo/resources/styles/app_themes.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';

abstract class IRouterProvider {
  void initRouter(FluroRouter router);
}

class MyRoutes {
  static FluroRouter router = FluroRouter();
  static String root = "/";
  static String tabPage = "/tab";
  static String newsPage = "/news";
  static String testRoutePage = "/route";
  static String secondPage = "/second";
  static String testAsyncPage = "/async";
  static String chromeExtensionPage = "/chromeExtension";
  static String flexibleListHeaderPage = "/flexibleListHeader";
  static String testLanguagePage = "/language";
  static String appDownloadPage = "/jianyue";
  static String readmePage = "/readme";
  static String dartTipsPage = '/tips';

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
        handler: Handler(handlerFunc: (_, __) => const TestAsyncPage()));

    router.define(chromeExtensionPage,
        handler: Handler(handlerFunc: (_, __) => ChromeExtensionPage()));

    router.define(flexibleListHeaderPage,
        handler:
            Handler(handlerFunc: (_, __) => const FlexibleListHeaderPage()));

    router.define(appDownloadPage,
        handler: Handler(handlerFunc: (_, __) => const AppDownloadPage()));

    router.define(testLanguagePage,
        handler: Handler(handlerFunc: (_, __) => const TestLanguagePage()));

    router.define(readmePage,
        handler: Handler(handlerFunc: (_, __) => const ReadmePage()));

    router.define(dartTipsPage,
        handler: Handler(handlerFunc: (_, __) => const DartTipsPage()));
  }
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key) {
    MyRoutes.configureRoutes();
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前系统所处的主题，来确定自定义颜色的值
    if (MediaQuery.platformBrightnessOf(context) == Brightness.dark) {
      AppThemeSetting.currentAppThemeType = AppThemeType.dark;
    } else {
      AppThemeSetting.currentAppThemeType = AppThemeType.light;
    }

    AppColors.of(context);



   return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return AppLanguageProvider();
        }),
      ],
      builder: (BuildContext context, Widget? child) {
        LanguageCode languageCode =
            context.watch<AppLanguageProvider>().languageCode;
        return MaterialApp(
          title: 'Flutter 技术实践',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: MyRoutes.router.generator,
          initialRoute: MyRoutes.root,
          debugShowCheckedModeBanner: false,
          supportedLocales: S.delegate.supportedLocales,
          locale: Locale.fromSubtags(languageCode: languageCode.name),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            Locale currentLocale =
            Locale.fromSubtags(languageCode: locale?.languageCode ?? "en");
            return supportedLocales.contains(currentLocale)
                ? currentLocale
                : const Locale.fromSubtags(languageCode: "en");
          },
        );
      },
    );
  }
}
