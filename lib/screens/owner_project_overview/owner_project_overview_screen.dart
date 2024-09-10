import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../utilities/classes/chart_data_models.dart';
import '../../../utilities/constants/core_constants.dart';
import '../../../utilities/constants/dismention_contants.dart';
import '../../../utilities/shared_preferences.dart';
import '../../utilities/app_service.dart';
import '../../utilities/custom_widgets.dart';
import '../common_components/main_menu.dart';
import 'components/chart_templates.dart';

class OwnerProjectOverviewScreen extends StatefulWidget {
  const OwnerProjectOverviewScreen({super.key});

  @override
  State<OwnerProjectOverviewScreen> createState() =>
      _OwnerProjectOverviewScreenState();
}

class _OwnerProjectOverviewScreenState extends State<OwnerProjectOverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  Future<Map>? _projectStatus;
  Future<Map>? _summaryData;
  Future<List<TimeChartData>>? _timelyChartData;
  Future<List<TimeChartData>>? _dailyChartData;
  Future<List<TimeChartData>>? _monthlyChartData;
  Future<List<TimeChartData>>? _yearlyChartData;

  @override
  initState() {
    _controller = TabController(length: 4, vsync: this);
    Future<Map> data = kFetchData();
    _projectStatus = data.then((value) => value['projectsStatus']);
    _summaryData = data.then((value) => value['summaryData']);
    Future<Map> chartData = data.then((value) => value['chartData']);

    /// Timely Data
    Future<List> timelyData = chartData.then((value) => value['timelyData']);
    _timelyChartData = timelyData.then((value) => value
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['pt_kW'] ?? 0,
            ))
        .toList());

    /// Daily Data
    Future<List> dailyData = chartData.then((value) => value['dailyData']);
    _dailyChartData = dailyData.then((value) => value
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'] ?? 0,
            ))
        .toList());

    /// Monthly Data
    Future<List> monthlyData = chartData.then((value) => value['monthlyData']);
    _monthlyChartData = monthlyData.then((value) => value
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'] ?? 0,
            ))
        .toList());

    /// Yearly Data
    Future<List> yearlyData = chartData.then((value) => value['yearlyData']);
    _yearlyChartData = yearlyData.then((value) => value
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'] ?? 0,
            ))
        .toList());
    super.initState();
  }

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime month = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime year = DateTime(DateTime.now().year, 1, 1);

  Future<Map> kFetchData() async {
    var parameters = {
      'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(date)
    };
    var httpResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetSummaryData'),
        parameters: parameters);
    var res = httpResponse['responseData'];
    return res;
  }

  Future<List<TimeChartData>> fetchTimelyChartData(DateTime activeDate) async {
    var parameters = {
      'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(activeDate)
    };
    var dailyResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetTimelyData'),
        parameters: parameters);
    List timelyData = dailyResponse['responseData'];
    var res = timelyData
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['pt_kW'],
            ))
        .toList();
    return res;
  }

  Future<List<TimeChartData>> fetchDailyChartData(DateTime dateOfMonth) async {
    var parameters = {
      'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateOfMonth)
    };
    var dailyResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetDailyData'),
        parameters: parameters);
    List timelyData = dailyResponse['responseData'];
    var res = timelyData
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'],
            ))
        .toList();
    return res;
  }

  Future<List<TimeChartData>> fetchMonthlyChartData(DateTime dateOfYear) async {
    var parameters = {
      'startTime': DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateOfYear)
    };
    var dailyResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetMonthlyData'),
        parameters: parameters);
    List timelyData = dailyResponse['responseData'];
    var res = timelyData
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'],
            ))
        .toList();
    return res;
  }

  Future<List<TimeChartData>> fetchYearlyChartData() async {
    var dailyResponse = await fetchData(
        Uri.parse('${constants.hostAddress}/Project/GetYearlyData'));
    List timelyData = dailyResponse['responseData'];
    var res = timelyData
        .map((e) => TimeChartData(
              time: DateTime.parse(e['timeStamp']),
              value: e['ePt_kWh'],
            ))
        .toList();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    // RenderBox mediaQuery =
    //     _widgetKey.currentContext?.findRenderObject() as RenderBox;
    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPref.translate("Dashboard")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ownedContracts(mediaQuery.size.width),
            ownedProjects(mediaQuery.size.width),
          ],
        ),
      ),
    );
  }

  Widget ownedContracts(double parentWidth) {
    var columns = (parentWidth) ~/ 400;
    var width = parentWidth / columns - kDefaultPadding * 3;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bodyHeading('Hợp đồng'),
        Wrap(children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SizedBox(
                width: width,
                height: 300,
                child: const Text("test"),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SizedBox(
                width: width,
                height: 300,
                child: const Text("test"),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SizedBox(
                width: width,
                height: 300,
                child: const Text("test"),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget ownedProjects(double parentWidth) {
    var columns = parentWidth ~/ 400;
    var width = parentWidth / columns - columns * 8 - 4;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bodyHeading(sharedPref.translate('MyProjects')),
          Wrap(
            children: [
              /// PROJECT STATUS
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width,
                    child: FutureBuilder(
                        future: _projectStatus,
                        builder: (context, snapshot) {
                          Widget child = Container();
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            child = projectSummaryStatus(snapshot.data as Map);
                          }
                          return child;
                        }),
                  ),
                ),
              ),

              /// PROJECT INDICATOR
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width,
                    child: FutureBuilder(
                        future: _summaryData,
                        builder: (context, snapshot) {
                          Widget child = Container();
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            child =
                                projectSummaryIndicator(snapshot.data as Map);
                          }
                          return child;
                        }),
                  ),
                ),
              ),

              /// CHARTS
              Card(
                child: Container(
                  padding: const EdgeInsets.all(0),
                  width: width,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        controller: _controller,
                        tabs: [
                          Tab(text: sharedPref.translate('Day')),
                          Tab(text: sharedPref.translate('Month')),
                          Tab(text: sharedPref.translate('Year')),
                          Tab(text: sharedPref.translate('All')),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(0),
                      height: 300,
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            date = date
                                                .add(const Duration(days: -1));
                                            setState(() {
                                              _timelyChartData =
                                                  fetchTimelyChartData(date);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_left),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(DateFormat('dd-MM-yyyy')
                                              .format(date)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            date = date
                                                .add(const Duration(days: 1));
                                            setState(() {
                                              _timelyChartData =
                                                  fetchTimelyChartData(date);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: FutureBuilder(
                                      future: _timelyChartData,
                                      builder: (context, snapshot) {
                                        Widget child = Container();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          child = chartTimely(snapshot.data
                                              as List<TimeChartData>);
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: child,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            month = DateTime(month.year,
                                                month.month - 1, month.day);
                                            setState(() {
                                              _dailyChartData =
                                                  fetchDailyChartData(month);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_left),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(DateFormat('MM-yyyy')
                                              .format(month)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            month = DateTime(month.year,
                                                month.month + 1, month.day);
                                            setState(() {
                                              _dailyChartData =
                                                  fetchDailyChartData(month);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: FutureBuilder(
                                      future: _dailyChartData,
                                      builder: (context, snapshot) {
                                        Widget child = Container();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          child = chartDaily(snapshot.data
                                              as List<TimeChartData>);
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: child,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            year = DateTime(year.year - 1,
                                                year.month, year.day);
                                            setState(() {
                                              _monthlyChartData =
                                                  fetchMonthlyChartData(year);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_left),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                              DateFormat('yyyy').format(year)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: IconButton(
                                          padding: const EdgeInsets.all(0),
                                          onPressed: () {
                                            year = DateTime(year.year + 1,
                                                year.month, year.day);
                                            setState(() {
                                              _monthlyChartData =
                                                  fetchMonthlyChartData(year);
                                            });
                                          },
                                          icon: const Icon(Icons.arrow_right),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: FutureBuilder(
                                      future: _monthlyChartData,
                                      builder: (context, snapshot) {
                                        Widget child = Container();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          child = chartMonthly(snapshot.data
                                              as List<TimeChartData>);
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: child,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey,
                                  child: Row(
                                    children: [
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
                                          onPressed: null,
                                          child: Text(
                                              DateFormat('yyyy').format(year)),
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250,
                                  child: FutureBuilder(
                                      future: _yearlyChartData,
                                      builder: (context, snapshot) {
                                        Widget child = Container();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            padding: const EdgeInsets.all(8.0),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          );
                                        }
                                        if (snapshot.hasData) {
                                          child = chartYearly(snapshot.data
                                              as List<TimeChartData>);
                                        }
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: child,
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bodyHeading(String heading) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Text(
              heading,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget projectSummaryStatus(Map projectsStatus) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(kMinPadding),
                  child:
                      Text("${sharedPref.translate('Numbers of projects')}:")),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(kMinPadding),
                child: Text(
                  (projectsStatus['online'] +
                          projectsStatus['partlyOnline'] +
                          projectsStatus['offline'])
                      .toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(kMinPadding),
                  child: Row(
                    children: [
                      const Icon(Icons.fact_check, color: Colors.green),
                      Text("${sharedPref.translate('Online')}:"),
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(kMinPadding),
                child: Text(
                  projectsStatus['online'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(kMinPadding),
                  child: Row(
                    children: [
                      const Icon(Icons.featured_video_outlined,
                          color: Colors.orange),
                      Text("${sharedPref.translate('PartlyOnline')}:"),
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(kMinPadding),
                child: Text(
                  projectsStatus['partlyOnline'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(kMinPadding),
                  child: Row(
                    children: [
                      const Icon(Icons.do_disturb_outlined, color: Colors.red),
                      Text("${sharedPref.translate('Offline')}:"),
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(kMinPadding),
                child: Text(
                  projectsStatus['offline'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget projectSummaryIndicator(Map data) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // indicatorInfo('Công suất lắp đặt', installedCapacity, 'kWp'),
                  indicatorInfo(sharedPref.translate('Total power'),
                      double.parse((data['totalPower'] ?? 0).toString()), 'kW'),
                ],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: indicatorInfo(
                  sharedPref.translate('Energy in day'),
                  double.parse((data['inDayProduction'] ?? 0).toString()),
                  'kWh'),
            ),
            Expanded(
              flex: 1,
              child: indicatorInfo(
                  sharedPref.translate('Energy in month'),
                  double.parse((data['inMonthProduction'] ?? 0).toString()),
                  'kWh'),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: indicatorInfo(
                  sharedPref.translate('Energy in year'),
                  double.parse((data['inYearProduction'] ?? 0).toString()),
                  'kWh'),
            ),
            Expanded(
              flex: 1,
              child: indicatorInfo(
                  sharedPref.translate('Total energy'),
                  double.parse((data['totalProduction'] ?? 0).toString()),
                  'kWh'),
            )
          ],
        ),
      ],
    );
  }

  Widget indicatorInfo(String title, double value, String unit) {
    var f = NumberFormat('#.000', 'en_US');
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(0, kDefaultPadding, 0, kDefaultPadding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value.toString().split('.')[0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                  '.${f.format(value).toString().split('.')[1].substring(0, 2)} $unit'),
            ],
          )
        ],
      ),
    );
  }
}
