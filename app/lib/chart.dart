import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DayChart extends StatelessWidget {
  final DateTime baseDate = DateTime(2000, 1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Petrol Analytics"),
      ),
      body: Center(
        child: Container(
          child: SfCartesianChart(
            tooltipBehavior: TooltipBehavior(
              enable: true,
            ),
            primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.minutes,
              dateFormat: RelativeDateTimeLabelFormatter(baseDate),
              title: const AxisTitle(
                text: 'Time',
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 4, 20, 63),
                ),
              ),
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(
                text: 'Value',
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 4, 20, 63),
                ),
              ),
            ),
            zoomPanBehavior: ZoomPanBehavior(
              enableSelectionZooming: true,
              enableMouseWheelZooming: true,
              enablePinching: true,
              enablePanning: true,
              zoomMode: ZoomMode.xy,
            ),
            //     onDataLabelRender: (DataLabelRenderArgs args) {
            //       if (args.pointIndex > 0) {
            //         final point = args.dataPoints[args.pointIndex];
            //         final xValue = point.x;
            //         final yValue = point.y;
            //         final peakValue = getdata()[args.pointIndex].peakValue;
            //         if (peakValue != null && yValue == peakValue) {
            //           args.text = 'X: $xValue, Y: $yValue';
            //   args.textStyle=const TextStyle(color:Colors.grey);
            // args.border

            //         } else {}
            //       }
            //     },
            series: <CartesianSeries>[
              LineSeries<PetrolData, DateTime>(
                dataSource: getdata(),
                xValueMapper: (PetrolData data, _) => data.x,
                yValueMapper: (PetrolData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
                color: const Color.fromARGB(255, 4, 20, 63),
                pointColorMapper: (PetrolData data, _) =>
                    data.y < 20 ? Colors.red : Color.fromARGB(255, 4, 20, 63),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PetrolData> getdata() {
    return [
      PetrolData(
          x: baseDate.add(const Duration(milliseconds: 300000)),
          y: 100,
          peakValue: null),
      PetrolData(
          x: baseDate.add(const Duration(milliseconds: 340000)),
          y: 80,
          peakValue: null),
      PetrolData(
          x: baseDate.add(const Duration(milliseconds: 86400000)),
          y: 90,
          peakValue: 90),
      PetrolData(
          x: baseDate.add(const Duration(days: 1, minutes: 0, seconds: 30)),
          y: 150,
          peakValue: 150),
      PetrolData(
          x: baseDate.add(const Duration(days: 2, minutes: 0, seconds: 30)),
          y: 20,
          peakValue: null),
    ];
  }
}

class PetrolData {
  final DateTime x;
  final double y;
  final double? peakValue;
  PetrolData({
    required this.x,
    required this.y,
    this.peakValue,
  });
}

class RelativeDateTimeLabelFormatter extends DateFormat {
  final DateTime baseDate;

  RelativeDateTimeLabelFormatter(this.baseDate);

  @override
  String format(DateTime date) {
    Duration difference = date.difference(baseDate).abs();

    int days = difference.inDays;
    int hours = difference.inHours.remainder(24);
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$days: $formattedHours: $formattedMinutes: $formattedSeconds ';
  }
}
