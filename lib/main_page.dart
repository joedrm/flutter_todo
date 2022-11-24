import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/favorite/favorite_page.dart';
import 'package:flutter_todo/pages/home/home_page.dart';
import 'package:flutter_todo/pages/search/search_page.dart';
import 'package:flutter_todo/pages/setting/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  List<Widget> pages = [];
  final PageController _pageController = PageController();
  int selectedTabIndex = 0;
  final List<String> _appBarTitles = ['首页', '搜索', '收藏', '设置'];
  static const double iconWH = 26.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      const HomePage(),
      const SearchPage(),
      const FavoritePage(),
      const SettingPage(),
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  getImage(name, {bool isSelected = true}) => Image.asset(
        "assets/images/tabs/" + name + (isSelected ? ".png" : "_normal.png"),
        height: iconWH,
        width: iconWH,
      );

  List get tabImages => [
        [
          getImage("home", isSelected: false),
          getImage("home"),
        ],
        [
          getImage("search", isSelected: false),
          getImage("search"),
        ],
        [
          getImage("favorite", isSelected: false),
          getImage("favorite"),
        ],
        [
          getImage("setting", isSelected: false),
          getImage("setting"),
        ]
      ];

  Widget _buildBottomItem(String title, int index) {
    Color color = (selectedTabIndex == index)
        ? const Color(0xFF2D2D2D)
        : const Color(0xFFCCCCCC);
    Widget img =
        (selectedTabIndex == index) ? tabImages[index][1] : tabImages[index][0];
    return Expanded(
      child: FlatButton(
          highlightColor: Colors.white,
          splashColor: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: img,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    title,
                    key: Key(title),
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                ),
              ]),
          onPressed: () {
            _pageController.jumpToPage(index);
          }),
    );
  }

  Widget bottomBar() {
    List<Widget> tabs = [];
    for (var i = 0; i < _appBarTitles.length; i++) {
      tabs.add(_buildBottomItem(_appBarTitles[i], i));
    }
    return Container(
      color: Colors.white,
      child: SafeArea(
          bottom: true,
          //   maintainBottomViewPadding: false,
          child: SizedBox(
              height: 66,
              child: Card(
                  color: Colors.white,
                  elevation: 0.1,
                  shape: const RoundedRectangleBorder(),
                  margin: const EdgeInsets.all(0.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Divider(color: Color(0xFFE0E0E0), height: 0.5),
                        Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: tabs),
                        )
                      ])))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: pages,
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
      ),
    );
  }

  void onPageChanged(int page) {
    selectedTabIndex = page;
    setState(() {});
  }
}
