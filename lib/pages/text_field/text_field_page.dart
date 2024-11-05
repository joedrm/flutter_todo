import 'package:flutter/material.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();

  @override
  Widget build(BuildContext context) {
    double textFieldWidth = MediaQuery.of(context).size.width * 0.4;
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(nodeTwo);
                },
                child: const Text(
                  "Sure",
                  style: TextStyle(fontSize: 22, color: Colors.blue),
                ),
              ),
              Container(
                color: Colors.orange,
                width: textFieldWidth,
                child: TextField(
                    cursorColor: const Color(0xFFff0000),
                    focusNode: nodeOne,
                    style:
                        const TextStyle(color: Color(0xFF222222), fontSize: 30),
                    decoration: const InputDecoration(
                      // isDense: true,
                      //取消奇怪的高度
                      isCollapsed: true,
                      // //可以设置自己的
                      contentPadding: EdgeInsets.all(8),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.pinkAccent,
                width: textFieldWidth,
                padding: EdgeInsets.zero,
                child: TextField(
                  cursorColor: const Color(0xFFff0000),
                  focusNode: nodeTwo,
                  style:
                      const TextStyle(color: Color(0xFF222222), fontSize: 30),
                  decoration: const InputDecoration(
                    isDense: true,
                    //取消奇怪的高度
                    // isCollapsed: true,
                    // //可以设置自己的
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.deepPurple,
                width: textFieldWidth,
                height: 44,
                child: TextField(
                    cursorColor: const Color(0xFFff0000),
                    style:
                        const TextStyle(color: Color(0xFF222222), fontSize: 30),
                    minLines: null,
                    maxLines: null,
                    expands: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
