import 'package:flutter/material.dart';
import 'package:maven_class/main.dart';
import 'package:maven_class/model/revenue_chart_data.dart';
import 'package:maven_class/utils/colors.dart';
import 'package:maven_class/utils/config.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: SfCartesianChart(
        title: ChartTitle(
          text: 'Monthly Revenue INR',
          textStyle: TextStyle(fontSize: 14)
        ),
        primaryXAxis: CategoryAxis(majorGridLines: MajorGridLines(width: 0), axisLine: AxisLine(width: 0)),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          borderWidth: 1.5,
          color: cardColor,
          textStyle: TextStyle(color: Colors.red)
        ),
        series: <ChartSeries>[
          StackedColumnSeries<RevenueChartData, String>(
            name: 'Revenue',
            enableTooltip: true,
            color: primaryColor,
            dataSource: chartData,
            yValueMapper: (RevenueChartData sales, _) => sales.revenue,
            xValueMapper: (RevenueChartData sales, _) => sales.month,
          ),
        ],
      ),
    );
  }
}
