import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/search_page/data_item_model.dart';

class SearchResultItemWidget extends StatelessWidget {
  const SearchResultItemWidget({super.key, required this.itemModel, this.click});

  final DataItemModel itemModel;
  final Function? click;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => click != null ? click!() : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 120,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Image.asset(
                itemModel.icon ?? "",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${itemModel.title}",
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xFF222222), fontSize: 15),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${itemModel.desc}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xFF666666), fontSize: 13),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${itemModel.readCount}人阅读",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF7A7A7A), fontSize: 12),
                      ),
                      Text(
                        "${itemModel.createTime}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xFF7A7A7A), fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
