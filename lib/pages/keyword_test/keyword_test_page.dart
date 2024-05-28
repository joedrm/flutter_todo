import 'package:flutter/material.dart';

class KeywordTestPage extends StatefulWidget {
  const KeywordTestPage({Key? key}) : super(key: key);

  @override
  State<KeywordTestPage> createState() => _KeywordTestPageState();
}

class _KeywordTestPageState extends State<KeywordTestPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: Center(
        child: TextButton(
          onPressed: () {
            // context.watch<>()
          },
          child: Text('Show Keyword', style: TextStyle(fontSize: 22, color: Colors.deepOrange),),
        ),
      ),
    );
  }
}
