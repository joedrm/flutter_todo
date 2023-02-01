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
      height: 200,
    );
  }
}

class Tag extends StatelessWidget {
  const Tag({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 26 * rpx, color: Color(0xff64626e)),
      ),
      color: Color(0xff3b3c49),
      padding: EdgeInsets.all(10 * rpx),
      margin: EdgeInsets.only(right: 10 * rpx),
    );
  }
}

class NumWithDesc extends StatelessWidget {
  const NumWithDesc({Key? key, required this.numm, required this.desc})
      : super(key: key);
  final String numm;
  final String desc;

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double textSize = 35 * rpx;
    return Padding(
        padding: EdgeInsets.only(right: 20 * rpx),
        child: Row(
          children: <Widget>[
            Text(
              numm,
              style: TextStyle(
                  fontSize: textSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10 * rpx,
            ),
            Text(desc,
                style: TextStyle(fontSize: textSize, color: Color(0xff3b3c49)))
          ],
        ));
  }
}
