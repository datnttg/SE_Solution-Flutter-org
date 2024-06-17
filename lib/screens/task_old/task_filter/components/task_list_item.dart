import 'package:flutter/material.dart';
import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../services/task_services.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.dataItem});

  final Map dataItem;

  @override
  Widget build(BuildContext context) {
    String beginningDateTime =
        dataItem['beginningDateTime'] ?? dataItem['createdTime'];
    var duration = DateTime.parse(dataItem['deadline'])
        .difference(DateTime.parse(beginningDateTime));
    var percentPass =
        DateTime.now().difference(DateTime.parse(beginningDateTime)).inMinutes /
            duration.inMinutes;

    return InkWell(
      onTap: () async {
        final isReload = await Navigator.pushNamed(
          context, '${customRouteMapping.taskDetail}/${dataItem["taskId"]}',
          // arguments: {"taskId": dataItem["taskId"]},
        );
        if (isReload == true) {
          refreshTaskList();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            ResponsiveRow(
              context: context,
              children: [
                ResponsiveItem(
                  percentWidthOnParent: 100,
                  child: KText(
                    '${dataItem['taskTitle']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      KText('${sharedPrefs.translate('Type')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      KText(
                        '${dataItem['taskTypeTitle']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: dataItem['deadline'] != null
                      ? Row(
                          children: [
                            KText('${sharedPrefs.translate('Deadline')}: ',
                                style:
                                    const TextStyle(fontSize: smallTextSize)),
                            KText(
                              df2.format(DateTime.parse(dataItem['deadline'])
                                  .toLocal()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: (dataItem['taskStatus'] == 'Completed' ||
                                        dataItem['taskStatus'] == 'Rejected')
                                    ? Colors.black
                                    : percentPass >= 1
                                        ? Colors.red
                                        : percentPass >= 0.9
                                            ? Colors.orange
                                            : Colors.black,
                              ),
                              warpText: true,
                            )
                          ],
                        )
                      : Container(),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      KText('${sharedPrefs.translate('Creator')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      KText(
                        '${dataItem['createdName']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      KText('${sharedPrefs.translate('Executor')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      KText(
                        '${dataItem['assignedName']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      KText('${sharedPrefs.translate('Status')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      KText(
                        '${dataItem['taskStatusText']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: dataItem['taskStatus'] == "Completed"
                              ? Colors.green
                              : dataItem['taskStatus'] == "WaitToConfirm"
                                  ? Colors.orange
                                  : dataItem['taskStatus'] == "Rejected"
                                      ? Colors.grey
                                      : Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),
                // ResponsiveItem(
                //   percentWidthOfParent: 100,
                //   child: Row(
                //     children: [
                //       Flexible(
                //           child:
                //               KText('${dataItem['taskDescription'] ?? '-'}'))
                //     ],
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
