import 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:fitness_dashboard_ui/widgets/activity_details_card.dart';
// import 'package:fitness_dashboard_ui/widgets/bar_graph_widget.dart';
import 'package:fitness_dashboard_ui/widgets/header_widget.dart';
import 'package:fitness_dashboard_ui/widgets/line_chart_card1.dart';
import 'package:fitness_dashboard_ui/widgets/line_chart_card2.dart';
import 'package:fitness_dashboard_ui/widgets/line_chart_card3.dart';
import 'package:fitness_dashboard_ui/widgets/summary_widget.dart';
import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const HeaderWidget(),
            const SizedBox(height: 18),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),
            const LineChartCard1(),
            const SizedBox(height: 18),
            const LineChartCard2(),
            const SizedBox(height: 18),
            const LineChartCard3(),
            const SizedBox(height: 18),

            // const BarGraphCard(),
            // const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
