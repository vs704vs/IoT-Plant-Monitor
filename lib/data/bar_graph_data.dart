import 'package:fitness_dashboard_ui/model/bar_graph_model.dart';
import 'package:fitness_dashboard_ui/model/graph_model.dart';
import 'package:flutter/material.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "Temperature (°C)",
        color: Color(0xFFFEB95A),
        graph: [
          GraphModel(x: 0, y: 34),
          GraphModel(x: 1, y: 26),
          GraphModel(x: 2, y: 37),
          GraphModel(x: 3, y: 40),
          GraphModel(x: 4, y: 38),
          GraphModel(x: 5, y: 35),
        ]),
    const BarGraphModel(label: "Humidity (%)", color: Color(0xFFF2C8ED), graph: [
      GraphModel(x: 0, y: 56),
      GraphModel(x: 1, y: 72),
      GraphModel(x: 2, y: 68),
      GraphModel(x: 3, y: 62),
      GraphModel(x: 4, y: 69),
      GraphModel(x: 5, y: 74),
    ]),
    // const BarGraphModel(
    //     label: "Hydration Level",
    //     color: Color(0xFF20AEF3),
    //     graph: [
    //       GraphModel(x: 0, y: 7),
    //       GraphModel(x: 1, y: 10),
    //       GraphModel(x: 2, y: 7),
    //       GraphModel(x: 3, y: 4),
    //       GraphModel(x: 4, y: 4),
    //       GraphModel(x: 5, y: 10),
    //     ]),
  ];

  final label = ['M', 'T', 'W', 'T', 'F', 'S'];
}
