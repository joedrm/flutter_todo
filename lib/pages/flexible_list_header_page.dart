import 'package:flutter/material.dart';
import 'package:flutter_todo/components/flexible_top_bar.dart';
import 'package:flutter_todo/utils/fluro_navigator_util.dart';
import 'package:flutter_todo/utils/url_launcher_util.dart';

// import 'package:url_launcher/url_launcher.dart';
import '../app.dart';

import 'dart:ui' as ui;

class FlexibleListHeaderPage extends StatefulWidget {
  // const FlexibleListHeaderPage({Key? key}) : super(key: key);

  const FlexibleListHeaderPage({Key? key, this.rpx = 0}) : super(key: key);
  final double rpx;

  @override
  _FlexibleListHeaderPageState createState() => _FlexibleListHeaderPageState();
}

class _FlexibleListHeaderPageState extends State<FlexibleListHeaderPage>
    with TickerProviderStateMixin {
  double extraPicHeight = 0;
  late double prevDy;
  late double rpx;
  late AnimationController animationController;
  late Animation<double> anim;
  late ScrollController _scrollController;
  double offset = 0;
  double expandHeight = 00;

  @override
  void initState() {
    super.initState();

    prevDy = 0;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      offset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerMove: (result) {
          updatePicHeight(result.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          animationController.forward(from: 0);
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  FluroNavigatorUtil.goBack(context);
                },
              ),
              expandedHeight: expandHeight + extraPicHeight,
              // 自定义的 widget，用来显示头部区域
              flexibleSpace: FlexibleTopBarWrapper(
                extraPicHeight: extraPicHeight,
                updateHeight: updateExpandedHeight,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return SizedBox(
                    height: 120, child: Center(child: Text('item: $index')));
              }, childCount: 100),
            ),
          ],
        ),
      ),
    );
  }

  updatePicHeight(changed) {
    if (offset != 0) return;

    if (prevDy == 0) {
      prevDy = changed;
    }

    extraPicHeight += changed - prevDy;
    if (prevDy - changed > 0) {
      // 上滑
      setState(() {
        prevDy = changed;
        extraPicHeight = extraPicHeight;
      });
    }

    if (prevDy - changed <= 0) {
      // 下滑
      if (expandHeight + extraPicHeight > expandHeight + 100) {
        setState(() {
          prevDy = changed;
          extraPicHeight = 100;
        });
        return;
      }
      setState(() {
        prevDy = changed;
        extraPicHeight = extraPicHeight;
      });
    }
  }

  updateExpandedHeight(height) {
    setState(() {
      expandHeight = height;
    });
  }

  runAnimate() {
    anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
      ..addListener(() {
        setState(() {
          extraPicHeight = anim.value;
        });
      });
    prevDy = 0;
  }
}
