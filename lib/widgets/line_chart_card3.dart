import 'dart:async';

import 'package:fitness_dashboard_ui/const/constant.dart';
import 'package:fitness_dashboard_ui/data/line_chart_data3.dart';
import 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartCard3 extends StatefulWidget {
  const LineChartCard3({Key? key}) : super(key: key);

  @override
  _LineChartCard1State createState() => _LineChartCard1State();
}

class _LineChartCard1State extends State<LineChartCard3> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      // Call fetchData() every 15 seconds
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: LineData3().fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or any loading indicator widget
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final flSpots = snapshot.data!['flSpots'];
          final titles = snapshot.data!['titles'];

          return CustomCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Moisture over Time",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 16 / 6,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                      ),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return titles['bottomTitle'][value.toInt()] !=
                                      null
                                  ? SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(
                                        titles['bottomTitle'][value.toInt()]
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[400]),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            getTitlesWidget: (double value, TitleMeta meta) {
                              return titles['leftTitle'][value.toInt()] != null
                                  ? Text(
                                      titles['leftTitle'][value.toInt()]
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[400]),
                                    )
                                  : const SizedBox();
                            },
                            showTitles: true,
                            interval: 1,
                            reservedSize: 40,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          color: selectionColor,
                          barWidth: 2.5,
                          belowBarData: BarAreaData(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                selectionColor.withOpacity(0.5),
                                Colors.transparent
                              ],
                            ),
                            show: true,
                          ),
                          dotData: FlDotData(show: false),
                          spots: flSpots,
                        )
                      ],
                      minX: 0,
                      maxX: 120,
                      maxY: 105,
                      minY: -5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
