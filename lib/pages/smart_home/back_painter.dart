import 'dart:math';

import 'package:flutter/material.dart';

class BackPainter extends CustomPainter {
  Color baseColor;
  Color selectionColor;
  int primarySectors;
  int secondarySectors;
  double sliderStrokeWidth;

  Offset center = const Offset(0, 0);
  double radius = 2;

  BackPainter({
    this.baseColor = const Color(0xFF666666),
    this.selectionColor = const Color(0xFFffffff),
    this.primarySectors = 10,
    this.secondarySectors = 10,
    this.sliderStrokeWidth = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2);

    assert(radius > 0);

    // Paint base = Paint()
    //   ..color = baseColor
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = sliderStrokeWidth;
    // canvas.drawCircle(center, radius, base);

    // if (primarySectors > 0) {
    //   _paintSectors(primarySectors, 8.0, selectionColor, canvas);
    // }

    if (secondarySectors > 0) {
      Paint section = Paint()
        ..color = baseColor
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      var endSectors = getSectionsCoordinatesInCircle(
          center, radius + 2.0, secondarySectors);
      var initSectors = getSectionsCoordinatesInCircle(
          center, radius - 2.0, secondarySectors);

      print("initSectors = $initSectors;\nendSectors = $endSectors");
      assert(initSectors.length == endSectors.length && initSectors.isNotEmpty);

      for (var i = 0; i < initSectors.length; i++) {
        if (i == 0) {
          section.color = Colors.blue;
        } else {
          section.color = Colors.red;
        }
        canvas.drawLine(initSectors[i], endSectors[i], section);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  List<Offset> getSectionsCoordinatesInCircle(
      Offset center, double radius, int sections) {
    var startAngle = 0;
    var endAngle = 180;

    var intervalAngle = ((endAngle - startAngle) / sections);

    List<Offset> list = [];
    for (double angle = 180; angle < 360; angle += intervalAngle) {
      // 将角度转换为弧度
      var radians = angle * pi / 180.0;

      // 计算点的坐标
      var dx = center.dx + radius * cos(radians);
      var dy = center.dy + radius * sin(radians);

      list.add(Offset(dx, dy));
    }
    return list;
  }
}

class SliderPainter extends CustomPainter {
  Offset center = const Offset(0, 0);
  double radius = 2;
  final double angle;

  SliderPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    center = Offset(size.width / 2, size.height / 2);
    radius = min(size.width / 2, size.height / 2);

    assert(radius > 0);

    // Paint base = Paint()
    //   ..color = baseColor
    //   ..strokeCap = StrokeCap.round
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = sliderStrokeWidth;
    // canvas.drawCircle(center, radius, base);

    // if (primarySectors > 0) {
    //   _paintSectors(primarySectors, 8.0, selectionColor, canvas);
    // }

    Paint section = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    var paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 6.0
      ..color = Colors.yellow
      ..invertColors = false;

    const double start = pi/360;
    double end = -angle;
    print("SliderPainter: $angle");

    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawArc(rect, start, end, false, paint);
    // var endSectors =
    //     getSectionsCoordinatesInCircle(center, radius + 2.0, 50);
    // var initSectors =
    //     getSectionsCoordinatesInCircle(center, radius - 2.0, 50);
    //
    // // print("initSectors = $initSectors;\nendSectors = $endSectors");
    // assert(initSectors.length == endSectors.length && initSectors.isNotEmpty);
    //
    // for (var i = 0; i < initSectors.length; i++) {
    //   canvas.drawLine(initSectors[i], endSectors[i], section);
    // }
  }

  List<Offset> getSectionsCoordinatesInCircle(
      Offset center, double radius, int sections) {
    var startAngle = 0;
    var endAngle = 180;

    var intervalAngle = ((endAngle - startAngle) / sections);

    List<Offset> list = [];
    for (double angle = 180; angle < 270; angle += intervalAngle) {
      // 将角度转换为弧度
      var radians = angle * pi / 180.0;

      // 计算点的坐标
      var dx = center.dx + radius * cos(radians);
      var dy = center.dy + radius * sin(radians);

      list.add(Offset(dx, dy));
    }
    return list;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
