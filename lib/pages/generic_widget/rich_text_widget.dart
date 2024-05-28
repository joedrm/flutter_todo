import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable
class BaseText {
  final String text;
  final TextStyle? style;

  const BaseText({
    required this.text,
    this.style,
  });

  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(
        text: text,
        style: style,
      );

  factory BaseText.link({
    required String text,
    required VoidCallback onTapped,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(
        text: text,
        onTapped: onTapped,
        style: style,
      );
}

@immutable
class LinkText extends BaseText {
  final VoidCallback onTapped;

  const LinkText({
    required super.text,
    required this.onTapped,
    super.style,
  });
}

class RichTextWidget extends StatelessWidget {
  final TextStyle? styleForAll;
  final Iterable<BaseText> texts;

  const RichTextWidget({
    super.key,
    required this.texts,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: texts.map(
        (baseText) {
          if (baseText is LinkText) {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  baseText.onTapped();
                },
            );
          } else {
            return TextSpan(
              text: baseText.text,
              style: styleForAll?.merge(baseText.style),
            );
          }
        },
      ).toList()),
    );
  }
}
