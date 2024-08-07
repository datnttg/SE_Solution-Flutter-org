import 'dart:async';
import 'package:flutter/material.dart';
import '../../../utilities/classes/power_station_models.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../utilities/custom_widgets.dart';
import '../common_components/main_menu.dart';
import 'components/power_station_detail_list.dart';
import 'components/power_station_status_summary.dart';
import 'components/power_station_summary_data.dart';
import 'services/fetch_data_service.dart';

class PowerStationMonitorScreen extends StatefulWidget {
  const PowerStationMonitorScreen({super.key});

  @override
  State<PowerStationMonitorScreen> createState() =>
      _PowerStationMonitorScreenState();
}

class _PowerStationMonitorScreenState extends State<PowerStationMonitorScreen> {
  late Future<List<StationEnergyDataCurrent>> _powerStationList;

  @override
  initState() {
    super.initState();
    fetchPowerStationsData();
  }

  Future<void> fetchPowerStationsData() async {
    Future<List> powerStations = fetchPowerStationsList();
    _powerStationList = powerStations.then((value) =>
        value.map((e) => StationEnergyDataCurrent.fromJson(e)).toList());
  }

  @override
  Widget build(BuildContext context) {
    void handleTimeout() {
      setState(() {
        fetchPowerStationsData();
      });
    }

    Timer scheduleTimeout([int seconds = 5 * 60]) =>
        Timer(Duration(seconds: seconds), handleTimeout);

    scheduleTimeout(400);

    return KScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPref.translate("Dashboard")),
      ),
      body: Responsive.isSmallWidth(context)
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: FutureBuilder(
                        future: _powerStationList,
                        builder: (context, snapshot) {
                          Widget child = Container();
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 300,
                                  minHeight: 200,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            child = PowerStationSummaryData(
                              stationEnergyDataCurrent: snapshot.data,
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: child,
                          );
                        },
                      ),
                    ),
                  )),
                  Card(
                      child: SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: FutureBuilder(
                      future: _powerStationList,
                      builder: (context, snapshot) {
                        Widget child = Container();
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          child = PowerStationStatusSummary(
                            stationEnergyDataCurrent: snapshot.data,
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        );
                      },
                    ),
                  )),
                  Card(
                    child: FutureBuilder(
                      future: _powerStationList,
                      builder: (context, snapshot) {
                        Widget child = Container();
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          child = PowerStationDetailList(
                            stationEnergyDataCurrent: snapshot.data,
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: SizedBox(
                          width: 300,
                          child: Center(
                            child: FutureBuilder(
                              future: _powerStationList,
                              builder: (context, snapshot) {
                                Widget child = Container();
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 300,
                                        minHeight: 200,
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  child = PowerStationSummaryData(
                                    stationEnergyDataCurrent: snapshot.data,
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: child,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                          child: SizedBox(
                        width: 300,
                        child: FutureBuilder(
                          future: _powerStationList,
                          builder: (context, snapshot) {
                            Widget child = Container();
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 300,
                                    minHeight: 250,
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasData) {
                              child = PowerStationStatusSummary(
                                stationEnergyDataCurrent: snapshot.data,
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: child,
                            );
                          },
                        ),
                      )),
                    ],
                  ),
                ),
                Flexible(
                  child: Card(
                    child: FutureBuilder(
                      future: _powerStationList,
                      builder: (context, snapshot) {
                        Widget child = Container();
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          child = PowerStationDetailList(
                            stationEnergyDataCurrent: snapshot.data,
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
