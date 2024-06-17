import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../utilities/classes/chart_data_models.dart';
import '../../../utilities/ui_styles.dart';

Widget chartTimely(List<TimeChartData> chartData) {
  var minTime =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var maxTime = DateTime(1900, 1, 1);
  var minValue = 0.0;
  var maxValue = 0.0;
  for (var e in chartData) {
    e.time = e.time.toLocal();
    minTime = (minTime.isBefore(e.time) ? minTime : e.time);
    maxTime = minTime.isAfter(e.time) ? minTime : e.time;
    minValue = minValue < e.value ? minValue : e.value;
    maxValue = (maxValue > e.value ? maxValue : e.value).ceil().toDouble();
  }
  maxTime = minTime.add(const Duration(days: 1)).isAfter(maxTime)
      ? minTime.add(const Duration(days: 1))
      : maxTime;
  return SfCartesianChart(
    margin: const EdgeInsets.all(0),
    borderWidth: 0,
    borderColor: Colors.transparent,
    plotAreaBorderWidth: 0,
    primaryXAxis: DateTimeAxis(
      minimum: minTime,
      maximum: maxTime,
      intervalType: DateTimeIntervalType.minutes,
      interval: 120,
      labelRotation: -90,
    ),
    primaryYAxis: NumericAxis(
      minimum: minValue,
      maximum: maxValue * 1.1,
    ),
    series: <CartesianSeries<TimeChartData, DateTime>>[
      SplineAreaSeries(
          dataSource: chartData,
          xValueMapper: (TimeChartData data, _) => data.time,
          yValueMapper: (TimeChartData data, _) => data.value,
          gradient: const LinearGradient(
            colors: [
              kPrimaryColor,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ))
    ],
  );
}

Widget chartDaily(List<TimeChartData> chartData) {
  var minTime = DateTime(DateTime.now().year, DateTime.now().month, 1);
  var maxTime = DateTime(1900, 1, 1);
  var minValue = 0.0;
  var maxValue = 0.0;
  for (var e in chartData) {
    minTime = (minTime.isBefore(e.time) ? minTime : e.time);
    maxTime = maxTime.isAfter(e.time) ? maxTime : e.time;
    minValue = minValue < e.value ? minValue : e.value;
    maxValue = (maxValue > e.value ? maxValue : e.value).ceil().toDouble();
  }
  maxTime = DateTime(minTime.year, minTime.month + 1, minTime.day);
  return SfCartesianChart(
    margin: const EdgeInsets.all(0),
    borderWidth: 0,
    borderColor: Colors.transparent,
    plotAreaBorderWidth: 0,
    primaryXAxis: DateTimeAxis(
      minimum: minTime,
      maximum: maxTime,
      intervalType: DateTimeIntervalType.days,
      interval: 2,
    ),
    primaryYAxis: NumericAxis(
      minimum: minValue,
      maximum: maxValue * 1.1,
    ),
    series: <CartesianSeries<TimeChartData, DateTime>>[
      ColumnSeries(
          dataSource: chartData,
          xValueMapper: (TimeChartData data, _) => data.time,
          yValueMapper: (TimeChartData data, _) => data.value,
          gradient: const LinearGradient(
            colors: [
              kPrimaryColor,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ))
    ],
  );
}

Widget chartMonthly(List<TimeChartData> chartData) {
  var minTime = DateTime(DateTime.now().year, 1, 1);
  var maxTime = DateTime(1900, 1, 1);
  var minValue = 0.0;
  var maxValue = 0.0;
  for (var e in chartData) {
    minTime = (minTime.isBefore(e.time) ? minTime : e.time);
    maxTime = maxTime.isAfter(e.time) ? maxTime : e.time;
    minValue = minValue < e.value ? minValue : e.value;
    maxValue = (maxValue > e.value ? maxValue : e.value).ceil().toDouble();
  }
  maxTime = DateTime(minTime.year + 1, minTime.month, minTime.day);
  return SfCartesianChart(
    margin: const EdgeInsets.all(0),
    borderWidth: 0,
    borderColor: Colors.transparent,
    plotAreaBorderWidth: 0,
    primaryXAxis: DateTimeAxis(
      minimum: minTime,
      maximum: maxTime,
      intervalType: DateTimeIntervalType.months,
      interval: 2,
    ),
    primaryYAxis: NumericAxis(
      minimum: minValue,
      maximum: maxValue * 1.1,
    ),
    series: <CartesianSeries<TimeChartData, DateTime>>[
      ColumnSeries(
          dataSource: chartData,
          xValueMapper: (TimeChartData data, _) => data.time,
          yValueMapper: (TimeChartData data, _) => data.value,
          gradient: const LinearGradient(
            colors: [
              kPrimaryColor,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ))
    ],
  );
}

Widget chartYearly(List<TimeChartData> chartData) {
  var minTime = DateTime(DateTime.now().year, 1, 1);
  var maxTime = DateTime(1900, 1, 1);
  var minValue = 0.0;
  var maxValue = 0.0;
  for (var e in chartData) {
    minTime = (minTime.isBefore(e.time) ? minTime : e.time);
    maxTime = maxTime.isAfter(e.time) ? maxTime : e.time;
    minValue = minValue < e.value ? minValue : e.value;
    maxValue = (maxValue > e.value ? maxValue : e.value).ceil().toDouble();
  }
  return SfCartesianChart(
    margin: const EdgeInsets.all(0),
    borderWidth: 0,
    borderColor: Colors.transparent,
    plotAreaBorderWidth: 0,
    primaryXAxis: DateTimeAxis(
      minimum: minTime,
      maximum: maxTime,
      intervalType: DateTimeIntervalType.years,
      interval: 1,
    ),
    primaryYAxis: NumericAxis(
      minimum: minValue,
      maximum: maxValue * 1.1,
    ),
    series: <CartesianSeries<TimeChartData, DateTime>>[
      ColumnSeries(
          dataSource: chartData,
          xValueMapper: (TimeChartData data, _) => data.time,
          yValueMapper: (TimeChartData data, _) => data.value,
          gradient: const LinearGradient(
            colors: [
              kPrimaryColor,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ))
    ],
  );
}
