import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/smart_home/back_painter.dart';

class CircleSliderPaint extends StatefulWidget {
  Function callBack;

  CircleSliderPaint({Key? key, required this.callBack}) : super(key: key);

  @override
  State<CircleSliderPaint> createState() => _CircleSliderPaintState();
}

class _CircleSliderPaintState extends State<CircleSliderPaint> {
  late SliderPainter _painter;
  double angle = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _calculatePaintData();
  }

  @override
  void didUpdateWidget(CircleSliderPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.init != widget.init || oldWidget.end != widget.end) {
    _calculatePaintData();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: CustomPaint(
          painter: BackPainter(
            primarySectors: 6,
            secondarySectors: 50,
            baseColor: Colors.red,
            selectionColor: const Color.fromRGBO(255, 255, 255, 0.3),
            sliderStrokeWidth: 4.0,
          ),
          foregroundPainter: _painter,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 100,
              height: 100,
            ),
          )),
    );
  }

  _onPanDown(DragDownDetails details) {
    _handlePan(details.localPosition, false);
  }

  _onPanUpdate(DragUpdateDetails details) {
    _handlePan(details.localPosition, false);
  }

  _onPanEnd(DragEndDetails details) {
    // _handlePan(details., false);
  }

  double coordinatesToRadians(Offset center, Offset coords) {
    var a = coords.dx - center.dx;
    var b = center.dy - coords.dy;
    return atan2(b, a);
  }

  double radiansToPercentage(double radians) {
    var normalized = radians < 0 ? -radians : pi - radians;
    var percentage = ((100 * normalized) / (pi));
    return (percentage + 25) % 100;
  }

  void _handlePan(Offset details, bool isPanEnd) {
    RenderObject? renderBox = context.findRenderObject();
    var position = details;

    angle = coordinatesToRadians(_painter.center, position);
    // var percentage = radiansToPercentage(angle);
    // _painter.secondarySectors = percentage.ceil();

    widget.callBack();
    print("angle = $angle;");
    // var newValue = percentageToValue(percentage, widget.divisions);

    // if (isBothHandlersSelected) {
    //   var newValueInit =
    //       (newValue - _differenceFromInitPoint) % widget.divisions;
    //   if (newValueInit != widget.init) {
    //     var newValueEnd =
    //         (widget.end + (newValueInit - widget.init)) % widget.divisions;
    //     widget.onSelectionChange(newValueInit, newValueEnd, _laps);
    //     if (isPanEnd) {
    //       widget.onSelectionEnd(newValueInit, newValueEnd, _laps);
    //     }
    //   }
    //   return;
    // }
    //
    // // isDoubleHandler but one handler was selected
    // if (_isInitHandlerSelected) {
    //   widget.onSelectionChange(newValue, widget.end, _laps);
    //   if (isPanEnd) {
    //     widget.onSelectionEnd(newValue, widget.end, _laps);
    //   }
    // } else {
    //   widget.onSelectionChange(widget.init, newValue, _laps);
    //   if (isPanEnd) {
    //     widget.onSelectionEnd(widget.init, newValue, _laps);
    //   }
    // }
  }

  void _calculatePaintData() {
    var initPercent = 0.0;
    _painter = SliderPainter(angle);
  }
}

class CustomPanGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function onPanDown;
  final Function onPanUpdate;
  final Function onPanEnd;

  CustomPanGestureRecognizer({
    required this.onPanDown,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  @override
  void addPointer(PointerEvent event) {
    // if (onPanDown(event.position)) {
    //   startTrackingPointer(event.pointer);
    //   resolve(GestureDisposition.accepted);
    // } else {
    //   stopTrackingPointer(event.pointer);
    // }
  }

  @override
  void handleEvent(PointerEvent event) {
    // if (event is PointerMoveEvent) {
    //   onPanUpdate(event.position);
    // }
    // if (event is PointerUpEvent) {
    //   onPanEnd(event.position);
    //   stopTrackingPointer(event.pointer);
    // }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
