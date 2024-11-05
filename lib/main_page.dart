import 'package:flutter/material.dart';
import 'package:flutter_todo/app.dart';
import 'package:flutter_todo/language/generated/l10n.dart';
import 'package:flutter_todo/resources/app_colors_theme.dart';
import 'package:flutter_todo/resources/theme_data_extension.dart';
import 'package:flutter_todo/utils/fluro_navigator_util.dart';
import 'package:flutter_todo/utils/leancloud_util.dart';
// import 'dart:js' as js;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> get pages => [
        {"title": S.of(context).nav_tab, "route": MyRoutes.tabPage},
        {"title": S.of(context).nav_news, "route": MyRoutes.newsPage},
        {"title": S.of(context).nav_route, "route": MyRoutes.testRoutePage},
        {"title": S.of(context).nav_completer, "route": MyRoutes.testAsyncPage},
        {
          "title": S.of(context).nav_extension,
          "route": MyRoutes.chromeExtensionPage
        },
        {
          "title": "Flexible ListView Header",
          "route": MyRoutes.flexibleListHeaderPage
        },
        {"title": S.of(context).nav_intl, "route": MyRoutes.testLanguagePage},
        {"title": S.of(context).ftool, "route": "https://ftool.nnxkcloud.com"},
        {"title": S.of(context).tips, "route": MyRoutes.dartTipsPage},
        {
          "title": S.of(context).custom_painter,
          "route": MyRoutes.customPainter
        },
        {"title": "BuildContext", "route": MyRoutes.buildContext},
        {"title": "InheritedWidget", "route": MyRoutes.inheritedWidget},
        {
          "title": S.of(context).generic_widget,
          "route": MyRoutes.genericWidgetPage
        },

        // {"title": S.of(context).scroll_menu, "route": MyRoutes.scrollMenuPage},
        {
          "title": S.of(context).house_price_index,
          "route": MyRoutes.housePriceIndexPage
        },
        {"title": 'TextField Attention', "route": MyRoutes.textFieldPage},
        {"title": 'Good List', "route": MyRoutes.goodListPage},
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

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final AppColorsTheme myColors = Theme.of(context).extension<AppColorsTheme>()!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                FluroNavigatorUtil.push(context, MyRoutes.readmePage);
                // _showFloatingButton();
              },
              child: Container(
                color: const Color(0xFF2736D9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                key: _key,
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
    String path = data["route"];
    if (path.contains("https") || path.contains("http")) {
      // js.context.callMethod('open', [path]);
    } else {
      FluroNavigatorUtil.push(context, path);
    }
  }

  OverlayEntry? _entry;

  void _showFloatingButton() {
    // final overlay = Overlay.of(context).context.findRenderObject();
    if (_entry == null) {
      _entry = OverlayEntry(
        builder: (context) => Positioned(
          // bottom: 50,
          // right: 50,
          top: 50,
          left: 20,
          child: FloatingActionButton(
              onPressed: () {
                _entry?.remove();
                _entry = null;
              },
              child: const Icon(Icons.add)),
        ),
      );

      Overlay.of(context).insert(_entry!);
    }
  }
}
