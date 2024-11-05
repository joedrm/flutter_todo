import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/search_page/custom_search_delegate.dart';
import 'package:flutter_todo/pages/search_page/custom_search_page_delegate.dart';
import 'package:flutter_todo/pages/search_page/data_item_model.dart';
import 'package:flutter_todo/pages/search_page/search_page_delegate.dart';

class GoodListPage extends StatefulWidget {
  const GoodListPage({super.key});

  @override
  State<GoodListPage> createState() => _GoodListPageState();
}

class _GoodListPageState extends State<GoodListPage> {
  List<Map<String, dynamic>> dataList = [
    {
      "title": "Flutter开发7个建议，让你的工作效率飙升",
      "desc":
          "刚开始接触用 Flutter  开发App的时候，比较喜欢它的 UI 编写方式，尤其是 Flutter 热重载特性，UI调试如同Web前端开发，能够即时查看代码更改的效果。那在日常开发中，还有没有其它提升工作效率的方法呢，今天就给大家分享几个超实用的建议，助你在 Flutter 开发中事半功倍",
      "icon": "assets/images/03.png",
      "readCount": "5w",
      "createTime": "2024-05-08"
    },
    {
      "title": "浅谈 Flutter 的并发和 isolates",
      "desc":
          "有没有一种感觉，就我自己而言，Flutter 项目开发了好几个了，但是对这个 isolates 印象依旧很陌生，日常开发中好像很少见到它身影或者用到它，但真实情况是这样的吗？今天就来聊一聊它。",
      "icon": "assets/images/02.png",
      "readCount": "9998",
      "createTime": "2023-01-12"
    },
    {
      "title": "Flutter大型项目架构：分层设计篇",
      "desc":
          "上篇文章讲的是状态管理（传送门）提到了 Flutter BLoC ，相比与原生的 setState() 及Provider等有哪些优缺点，并结合实际项目写了一个简单的使用，接下来本篇文章来讲 Flutter 大型项目是如何进行分层设计的，费话不多说，直接进入正题哈",
      "icon": "assets/images/01.png",
      "readCount": "1w",
      "createTime": "2024-04-16"
    },
    {
      "title": "Flutter 中如何优雅地使用弹框",
      "desc":
          "日常开发中，Flutter 弹框（Dialog）是我们使用频率非常高的控件。无论是提示用户信息、确认用户操作，还是表单填写，弹框都能派上用场。然而，看似简单的弹框，实际使用起来却有不少坑和使用的技巧。今天，我们就来聊聊这些弹框的使用技巧，文末还有关于在 bloc 如何使用弹框的内容，保证你看完之后干货满满，下面直接开始吧",
      "icon": "assets/images/04.png",
      "readCount": "9661",
      "createTime": "2024-05-19"
    },
    {
      "title": "Flutter大型项目架构：UI设计系统实现（二）",
      "desc":
          "上一篇 介绍了 UI 设计系统实现中的原子级别如 color、font、padding、radius 等的管理方式，本篇主要来介绍设计系统中分子级别和细胞级别，也就是一些最基本和常见的 widget  及自定义的 widget，来看看在 UI 设计系统是如何对它们进行封装的",
      "icon": "assets/images/05.png",
      "readCount": "2.3w",
      "createTime": "2024-06-09"
    },
    {
      "title": "深入了解 Flutter 中的 BuildContext",
      "desc":
          "在 Flutter 中 BuildContext 可太常见了，不管是 StatelessWidget 还是 StatefulWidget 的 build() 函数参数都会带有 BuildContext，好像随处可见，就像我们的一位老朋友，但似乎又对其知之甚少（熟悉的陌生人），今天我们再来了解一下这位老朋友 BuildContext，看看它在 Flutter 架构中扮演什么角色，我们该如何使用它及使用的时候需要注意什么",
      "icon": "assets/images/06.png",
      "readCount": "1.5w",
      "createTime": "2024-06-11"
    },
    {
      "title": "Dart 语法原来这么好玩儿",
      "desc":
          "说到到某个语言的语法可能大家会觉得很枯燥、乏味，而Flutter日常开发中我们往往更加注重的是业务逻辑和页面开发，语法的使用大多也停留在满足基本的需求。其实 Dart 语法有很多有意思的地方的，仔细探究一下你会发现，它的简洁清晰、灵活多样的语法会让人爱不释手。在本文中，我们将探索 Dart 语法的各种奇妙之处吧。",
      "icon": "assets/images/07.png",
      "readCount": "1.9w",
      "createTime": "2024-07-10"
    },
  ];

  List<DataItemModel> models = [];

  @override
  void initState() {
// TODO: implement initState
    super.initState();

    models = dataList.map((e) => DataItemModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          color: Colors.white,
          child: TextButton(
              onPressed: () async {
                // showBottomSheet(context: context, builder: builder)
                
                // showDialog(context: context, builder: builder)

                // DataItemModel? result = await showSearch(
                //     context: context,
                //     delegate: CustomSearchPageDelegate(
                //         models: models, hintText: "Flutter 技术实践"));

                DataItemModel? result =
                    await showSearchWithCustomiseSearchDelegate(
                        context: context,
                        delegate: SearchPageDelegate(
                            hintText: "Flutter 技术实践", models: models));
                if (result != null) {
                  /// to detail page
                }
              },
              child: const Text("开始搜索")),
        ),
      ),
    );
  }
}
