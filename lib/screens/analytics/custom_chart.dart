import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomChart extends StatefulWidget {
  const CustomChart({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomChartState();
  }
}

class _CustomChartState extends State<CustomChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(mainBarData());
  }

  BarChartGroupData makeGroupData(int x, double y) {
    final theme = Theme.of(context);
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 12,
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.tertiary,
              theme.colorScheme.secondary,
            ],
            transform: GradientRotation(pi / 4),
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (index) {
    switch (index) {
      case 0:
        return makeGroupData(0, 2);
      case 1:
        return makeGroupData(1, 3);
      case 2:
        return makeGroupData(2, 0.7);
      case 3:
        return makeGroupData(3, 4.5);
      case 4:
        return makeGroupData(4, 3.8);
      case 5:
        return makeGroupData(5, 1.5);
      case 6:
        return makeGroupData(6, 0.3);
      case 7:
        return makeGroupData(7, 3.8);
      default:
        throw Error();
    }
  });

  BarChartData mainBarData() {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      barGroups: showingGroups(),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style1 = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text('01', style: style1);
        break;
      case 1:
        text = const Text('02', style: style1);
        break;
      case 2:
        text = const Text('03', style: style1);
        break;
      case 3:
        text = const Text('04', style: style1);
        break;
      case 4:
        text = const Text('05', style: style1);
        break;
      case 5:
        text = const Text('06', style: style1);
        break;
      case 6:
        text = const Text('07', style: style1);
        break;
      case 7:
        text = const Text('08', style: style1);
        break;
      default:
        text = const SizedBox.shrink();
    }
    return SideTitleWidget(meta: meta, space: 16, child: text);
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style2 = TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;

    if (value == 0) {
      text = '\$ 0K';
    } else if (value == 1) {
      text = '\$ 1K';
    } else if (value == 2) {
      text = '\$ 2K';
    } else if (value == 3) {
      text = '\$ 3K';
    } else if (value == 4) {
      text = '\$ 4K';
    } else if (value == 5) {
      text = '\$ 5K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      meta: meta,
      space: 0,
      child: Text(text, style: style2),
    );
  }
}
