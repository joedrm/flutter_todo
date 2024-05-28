import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/house_price/city_model.dart';
import 'package:flutter_todo/pages/house_price/data_item.dart';
import 'package:flutter_todo/pages/house_price/enum_define.dart';
import 'package:flutter_todo/pages/house_price/line_chart_widget.dart';
import 'package:flutter_todo/pages/house_price/list_item.dart';
import 'package:flutter_todo/pages/house_price/list_item_widget.dart';
import 'package:flutter_todo/utils/number_util.dart';

class HousePriceIndexPage extends StatefulWidget {
  const HousePriceIndexPage({Key? key}) : super(key: key);

  @override
  State<HousePriceIndexPage> createState() => _HousePriceIndexPageState();
}

class _HousePriceIndexPageState extends State<HousePriceIndexPage> {
  List<CityModel> cities = [];
  List<ListItem> listItems = [];
  CityModel? selectedCity;
  final String baseUrl = "https://data.stats.gov.cn/easyquery.htm";
  List<IndexType> types = [IndexType.tb, IndexType.hb, IndexType.dj];
  IndexType _selectIndexType = IndexType.tb;

  List<String> get dates => () {
        DateTime currentDate = DateTime.now();
        int currentMonth = currentDate.month - 1;
        int currentYear = currentDate.year;
        List<DateTime> allMonthsDates = [];
        for (int i = 0; i < 12; i++) {
          int month = (currentMonth - i) % 12;
          int year = currentYear - ((currentMonth - i) <= 0 ? 1 : 0);
          month = (month <= 0) ? (12 + month) : month;
          DateTime monthDate = DateTime(year, month, 1);
          allMonthsDates.add(monthDate);
        }
        return allMonthsDates.map((date) {
          if (date.month < 10) {
            return "${date.year}0${date.month}";
          }
          return "${date.year}${date.month}";
        }).toList();
      }();

  @override
  void initState() {
    super.initState();
    _fetchCityData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F4F5),
      appBar: AppBar(
        title: const Text(
          "房价指数",
          style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 1, right: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        popMenuButton,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: types
                                .map((type) => TextButton(
                                    onPressed: () {
                                      _selectIndexType = type;
                                      setState(() {});
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          _selectIndexType == type
                                              ? Icons.check_box
                                              : Icons
                                                  .check_box_outline_blank_outlined,
                                          size: 20,
                                          color: const Color(
                                            0xFF1c1c1c,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          type.name,
                                          style: const TextStyle(
                                              color: Color(0xFF1c1c1c),
                                              fontSize: 14),
                                        )
                                      ],
                                    )))
                                .toList()),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AspectRatio(
                    aspectRatio: 1.4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 18,
                        left: 8,
                        top: 10,
                        bottom: 5,
                      ),
                      child: LineChartWidget(
                        listItems: listItems,
                        selectedCity: selectedCity,
                        dates: dates,
                        selectIndexType: _selectIndexType,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
                shrinkWrap: true,
                controller: ScrollController(),
                itemBuilder: (ctx, index) {
                  if (index == 0) {
                    return const ListItemWidget(
                        itemTitles: ["日期", "同比", "环比", "定基"]);
                  }
                  ListItem item = listItems[index - 1];
                  return ListItemWidget(itemTitles: [
                    item.sj?.name,
                    "${item.dt1}",
                    "${item.dt2}",
                    "${item.dt3}"
                  ]);
                },
                separatorBuilder: (ctx, index) {
                  return Container(
                    height: 0.05,
                    // color: const Color(0xff666666),
                  );
                },
                itemCount: listItems.length + 1)
          ],
        ),
      ),
    );
  }

  /// 获取城市数据
  _fetchCityData() async {
    var time = DateTime.now().millisecondsSinceEpoch;
    try {
      Response<String?> response = await Dio().get(
        baseUrl,
        queryParameters: {
          "m": "getOtherWds",
          "dbcode": "csyd",
          "rowcode": "zb",
          "colcode": "sj",
          "wds": "[]",
          "k1": "$time"
        },
      );
      if (response.data == null || response.data!.isEmpty) return;
      var decodeData = jsonDecode(response.data!);
      cities = (decodeData["returndata"][0]["nodes"] as List<dynamic>)
          .map((e) => CityModel.fromJson(e))
          .toList();
      selectedCity = cities.first;
      _fetchHousePriceIndexData();
    } catch (err) {
      print(err);
    }
  }

  /// 获取城市过去一年的房价指数
  _fetchHousePriceIndexData() async {
    var time = DateTime.now().millisecondsSinceEpoch;
    try {
      Response<String?> response = await Dio().get(
        baseUrl,
        queryParameters: {
          "m": "QueryData",
          "dbcode": "csyd",
          "rowcode": "zb",
          "colcode": "sj",
          "wds": json.encode([
            {"wdcode": "reg", "valuecode": selectedCity?.code}
          ]),
          "dfwds": json.encode([
            {"wdcode": "sj", "valuecode": dates.join(",")},
            {"wdcode": "zb", "valuecode": "A0108"}
          ]),
          "k1": "$time",
          "h": 1
        },
      );
      if (response.data == null || response.data!.isEmpty) return;
      var decodeData = jsonDecode(response.data!);
      List<DataItem> models =
          (decodeData["returndata"]["datanodes"] as List<dynamic>)
              .map((e) => DataItem.fromJson(e))
              .toList();
      List<CityModel> nodes =
          (decodeData["returndata"]["wdnodes"][2]["nodes"] as List<dynamic>)
              .map((e) => CityModel.fromJson(e))
              .toList();
      List<ListItem> listItems = [];
      for (CityModel date in nodes) {
        ListItem item = ListItem();
        item.sj = date;
        for (DataItem model in models) {
          if (model.sj == date.code && model.reg == selectedCity?.code) {
            if (model.zb == IndexType.tb.typeCode) {
              item.dt1 =
                  NumberUtil.getNumByValueDouble((model.data - 100.0), 2);
            }
            if (model.zb == IndexType.hb.typeCode) {
              item.dt2 =
                  NumberUtil.getNumByValueDouble((model.data - 100.0), 2);
            }
            if (model.zb == IndexType.dj.typeCode) {
              item.dt3 =
                  NumberUtil.getNumByValueDouble((model.data - 100.0), 2);
            }
          }
        }
        listItems.add(item);
      }
      this.listItems = listItems;
      setState(() {});
    } catch (err) {
      print(err);
    }
  }

  Widget get popMenuButton {
    return PopupMenuButton<int>(
      itemBuilder: (context) => cities
          .map((city) => PopupMenuItem(
                value: int.parse(city.code),
                child: Text(city.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14.0, color: Color(0xFF1c1c1c))),
              ))
          .toList(),
      initialValue: 0,
      constraints: const BoxConstraints.expand(width: 130, height: 320),
      color: Colors.white,
      onSelected: (value) {
        selectedCity =
            cities.where((element) => element.code == '$value').first;
        _fetchHousePriceIndexData();
      },
      child: Container(
          height: 50,
          width: 150,
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          color: const Color(0xFFFFFFFF),
          child: Text("所在城市：${selectedCity?.name ?? "请选择"}",
              style:
                  const TextStyle(fontSize: 15.0, color: Color(0xFF1c1c1c)))),
      offset: const Offset(0, 50 + 5),
    );
  }
}
