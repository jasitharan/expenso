import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'enums.dart';

class LineChartSample2 extends StatefulWidget {
  final GraphType graphType;
  final List<double> verticalValues;
  final List<double> graphXValues;
  const LineChartSample2({
    Key? key,
    required this.graphType,
    required this.verticalValues,
    required this.graphXValues,
  }) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    if (widget.graphType == GraphType.month) {
      switch (value.toInt()) {
        case 1:
          text = const Text('FEB', style: style);
          break;
        case 3:
          text = const Text('APR', style: style);
          break;
        case 5:
          text = const Text('JUN', style: style);
          break;
        case 7:
          text = const Text('AUG', style: style);
          break;
        case 9:
          text = const Text('OCT', style: style);
          break;
        case 11:
          text = const Text('DEC', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    } else if (widget.graphType == GraphType.week) {
      switch (value.toInt()) {
        case 0:
          text = const Text('1st', style: style);
          break;
        case 1:
          text = const Text('2st', style: style);
          break;
        case 2:
          text = const Text('3st', style: style);
          break;
        case 3:
          text = const Text('4st', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    } else if (widget.graphType == GraphType.day) {
      switch (value.toInt()) {
        case 0:
          text = const Text('00:00', style: style);
          break;
        case 1:
          text = const Text('04:00', style: style);
          break;
        case 2:
          text = const Text('08:00', style: style);
          break;
        case 3:
          text = const Text('12:00', style: style);
          break;
        case 4:
          text = const Text('16:00', style: style);
          break;
        case 5:
          text = const Text('20:00', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = widget.verticalValues[0].toStringAsFixed(1);
        break;
      case 3:
        text = widget.verticalValues[1].toStringAsFixed(1);
        break;
      case 5:
        text = widget.verticalValues[2].toStringAsFixed(1);
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    double maxX = 0;

    switch (widget.graphType) {
      case GraphType.month:
        maxX = 11;
        break;
      case GraphType.week:
        maxX = 3;
        break;
      case GraphType.day:
        maxX = 5;
        break;
      default:
        maxX = 0;
    }

    List<FlSpot> spots = [];

    for (var i = 0; i < widget.graphXValues.length; i++) {
      spots.add(FlSpot(i.toDouble(), (widget.graphXValues[i])));
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: widget.verticalValues[2],
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
