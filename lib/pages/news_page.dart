import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/modes/dichan_news_model.dart';
import 'package:flutter_todo/utils/device_utils.dart';
import 'package:flutter_todo/utils/leancloud_util.dart';
import 'package:leancloud_storage/leancloud.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<DiChanNewsModel> datas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  fetchData() async {
    List<LCObject> results =
        await LeanCloudUtil.query(LeanCloudUtil.dichanNews, 20);
    List<DiChanNewsModel> histories = [];
    for (LCObject element in results) {
      DiChanNewsModel historyPo = DiChanNewsModel.fromJson(element);
      histories.add(historyPo);
    }
    datas = histories;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = double.infinity;
    if (Device.isWeb) width = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      backgroundColor: const Color(0xfff3f3f3),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.separated(
                  controller: ScrollController(),
                  itemBuilder: (ctx, index) {
                    DiChanNewsModel model = datas[index];
                    return GestureDetector(
                      onTap: () => toPage(index),
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        // height: 70,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: model.imgs?.first ?? "",
                              imageBuilder: (context, image) {
                                return Container(
                                  width: 150,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    // borderRadius:
                                    //     const BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                        image: image, fit: BoxFit.cover),
                                  ),
                                );
                              },
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  // color: ColorUtil.randomColor().withAlpha(40),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              //card_place_image.png
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                              fadeOutDuration: const Duration(seconds: 1),
                              fadeInDuration: const Duration(seconds: 2),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.title ?? "",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff333333),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    model.desc,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 13, color: Color(0xFF666666)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.author ?? "",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF909090)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        model.createTime ?? "",
                                        style: const TextStyle(fontSize: 12),
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
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      height: 0.1,
                      color: Color(0xff999999),
                    );
                  },
                  itemCount: datas.length),
            ),
          ),
        ],
      ),
    );
  }

  toPage(int index) {}
}
