import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_dashboard/res/ecg_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EcgGraph extends StatefulWidget {
  final double Function() ecgValue;
  final Color color;
  const EcgGraph({
    Key? key,
    required this.ecgValue,
    required this.color,
  }) : super(key: key);

  @override
  State<EcgGraph> createState() => _EcgGraphState();
}

class _EcgGraphState extends State<EcgGraph> {
  _EcgGraphState() {
    timer = Timer.periodic(const Duration(microseconds: 8), _updateDataSource);
  }
  Timer? timer;
  List<ChartData>? chartData;
  late double count;
  ChartSeriesController? chartSeriesController;
  @override
  void initState() {
    count = 10;
    chartData = <ChartData>[
      ChartData(0, 0),
    ];
    super.initState();
    // );
  }

  @override
  void dispose() {
    timer?.cancel();
    chartData!.clear();
    chartSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SfCartesianChart(
        enableAxisAnimation: true,
        title: ChartTitle(
          text: 'ECG DATA',
          alignment: ChartAlignment.near,
        ),
        plotAreaBorderWidth: 2,
        plotAreaBorderColor: Colors.black38,
        primaryXAxis: NumericAxis(
          majorGridLines: const MajorGridLines(width: 1),
          interval: 100,
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(width: 0),
          minimum: -1.5,
          maximum: 1.5,
          majorTickLines: const MajorTickLines(size: 0),
        ),
        series: <SplineSeries<ChartData, int>>[
          SplineSeries<ChartData, int>(
            animationDelay: 2,
            onRendererCreated: (ChartSeriesController controller) {
              chartSeriesController = controller;
            },
            dataSource: chartData!,
            color: widget.color,
            xValueMapper: (ChartData val, _) => val.x.toInt(),
            yValueMapper: (ChartData val, _) => val.y,
            animationDuration: 1,
          )
        ],
      ),
    );
  }

  void _updateDataSource(Timer timer) {
    chartData!.add(ChartData(count.toDouble(), widget.ecgValue()));
    if (chartData!.length == 300) {
      chartData!.removeAt(0);
      chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
        removedDataIndexes: <int>[0],
      );
    } else {
      chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[chartData!.length - 1],
      );
    }
    count = count + 1;
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}
