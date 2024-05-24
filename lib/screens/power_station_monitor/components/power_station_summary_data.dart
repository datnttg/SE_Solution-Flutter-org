import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../assets/asset_helper.dart';
import '../../../utilities/classes/power_station_models.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';

class PowerStationSummaryData extends StatefulWidget {
  final List<StationEnergyDataCurrent>? stationEnergyDataCurrent;
  const PowerStationSummaryData({super.key, this.stationEnergyDataCurrent});

  @override
  State<PowerStationSummaryData> createState() =>
      _PowerStationSummaryDataState();
}

class _PowerStationSummaryDataState extends State<PowerStationSummaryData> {
  @override
  Widget build(BuildContext context) {
    var nf0 = NumberFormat("#,##0", sharedPrefs.getLocale().toString());
    double todayEnergy = 0;
    for (var i = 0; i < (widget.stationEnergyDataCurrent?.length ?? 0); i++) {
      todayEnergy += widget.stationEnergyDataCurrent?[i].todayEnergy ?? 0;
    }
    double installedCapacity = 0;
    for (var i = 0; i < (widget.stationEnergyDataCurrent?.length ?? 0); i++) {
      installedCapacity +=
          widget.stationEnergyDataCurrent?[i].installedCapacity ?? 0;
    }
    double currentPower = 0;
    for (var i = 0; i < (widget.stationEnergyDataCurrent?.length ?? 0); i++) {
      currentPower += widget.stationEnergyDataCurrent?[i].currentPower ?? 0;
    }
    double totalEnergy = 0;
    for (var i = 0; i < (widget.stationEnergyDataCurrent?.length ?? 0); i++) {
      totalEnergy += widget.stationEnergyDataCurrent?[i].totalEnergy ?? 0;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                AssetHelper.logoPortrait,
                height: 80,
                width: 80,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sharedPrefs.translate("Installed capacity")),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          nf0.format(installedCapacity),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: largeTextSize),
                        ),
                        const Text("kWp")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(sharedPrefs.translate("Current power")),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          nf0.format(currentPower / 1000),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: largeTextSize),
                        ),
                        const Text("kW")
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(defaultPadding * 3, 0,
                    defaultPadding * 3, defaultPadding * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(sharedPrefs.translate("Today energy")),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          nf0.format(todayEnergy / 1000),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: largeTextSize),
                        ),
                        const Text("kWh"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(defaultPadding * 3, 0,
                  defaultPadding * 3, defaultPadding * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sharedPrefs.translate("Total energy")),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        nf0.format(totalEnergy / 1000),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: largeTextSize),
                      ),
                      const Text("kWh")
                    ],
                  ),
                ],
              ),
            ))
          ],
        )
      ],
    );
  }
}
