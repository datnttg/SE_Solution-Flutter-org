import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../utilities/app_service.dart';
import '../../../utilities/classes/chart_data_models.dart';
import '../../../utilities/constants/core_constants.dart';
import '../../../utilities/ui_styles.dart';

class HourlyChart extends StatefulWidget {
  final Future<List<TimeChartData>> chartData;

  const HourlyChart({super.key, required this.chartData});

  @override
  State<HourlyChart> createState() => _HourlyChartState();
}

class _HourlyChartState extends State<HourlyChart> {
  late DateTime date;
  late Future<List<TimeChartData>> chartData;

  @override
  void initState() {
    super.initState();
    date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    chartData = widget.chartData;
  }

  Future<void> fetchHourlyData(DateTime date) async {
    Map parameters = {
      'startTimeUtc': date,
    };
    var dailyResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetDaySummaryChartData'),
        parameters: parameters);
    var dailyData = dailyResponse['responseData'];
    var i = 0;
    var diData = dailyData[i]['data'] as List;
    chartData = diData.map((e) => TimeChartData.fromJson(e)).toList()
        as Future<List<TimeChartData>>;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: fetchHourlyData(date),
          builder: (context, snapshot) {
            Widget child = Container();
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                padding: const EdgeInsets.all(8.0),
                height: 350,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasData) {
              child = chartHourly(snapshot.data as List<TimeChartData>);
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  height: 30,
                  color: Colors.grey,
                  child: Center(
                    child: Row(children: [
                      const Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: null,
                          icon: Icon(Icons.arrow_left),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextButton(
                          onPressed: () => setState(() {
                            fetchHourlyData(date);
                          }),
                          child: Text(DateFormat('dd-MM-yyyy').format(date)),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: null,
                          icon: Icon(Icons.arrow_right),
                        ),
                      ),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget chartHourly(List<TimeChartData> chartData) {
    var minTime =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var maxTime = minTime.add(const Duration(days: 1));
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
        intervalType: DateTimeIntervalType.minutes,
        interval: 120,
        // edgeLabelPlacement: EdgeLabelPlacement.shift,
        labelRotation: -90,
      ),
      primaryYAxis: NumericAxis(
        minimum: minValue,
        maximum: maxValue * 1.1,
        interval: 1,
      ),
      series: <CartesianSeries<TimeChartData, DateTime>>[
        SplineAreaSeries(
            dataSource: chartData,
            xValueMapper: (TimeChartData data, _) => data.time.toLocal(),
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
}
