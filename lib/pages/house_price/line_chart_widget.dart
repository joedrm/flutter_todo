import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_todo/pages/house_price/enum_define.dart';
import 'package:flutter_todo/utils/number_util.dart';
import 'city_model.dart';
import 'list_item.dart';

@immutable
class LineChartWidget extends StatelessWidget {
  final List<ListItem> listItems;
  final CityModel? selectedCity;
  final List<String> dates;
  final IndexType selectIndexType;

  const LineChartWidget(
      {Key? key,
      required this.listItems,
      required this.selectedCity,
      required this.dates,
      required this.selectIndexType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(),
    );
  }

  LineChartBarData generateLineChartBarData(
          {List<double> yValues = const [],
          Color color = const Color(0xFF7351F6),
          Color dotColor = const Color(0xFF002AFF)}) =>
      LineChartBarData(
        // true 表示曲线，false 表示折线
        isCurved: true,
        // 显示提示指示器的索引列表。这里通过 yValues转成map的keys数组的索引创建一个列表
        showingIndicators: yValues.asMap().keys.toList(),
        // 折线图上的数据点，由 FlSpot 类表示。每个 FlSpot 对象包含一个 x 和 y 值
        spots: yValues.asMap().entries.map((e) {
          return FlSpot(e.key.toDouble(), e.value);
        }).toList(),
        // 是否将折线连接处设置为圆角
        isStrokeJoinRound: true,
        // 折线的颜色
        color: color,
        // 折线的宽度
        barWidth: 1.4,
        // 是否将折线的末端设置为圆角
        isStrokeCapRound: false,
        // 配置折线上的数据点
        dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 2,
                color: dotColor,
                strokeWidth: 1.2,
                strokeColor: dotColor,
              );
            }),
        // 配置折线下方区域的显示。
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withAlpha(160), color.withAlpha(20)],
          ),
        ),
      );

  LineChartData mainData() {
    var yValues = listItems.map((e) {
      switch (selectIndexType) {
        case IndexType.tb:
          return e.dt1;
        case IndexType.hb:
          return e.dt2;
        case IndexType.dj:
          return e.dt3;
      }
    }).toList();

    double numMin = 0;
    double numMax = 0;
    var allValues = [...yValues];
    for (int i = 0; i < allValues.length; i++) {
      if (numMax < allValues[i]) {
        numMax = allValues[i];
      }

      if (allValues[i] < numMin) {
        numMin = allValues[i];
      }
    }

    numMax = NumberUtil.getNumByValueDouble(numMax * 1.2, 2);
    numMin = NumberUtil.getNumByValueDouble(numMin * 1.2, 2);

    List<LineChartBarData> lineBarsData = [
      generateLineChartBarData(
          yValues: yValues,
          color: const Color(0xFF4165E7),
          dotColor: const Color(0xFF4165E7)),
    ];

    var showIndexes = yValues.asMap().keys.toList();
    return LineChartData(
      // X 轴最大值
      maxX: dates.length - 1,
      // X 轴最小值
      minX: 0,
      // Y 轴的基线
      baselineY: 0.0,
      // X 轴最小值
      minY: numMin,
      // Y 轴最大值
      maxY: numMax.ceilToDouble(),
      // 数据点的数值提示，showIndexes 是需要显示提示的索引数组
      showingTooltipIndicators: showIndexes.map((index) {
        // ShowingTooltipIndicators 配置每个索引的数据点。
        return ShowingTooltipIndicators([
          LineBarSpot(lineBarsData[0], lineBarsData.indexOf(lineBarsData[0]),
              lineBarsData[0].spots[index]),
        ]);
      }).toList(),
      // 纵用于设置网格线的样式。gridData 包含网格线的配置，如颜色、宽度、是否显示等
      gridData: gridData,
      // 用于设置图表的标题和标签，包括 X 轴和 Y 轴的标签样式和格式。
      titlesData: titlesData,
      // 用于配置触摸行为，点击数据点时的显示效果。lineTouchData 包含点击时的交互配置
      lineTouchData: lineTouchData,
      // 用于设置图表的边框样式。show 表示是否显示边框，border 设置边框的颜色和宽度。
      borderData: FlBorderData(
        show: true,
        border: const Border(
            left: BorderSide(color: Color(0xff313131)),
            bottom: BorderSide(color: Color(0xff313131))),
      ),
      // 用于配置额外的辅助线。这里配置了一条水平辅助线，颜色、宽度和虚线样式都可以自定义。
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: 0.0,
          color: const Color(0xff010101),
          strokeWidth: 1.6,
          dashArray: [10, 2],
        ),
      ]),
      // 图表的主要内容，包括折线数据。lineBarsData 包含一组 LineChartBarData 对象，每个对象代表一条折线及其数据点。
      lineBarsData: lineBarsData,
    );
  }

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xffaeaeae),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xffaeaeae),
            strokeWidth: 0.5,
          );
        },
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 50,
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // interval: 1,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      );

  LineTouchData get lineTouchData => LineTouchData(
        // 参数用于启用或禁用触摸事件
        enabled: false,
        // 这是一个回调函数，用于定义当数据点被触摸时的指示器样式。它返回 TouchedSpotIndicatorData 的列表，包含每个触摸点的指示器样式。
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            // 每个触摸点的指示器样式
            return TouchedSpotIndicatorData(
              FlLine(
                // 为透明色，因此不会显示指示线
                color: Colors.transparent,
              ),
              FlDotData(
                // 为 false，表示不显示默认的点
                show: false,
              ),
            );
          }).toList();
        },
        // 参数用于配置触摸工具提示的显示样式。
        touchTooltipData: LineTouchTooltipData(
          // 设置为透明色，使工具提示背景透明。
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 9,
          tooltipPadding: const EdgeInsets.only(bottom: -10),
          // 回调函数返回一个 LineTooltipItem 的列表，用于自定义工具提示的内容和样式。此处显示了触摸点的 Y 轴值，并设置了文本样式。
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toString(),
                const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              );
            }).toList();
          },
        ),
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.w300, fontSize: 11, color: Color(0xFF666666));
    String date = dates[value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: 30,
      space: 14,
      child: Text(date, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.w300, fontSize: 11, color: Color(0xFF666666));
    String text = NumberUtil.getNumByValueDouble(value, 1).toString();
    return Text(text, style: style, textAlign: TextAlign.left);
  }
}
