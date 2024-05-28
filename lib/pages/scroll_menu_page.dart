import 'package:flutter/material.dart';
import 'dart:math';

class ScrollMenuPage extends StatefulWidget {
  const ScrollMenuPage({Key? key}) : super(key: key);

  @override
  State<ScrollMenuPage> createState() => _ScrollMenuPageState();
}

class _ScrollMenuPageState extends State<ScrollMenuPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _menuData = [
    {"title": "总览", "items": []},
    {
      "title": "第一天",
      "items": [
        {"name": "项目一"},
        {"name": "项目二"},
        {"name": "项目三"},
        {"name": "项目四"},
        {"name": "项目五"},
        {"name": "项目六"}
      ]
    },
    {
      "title": "第二天",
      "items": [
        {"name": "项目一"},
        {"name": "项目二"},
        {"name": "项目三"},
        {"name": "项目四"},
        {"name": "项目五"},
        {"name": "项目六"}
      ]
    },
    {
      "title": "第三天",
      "items": [
        {"name": "项目一"},
        {"name": "项目二"},
        {"name": "项目三"},
        {"name": "项目四"}
      ]
    },
    {
      "title": "第四天",
      "items": [
        {"name": "项目一"}
      ]
    },
    {
      "title": "第五天",
      "items": [
        {"name": "项目一"},
        {"name": "项目二"},
        {"name": "项目三"},
        {"name": "项目四"},
        {"name": "项目五"}
      ]
    },
    {
      "title": "第六天",
      "items": [
        {"name": "项目一"}
      ]
    },
  ];

  final double _headerHeight = 44;
  final double _itemHeaderHeight = 65;
  final double _itemSpacing = 10;
  double _listHeight = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<double> arr = [];
    int lastIndex = 0;

    for (var i = 0; i < _menuData.length; i++) {
      List items = _menuData[i]["items"];
      double cardHeight = _itemHeaderHeight;
      for (Map<String, dynamic> item in items) {
        Random random = Random();
        int randomNumber = random.nextInt(40) + 40;
        item["height"] = randomNumber.toString();
        cardHeight += randomNumber;
      }

      if (items.isEmpty) cardHeight = 0;
      if (i == 0) cardHeight = 20;
      // if (i == _menuData.length - 1) {
      //   double height80 = MediaQuery.of(context).size.height * 0.8;
      //   if (cardHeight < height80) {
      //     double addHeight = height80 - cardHeight;
      //     // widgets.add(SizedBox(height: addHeight,));
      //     // double originalHeight = _menuData[index]["cardHeight"];
      //     cardHeight = (cardHeight + addHeight);
      //   }
      // }
      _menuData[i]["cardHeight"] = cardHeight;
      _listHeight += cardHeight;
      if (i - 1 >= 0) {
        double _countHeight = 0;
        for (var j = 0; j < i ; j++) {
          _countHeight += _menuData[j]["cardHeight"];
        }
        if (i == 1) {
          _countHeight = 20;

        }
        print("i = $i; _countHeight = $_countHeight; cardHeight = $cardHeight");
        _menuData[i]["distanceToTop"] = _countHeight;
      }else{
        _menuData[i]["distanceToTop"] = 0;
      }

      double distanceToTop =
          double.parse(_menuData[i]["distanceToTop"].toString());
      arr.add(distanceToTop);
      // lastIndex = i;
    }
    // print(arr);
    // print(_menuData);

    _scrollController.addListener(() {
      Size screenSize = MediaQuery.of(context).size;
      double offset = _scrollController.offset;
      double offset60 = offset + screenSize.height * 0.6;
      double scrollPosition = _scrollController.position.pixels;
      double listHeight = _scrollController.position.maxScrollExtent;
      // double min = findClosestElement(arr, offset60);
      // print("scrollPosition = $scrollPosition; listHeight = $listHeight; _listHeight = $_listHeight;offset60 = $offset60; ");
      // print(
      //     "offset = $offset; offset60 = $offset60; scrollPosition = $scrollPosition; screenSize.height * 0.6 = ${screenSize.height * 0.6};");

      if (offset - 20 < 0) {
        _selectedIndex = 0;
        setState(() {});
        return;
      }

      if (offset - 20 == 0) {
        _selectedIndex = 1;
        setState(() {});
        return;
      }


      double minDiff = offset60 - arr[0];
      int index = 1;
      for (int i = 1; i < arr.length; i++) {
        double diff = offset60 - arr[i];
        // print(
        //     "offset = $offset; offset60 = $offset60; arr[$i] = ${arr[i]}");
        if (diff > 0 && diff < minDiff) {
          minDiff = diff;
          index = i;
        }
      }

      print(index);
      // print(offset);
      // print(_menuData[index - 1]["distanceToTop"] + _headerHeight);
      if (index > 0 && offset > _menuData[index - 1]["distanceToTop"]) {
        _selectedIndex = index;
      }else{
        _selectedIndex = index - 1;
      }
      setState(() {});
    });
  }

  double findClosestElement(List<double> arr, double target) {
    double minDiff = arr.isNotEmpty ? target - arr[0] : double.infinity;
    //print("target = $target");
    double? closestElement = arr.isNotEmpty ? arr[0] : null;
    for (int i = 1; i < arr.length; i++) {
      double diff = target - arr[i]; // (arr[i] - target).abs();
      if (diff > 0 && diff < minDiff) {
        minDiff = diff;
        closestElement = arr[i];
      }
    }
    return closestElement ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // print(screenSize);

    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              width: screenSize.width,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    Map<String, dynamic> data = _menuData[index];
                    return GestureDetector(
                      onTap: () {
                        // _selectedIndex = index;
                        if (index == 0) {
                          _scrollController.animateTo(0,
                              duration: const Duration(milliseconds: 10),
                              curve: Curves.bounceIn);
                          setState(() {});
                          return;
                        }

                        // if (index == 1) {
                        //   _scrollController.animateTo(20,
                        //       duration: const Duration(milliseconds: 10),
                        //       curve: Curves.bounceIn);
                        //   setState(() {});
                        //   return;
                        // }

                        // if (index == _menuData.length - 1) {
                        //   double height80 = MediaQuery.of(context).size.height * 0.8;
                        //   double cardHeight = _menuData[_menuData.length - 1]["cardHeight"];
                        //   if (cardHeight < height80) {
                        //     double addHeight = height80 - cardHeight;
                        //     _menuData[index]["cardHeight"] = addHeight;
                        //   }
                        // }

                        double offset = 0;
                        for (var i = 0; i < _menuData.length; i++) {
                          if (i < index) {
                            offset += _menuData[i]["cardHeight"];
                          }
                        }
                        // print("offset = $offset; index = $index");
                        _scrollController.animateTo(offset,
                            duration: const Duration(milliseconds: 10),
                            curve: Curves.bounceIn);
                        setState(() {});
                      },
                      child: Container(
                        height: _headerHeight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? const Color(0xFF656D73)
                              : const Color(0xffE3E6E8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Text(
                          data["title"].toString(),
                          style: TextStyle(
                              color: _selectedIndex == index
                                  ? const Color(0xFFFCFEFF)
                                  : const Color(0xFF656D73),
                              fontSize: 16),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 0.05,
                      width: 10,
                      // color: const Color(0xff666666),
                    );
                  },
                  itemCount: _menuData.length),
            ),
            Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: (ctx, index) {
                      Map<String, dynamic> data = _menuData[index];
                      List items = data["items"];
                      if (items.isEmpty) return const SizedBox.shrink();
                      List<Widget> widgets = items
                          .map((e) {
                            bool isLast =
                                (items.length - 1) == (items.indexOf(e));
                            return Container(
                              height: double.parse(e["height"]),
                              padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                  color: Color(0xffffffff),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  e["name"] +
                                      "(height: ${double.parse(e["height"])})",
                                  style: const TextStyle(
                                      color: Color(0xFF959FA6), fontSize: 14),
                                ),
                              ),
                            );
                          })
                          .cast<Widget>()
                          .toList();

                      if (index == _menuData.length - 1) {
                        double height80 = MediaQuery.of(context).size.height * 0.8;
                        if (data["cardHeight"] < height80) {
                          double addHeight = height80 - data["cardHeight"];
                          widgets.add(SizedBox(height: addHeight,));
                          double originalHeight = _menuData[index]["cardHeight"];
                          // _menuData[index]["cardHeight"] = (originalHeight + addHeight);
                          // print("originalHeight = $originalHeight; addHeight = $addHeight; _menuData[index] = ${_menuData[index]}");
                        }
                      }

                      return Column(
                        children: [
                          Container(
                            height: _itemHeaderHeight,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            // color: Colors.yellow,
                            child: Text(
                              data["title"].toString(),
                              style: const TextStyle(
                                  color: Color(0xFF303940),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: widgets,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox.shrink();
                      Map<String, dynamic> data = _menuData[index];
                      List items = data["items"];
                      if (items.isEmpty) return const SizedBox.shrink();
                      return SizedBox(
                        height: _itemSpacing,
                        // color: const Color(0xff666666),
                      );
                    },
                    itemCount: _menuData.length))
          ],
        ),
      ),
    );
  }
}