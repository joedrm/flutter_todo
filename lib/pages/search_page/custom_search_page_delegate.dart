import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_todo/pages/search_page/data_item_model.dart';
import 'package:flutter_todo/pages/search_page/search_item_widget.dart';

class CustomSearchPageDelegate extends SearchDelegate<DataItemModel> {
  CustomSearchPageDelegate({
    String? hintText,
    required this.models,
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );


  /// 搜素提示
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

  /// 模拟数据，一般调用接口返回的数据
  List<DataItemModel> models = [];

  /// 搜索结果
  List<DataItemModel> results = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context);

  }

  /// 右边的搜索按钮
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      InkWell(
        onTap: () {
          search(context, query);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: const Text(
            "搜索",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    ];
  }

  /// 左边返回按钮
  @override
  Widget? buildLeading(BuildContext context) {
    return InkWell(
        onTap: () {
          /// 返回操作，关闭搜索功能
          /// 这里应该返回 null
          close(context, DataItemModel());
        },
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: SvgPicture.asset(
            "assets/images/arrow.svg",
            height: 22,
            color: Colors.black,
          ),
        ));
  }

  /// 搜索结果列表
  @override
  Widget buildResults(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        DataItemModel item = results[index];
        /// 自定义Widget，用来显示每一条搜素到的数据。
        return SearchResultItemWidget(
          itemModel: item,
          click: () {
            /// 点击一条数据后关闭搜索功能，返回该条数据。
            close(context, item);
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return divider;
      },
    );
  }

  /// 提示词列表
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
        return InkWell(
          onTap: () {
            /// 点击提示词，会根据提示词开始搜索，这里模拟从models数组中搜索数据。
            query = name;
            search(context, name);
          },
          child: Container(
            color: Colors.white,
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
                  text: TextSpan(children: getSpans(name)),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
      separatorBuilder: (BuildContext context, int index) {
        return divider;
      },
    );
  }

  search(BuildContext context, String keyword){
    /// 点击提示词，会根据提示词开始搜索，这里模拟从models数组中搜索数据。
    results = models
        .where((e) =>
    (e.title?.toLowerCase().contains(keyword.toLowerCase()) ??
        false) ||
        (e.desc?.toLowerCase().contains(keyword.toLowerCase()) ??
            false))
        .toList();

    /// 展示结果，这个时候就调用 buildResults，主页面就会用来显示搜索结果
    showResults(context);
  }

  /// 分割线
  Widget get divider => Container(
        color: const Color(0xFFAFAFAF),
        height: 0.3,
      );

  /// 富文本提示词，其中如果和输入的文本匹配到的关键字显示红色。
  List<TextSpan> getSpans(String name) {
    int start = name.toLowerCase().indexOf(query.toLowerCase());
    String end = name.substring(start, start + query.length);
    List<String> spanStrings = name
        .toLowerCase()
        .replaceAll(end.toLowerCase(), "*${end.toLowerCase()}*")
        .split("*");
    return spanStrings
        .map((e) => (e.toLowerCase() == end.toLowerCase()
            ? TextSpan(
                text: e,
                style: const TextStyle(color: Colors.red, fontSize: 14))
            : TextSpan(
                text: e,
                style:
                    const TextStyle(color: Color(0xFF373737), fontSize: 14))))
        .toList();
  }
}
