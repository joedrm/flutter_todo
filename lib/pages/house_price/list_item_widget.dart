import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final List<String?> itemTitles;

  const ListItemWidget({Key? key, required this.itemTitles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      alignment: Alignment.center,
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: itemTitles
              .map((title) => Expanded(
                child: Text(
                      title ?? "",
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Color(0xFF232323), fontSize: 14),
                    ),
              ))
              .toList()),
    );
  }
}
