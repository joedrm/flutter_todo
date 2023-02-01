import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexibleTopBarWrapper extends StatefulWidget {
  final double extraPicHeight;
  final Function(double) updateHeight;

  const FlexibleTopBarWrapper(
      {Key? key, required this.extraPicHeight, required this.updateHeight})
      : super(key: key);

  @override
  _FlexibleTopBarWrapperState createState() => _FlexibleTopBarWrapperState();
}

class _FlexibleTopBarWrapperState extends State<FlexibleTopBarWrapper>
    with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlexibleTopBar(
        extraPicHeight: widget.extraPicHeight,
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      double height =
          box.getMaxIntrinsicHeight(MediaQuery.of(context).size.width);
      widget.updateHeight(height);
    }
  }
}

class FlexibleTopBar extends StatelessWidget {
  const FlexibleTopBar({Key? key, required this.extraPicHeight})
      : super(key: key);
  final double extraPicHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // color: Colors.black12,
      alignment: Alignment.center,
      child: Image.asset(
        "assets/images/wx_01.png",
        height: 150,
        // width: iconWH,
      ),
    );
  }
}
