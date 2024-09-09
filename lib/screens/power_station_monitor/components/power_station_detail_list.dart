import 'package:flutter/material.dart';
import '../../../utilities/classes/power_station_models.dart';
import '../../../utilities/configs.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';

class PowerStationDetailList extends StatefulWidget {
  final List<StationEnergyDataCurrent>? stationEnergyDataCurrent;
  const PowerStationDetailList(
      {super.key, required this.stationEnergyDataCurrent});

  @override
  State<PowerStationDetailList> createState() => _PowerStationDetailListState();
}

class _PowerStationDetailListState extends State<PowerStationDetailList> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    return Responsive.isSmallWidth(context)
        ? Column(
            children: [
              Container(
                height: mediumTextSize * 3,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 2),
                  child: Text(
                    sharedPref.translate("Information"),
                    maxLines: 2,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kContentColor),
                  ),
                ),
              ),
              //LIST VIEW
              SizedBox(
                height: screenSize.height * 0.7,
                child: ListView.builder(
                  itemCount: widget.stationEnergyDataCurrent?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, defaultPadding / 2, 0, defaultPadding / 5),
                      child: Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                            color: index.isOdd ? kBgColorRow1 : null,
                            borderRadius:
                                BorderRadius.circular(defaultRadius / 2)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    (widget.stationEnergyDataCurrent?[index]
                                                .name ??
                                            "")
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: largeTextSize,
                                    ),
                                  )),
                                  Text(
                                    sharedPref.translate(widget
                                            .stationEnergyDataCurrent?[index]
                                            .status ??
                                        ""),
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: widget
                                                    .stationEnergyDataCurrent?[
                                                        index]
                                                    .status ==
                                                "Online"
                                            ? Colors.green
                                            : widget
                                                        .stationEnergyDataCurrent?[
                                                            index]
                                                        .status ==
                                                    "Offline"
                                                ? Colors.red
                                                : Colors.orange),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.9,
                                        padding: const EdgeInsets.only(
                                            top: defaultPadding),
                                        child: Text(
                                          (widget
                                                  .stationEnergyDataCurrent?[
                                                      index]
                                                  .address) ??
                                              "",
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              ResponsiveRow(
                                  context: context,
                                  basicWidth: 160,
                                  children: [
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('System')}: "),
                                            Text(
                                              widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .apiSystem ??
                                                  "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                          ]),
                                    ),
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('Installed capacity')}: "),
                                            Text(
                                              nf0.format(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .installedCapacity ??
                                                  0),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                            const Text('kWp'),
                                          ]),
                                    ),
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('Current power')}: "),
                                            Text(
                                              nf1.format(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .currentPower ??
                                                  0),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                            const Text('kW'),
                                          ]),
                                    ),
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('Today energy')}: "),
                                            Text(
                                              nf0.format(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .todayEnergy ??
                                                  0),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                            const Text('kWh'),
                                          ]),
                                    ),
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('Total energy')}: "),
                                            Text(
                                              nf0.format(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .totalEnergy ??
                                                  0),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                            const Text('kWh'),
                                          ]),
                                    ),
                                    ResponsiveItem(
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                                "${sharedPref.translate('Peak power')}: "),
                                            Text(
                                              nf0.format(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .peakPower ??
                                                  0),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: largeTextSize,
                                              ),
                                            ),
                                            Text(sharedPref
                                                .translate('Hours')
                                                .toLowerCase()),
                                          ]),
                                    ),
                                  ]),
                            ]),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        : Column(
            children: [
              Container(
                color: kBgColorHeader,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(color: kBgColor, width: 2))),
                        child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding * 2),
                            child: Text(
                              sharedPref.translate("Station name"),
                              softWrap: true,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kContentColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.1,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Status"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("System"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Installed capacity"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Current power"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Today energy"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.06,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 2))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Total energy"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                    Container(
                      height: mediumTextSize * 3,
                      width: screenWidth * 0.05,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          border: Border(
                              right: BorderSide(color: kBgColor, width: 0))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2, 0, defaultPadding * 2, 0),
                        child: Text(
                          sharedPref.translate("Peak power"),
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kContentColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.stationEnergyDataCurrent?.length,
                  itemBuilder: ((context, index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                0, defaultPadding / 5, 0, defaultPadding / 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: index.isOdd ? kBgColorRow1 : null,
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius / 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      (widget
                                                                  .stationEnergyDataCurrent?[
                                                                      index]
                                                                  .name ??
                                                              sharedPref.translate(
                                                                  "(No name)"))
                                                          .toUpperCase(),
                                                      maxLines: 2,
                                                      softWrap: true,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              mediumTextSize)),
                                                  Text(
                                                      widget
                                                              .stationEnergyDataCurrent?[
                                                                  index]
                                                              .address ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize:
                                                              smallTextSize))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.1,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Text(
                                              sharedPref.translate(widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .status ??
                                                  ""),
                                              maxLines: 2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: widget
                                                              .stationEnergyDataCurrent?[
                                                                  index]
                                                              .status ==
                                                          "Online"
                                                      ? Colors.green
                                                      : widget
                                                                  .stationEnergyDataCurrent?[
                                                                      index]
                                                                  .status ==
                                                              "Offline"
                                                          ? Colors.red
                                                          : Colors.orange),
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.06,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Text(
                                              widget
                                                      .stationEnergyDataCurrent?[
                                                          index]
                                                      .apiSystem ??
                                                  "",
                                              maxLines: 2,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.06,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nf1.format(widget
                                                          .stationEnergyDataCurrent?[
                                                              index]
                                                          .installedCapacity ??
                                                      0),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: largeTextSize),
                                                ),
                                                const Text("kWp",
                                                    style: TextStyle(
                                                        fontSize:
                                                            smallTextSize)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.06,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nf1.format((widget
                                                              .stationEnergyDataCurrent?[
                                                                  index]
                                                              .currentPower ??
                                                          0) /
                                                      1000),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: largeTextSize,
                                                  ),
                                                ),
                                                const Text("kW",
                                                    style: TextStyle(
                                                        fontSize:
                                                            smallTextSize)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.06,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nf1.format((widget
                                                              .stationEnergyDataCurrent?[
                                                                  index]
                                                              .todayEnergy ??
                                                          0) /
                                                      1000),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: largeTextSize,
                                                  ),
                                                ),
                                                const Text("kWh",
                                                    style: TextStyle(
                                                        fontSize:
                                                            smallTextSize)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.06,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nf0.format((widget
                                                              .stationEnergyDataCurrent?[
                                                                  index]
                                                              .totalEnergy ??
                                                          0) /
                                                      1000),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: largeTextSize),
                                                ),
                                                const Text("kWh",
                                                    style: TextStyle(
                                                        fontSize:
                                                            smallTextSize)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //
                                        Container(
                                          width: screenWidth * 0.05,
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                defaultPadding * 2,
                                                0,
                                                defaultPadding * 2,
                                                0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nf1.format(widget
                                                          .stationEnergyDataCurrent?[
                                                              index]
                                                          .peakPower ??
                                                      0),
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: largeTextSize),
                                                ),
                                                Text(
                                                    sharedPref
                                                        .translate("Hours")
                                                        .toLowerCase(),
                                                    style: const TextStyle(
                                                        fontSize:
                                                            smallTextSize)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          );
  }
}
