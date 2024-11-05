import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/pages/search_page/custom_search_delegate.dart';
import 'package:flutter_todo/pages/search_page/data_item_model.dart';

class SearchPageDelegate extends CustomSearchDelegate<DataItemModel?> {
  SearchPageDelegate({
    String? hintText,
    required this.models,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  List<String> suggestions = [
    "Flutter",
    "Flutter开发7个建议，让你的工作效率飙升",
    "浅谈 Flutter 的并发和 isolates",
    "Flutter 技术实践",
    "Flutter 中如何优雅地使用弹框",
    "Flutter设计模式全面解析：单例模式",
    "Flutter Dart",
    "Flutter 状态管理",
    "Flutter大型项目架构：UI设计系统实现（二）",
    "Flutter大型项目架构：分层设计篇",
    "Dart 语法原来这么好玩儿"
  ];
  List<DataItemModel> models = [];

  /// 搜索结果
  List<DataItemModel> results = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Container(),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
        onTap: () {
          close(context, null);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            "assets/images/arrow.svg",
            height: 22,
            color: Colors.white,
          ),
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        DataItemModel item = results[index];
        return GestureDetector(
          onTap: () {
            close(context, item);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(10),
              // ),
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey,
              //       offset: Offset(0, 2.0),
              //       blurRadius: 8.0,
              //       spreadRadius: 0)
              // ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 120,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Image.asset(
                    item.icon ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.title}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF222222), fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${item.desc}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF666666), fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${item.readCount}人阅读",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF7A7A7A), fontSize: 12),
                          ),
                          Text(
                            "${item.createTime}",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xFF7A7A7A), fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: const Color(0xFFAFAFAF),
          height: 0.3,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = query.isEmpty
        ? []
        : suggestions
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList();
    if (suggestionList.isEmpty) return Container();
    return ListView.separated(
      itemBuilder: (context, index) {
        String name = suggestionList[index];
        int start = name.toLowerCase().indexOf(query.toLowerCase());
        String end = name.substring(start, start + query.length);
        List<String> spanStrings = name
            .toLowerCase()
            .replaceAll(end.toLowerCase(), "*${end.toLowerCase()}*")
            .split("*");
        List<TextSpan> spans = spanStrings
            .map((e) => (e.toLowerCase() == end.toLowerCase()
                ? TextSpan(
                    text: e,
                    style: const TextStyle(color: Colors.red, fontSize: 14))
                : TextSpan(
                    text: e,
                    style: const TextStyle(
                        color: Color(0xFF373737), fontSize: 14))))
            .toList();
        return InkWell(
          onTap: () {
            query = name;
            results = models
                .where((e) =>
                    (e.title?.toLowerCase().contains(name.toLowerCase()) ??
                        false) ||
                    (e.desc?.toLowerCase().contains(name.toLowerCase()) ??
                        false))
                .toList();
            showResults(context);
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/search.svg",
                  height: 16,
                  color: const Color(0xFF373737),
                ),
                const SizedBox(
                  width: 4,
                ),
                RichText(
                  text: TextSpan(children: spans),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: const Color(0xFFAFAFAF),
          height: 0.3,
        );
      },
    );
  }

  @override
  void onSubmit(BuildContext context, String text) {
    results = models
        .where((e) =>
            (e.title?.toLowerCase().contains(text.toLowerCase()) ?? false) ||
            (e.desc?.toLowerCase().contains(text.toLowerCase()) ?? false))
        .toList();
    showResults(context);
  }
}

