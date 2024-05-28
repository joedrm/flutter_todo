import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/smart_home/circle_slider_paint.dart';

class SmartHomePage extends StatefulWidget {
  const SmartHomePage({Key? key}) : super(key: key);

  @override
  State<SmartHomePage> createState() => _SmartHomePageState();
}

class _SmartHomePageState extends State<SmartHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff282828),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Smart Home",
              style: TextStyle(color: Color(0xFF656D73), fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
            CircleSliderPaint(
              callBack: () {
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}
