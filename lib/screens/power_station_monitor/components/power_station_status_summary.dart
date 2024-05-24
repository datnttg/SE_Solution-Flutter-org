import 'package:flutter/material.dart';

import '../../../utilities/classes/power_station_models.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';

class PowerStationStatusSummary extends StatefulWidget {
  final List<StationEnergyDataCurrent>? stationEnergyDataCurrent;
  const PowerStationStatusSummary({super.key, this.stationEnergyDataCurrent});

  @override
  State<PowerStationStatusSummary> createState() =>
      _PowerStationStatusSummaryState();
}

class _PowerStationStatusSummaryState extends State<PowerStationStatusSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding * 3),
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("${sharedPrefs.translate("Total stations")}: ",
                  style: const TextStyle(fontSize: largeTextSize)),
              Expanded(
                child: Text(
                  (widget.stationEnergyDataCurrent?.length ?? 0).toString(),
                  style: const TextStyle(
                      fontSize: largeTextSize, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Row(
            children: [
              Text("${sharedPrefs.translate("Online")}: ",
                  style: const TextStyle(
                      fontSize: largeTextSize, color: Colors.green)),
              Expanded(
                child: Text(
                    "${widget.stationEnergyDataCurrent?.where((e) => e.status == "Online").length ?? 0}",
                    style: const TextStyle(
                        fontSize: largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    textAlign: TextAlign.end),
              )
            ],
          ),
          Row(
            children: [
              Text("${sharedPrefs.translate("Offline")}: ",
                  style: const TextStyle(
                      fontSize: largeTextSize, color: Colors.red)),
              Expanded(
                child: Text(
                    "${widget.stationEnergyDataCurrent?.where((e) => e.status == "Offline").length ?? 0}",
                    style: const TextStyle(
                        fontSize: largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    textAlign: TextAlign.end),
              )
            ],
          ),
          Row(
            children: [
              Text("${sharedPrefs.translate("Abnormal")}: ",
                  style: const TextStyle(
                      fontSize: largeTextSize, color: Colors.orange)),
              Expanded(
                child: Text(
                    "${(widget.stationEnergyDataCurrent?.length ?? 0) - (widget.stationEnergyDataCurrent?.where((e) => e.status == "Online").length ?? 0) - (widget.stationEnergyDataCurrent?.where((e) => e.status == "Offline").length ?? 0)}",
                    style: const TextStyle(
                        fontSize: largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                    textAlign: TextAlign.end),
              )
            ],
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Row(
            children: [
              Text("${sharedPrefs.translate("Alert")}: ",
                  style: const TextStyle(
                      fontSize: largeTextSize, color: Colors.blue)),
              const Expanded(
                child: Text(
                    // "${widget.stationEnergyDataCurrent?.where((e) => e.status == "Alert").length ?? 0}",
                    "N/A",
                    style: TextStyle(
                        fontSize: largeTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                    textAlign: TextAlign.end),
              )
            ],
          )
        ],
      ),
    );
  }
}
