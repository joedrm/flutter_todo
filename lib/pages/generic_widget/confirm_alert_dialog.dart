import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  const ConfirmAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: StatefulBuilder(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                ),
                //content
              ],
            );
          },
        ));
  }
}
