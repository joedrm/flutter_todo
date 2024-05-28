import 'dart:math';

import 'package:flutter/material.dart';

class InheritedWidgetTestPage extends StatefulWidget {
  const InheritedWidgetTestPage({Key? key}) : super(key: key);

  @override
  State<InheritedWidgetTestPage> createState() =>
      _InheritedWidgetTestPageState();
}

class _InheritedWidgetTestPageState extends State<InheritedWidgetTestPage> {
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return CustomColorWidget(
      color: color,
      onColorChange: onColorChange,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyCardWidget(key: UniqueKey()),
              FilledButton(
                onPressed: () => onColorChange(),
                child: const Text("Change Color"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onColorChange() {
    setState(() {
      color = Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1);
    });
  }
}

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColorWidget.of(context)?.color ?? Colors.white,
      height: 200,
      width: 200,
    );
  }
}

class CustomColorWidget extends InheritedWidget {
  const CustomColorWidget({
    super.key,
    required super.child,
    required this.color,
    required this.onColorChange,
  });

  final Color color;
  final void Function() onColorChange;

  static CustomColorWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomColorWidget>();
  }

  @override
  bool updateShouldNotify(CustomColorWidget oldWidget) {
    return oldWidget.color != color;
  }
}
