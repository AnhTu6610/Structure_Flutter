import 'package:structure_example/resource/fonts_name.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CommonChart extends StatefulWidget {
  final List<double> data;
  final List<dynamic> mapX;
  final List<dynamic> mapY;
  final String unit;
  const CommonChart({Key key, this.data, this.mapX, this.mapY, this.unit})
      : super(key: key);
  @override
  _CommonChartState createState() => _CommonChartState();
}

class _CommonChartState extends State<CommonChart> {
  List<Color> gradientColors = [
    Color(0xFFFA32E0C1),
    Color(0xFF31BEA9),
  ];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 11,
      child: Container(
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.black.withOpacity(0.8),
                getTooltipItems: (touchedSpots) {
                  List<LineTooltipItem> list = new List<LineTooltipItem>();
                  touchedSpots.forEach((element) {
                    print(element.y);
                    list.add(
                      LineTooltipItem(
                        (element.y * 10).toString() + " ${widget.unit}",
                        TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  });
                  return list;
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xFF6FDBCE),
                  strokeWidth: 1,
                );
              },
            ),
            minX: 0,
            maxX: widget.mapX.length.toDouble(),
            minY: 0,
            maxY: widget.mapY.length.toDouble(),
            axisTitleData: FlAxisTitleData(
              bottomTitle: AxisTitle(titleText: "Gio"),
              leftTitle: AxisTitle(titleText: "Gio"),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                textStyle: const TextStyle(
                  color: Color(0xFF00516A),
                  fontSize: 14,
                  fontFamily: FontsName.nunito_Bold,
                ),
                getTitles: (value) {
                  if (value >= widget.mapX.length) {
                    return "";
                  }
                  return widget.mapX[value.toInt()].toString();
                },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                textStyle: const TextStyle(
                  color: Color(0xFF7C828A),
                  fontSize: 14,
                  fontFamily: FontsName.nunito_Bold,
                ),
                getTitles: (value) {
                  if (value >= widget.mapY.length) {
                    return "";
                  }
                  return widget.mapY[value.toInt()].toString();
                },
                reservedSize: 28,
                margin: 8,
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(widget.data.length, (index) {
                  return FlSpot(index.toDouble(), widget.data[index] / 10);
                }),
                isCurved: true,
                colors: gradientColors,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradientFrom: Offset(0, 3),
                  gradientTo: Offset(0, 0),
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Color(0xFF31BEA9).withOpacity(0.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
