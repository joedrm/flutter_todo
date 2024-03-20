import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/language/generated/l10n.dart';
import 'package:flutter_todo/providers/app_language_provider.dart';
import 'package:provider/provider.dart';

class TestLanguagePage extends StatefulWidget {
  const TestLanguagePage({Key? key}) : super(key: key);

  @override
  State<TestLanguagePage> createState() => _TestLanguagePageState();
}

class _TestLanguagePageState extends State<TestLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            CupertinoButton(
                child: Container(
                  width: 120,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      S.of(context).intl_zh,
                      style: const TextStyle(
                          color: Color(0xFFffffff), fontSize: 22),
                    ),
                  ),
                ),
                onPressed: () {
                  Provider.of<AppLanguageProvider>(context, listen: false)
                      .changeLanguage(LanguageCode.zh);
                }),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                child: Container(
                  width: 120,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      S.of(context).intl_en,
                      style: const TextStyle(
                          color: Color(0xFFffffff), fontSize: 22),
                    ),
                  ),
                ),
                onPressed: () {
                  Provider.of<AppLanguageProvider>(context, listen: false)
                      .changeLanguage(LanguageCode.en);
                }),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                child: Container(
                  width: 120,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      S.of(context).intl_en,
                      style: const TextStyle(
                          color: Color(0xFFffffff), fontSize: 22),
                    ),
                  ),
                ),
                onPressed: _showAlert)
          ],
        ),
      ),
    );
  }

  _showAlert() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx1) {
          return Material(
              type: MaterialType.transparency,
              child: StatefulBuilder(
                builder: (ctx2, state) {
                  return Stack(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Center(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(22, 24, 22, 15),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200,
                          color: Colors.white,
                          child: Text(S.of(context).alert_msg,
                              style: const TextStyle(
                                  color: Color(0xFF222222), fontSize: 16)),
                        ),
                      ))
                    ],
                  );
                },
              ));
        });
  }
}
