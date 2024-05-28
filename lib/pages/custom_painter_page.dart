import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

class CustomPainterPagePage extends StatefulWidget {
  const CustomPainterPagePage({Key? key}) : super(key: key);

  @override
  State<CustomPainterPagePage> createState() => _CustomPainterPagePageState();
}

class _CustomPainterPagePageState extends State<CustomPainterPagePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.2, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: Column(
        children: [
          CustomPaint(
            painter: SizeChangedPainter(animation: _animation),
            child: const SizedBox(
              width: 200.0,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  final Animation<double> factor;

  ShapePainter({required this.factor}) : super(repaint: factor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color.lerp(Colors.red, Colors.blue, factor.value)!;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) {
    return oldDelegate.factor != factor;
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print("paint");
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..isAntiAlias = true //是否抗锯齿
      ..style = PaintingStyle.fill; //画笔样式：填充

    // 绘制一个圆形
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 50.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SizeChangedPainter extends CustomPainter {
  final Animation<double> animation;
  SizeChangedPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制逻辑
    double rectWidth = animation.value * size.width;
    double rectHeight = animation.value * size.height;

    print("animation.value = ${animation.value}; size = $size");

    Paint paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTRB(0, 0, rectWidth, rectHeight), paint);
  }

  @override
  bool shouldRepaint(covariant SizeChangedPainter oldDelegate) {
    // 默认返回true，表示总是需要重绘
    return oldDelegate.animation.value != animation.value;
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const RadialGradient gradient = RadialGradient(
      center: Alignment(0.7, -0.6),
      radius: 0.2,
      colors: <Color>[Color(0xFFFFFF00), Color(0xFF0099FF)],
      stops: <double>[0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      Rect rect = Offset.zero & size;
      final double width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return <CustomPainterSemantics>[
        CustomPainterSemantics(
          rect: rect,
          properties: const SemanticsProperties(
            label: 'Sunssssss',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => true;
}
