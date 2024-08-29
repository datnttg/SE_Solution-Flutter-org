import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../task_detail_screen/bloc/task_detail_bloc.dart';
import '../../task_detail_screen/bloc/task_detail_events.dart';
import '../bloc/task_filter_bloc.dart';
import '../bloc/task_filter_events.dart';
import '../models/task_filter_item_model.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key, required this.dataItem});

  final TaskFilterItemModel dataItem;

  @override
  Widget build(BuildContext context) {
    String? beginningDateTime =
        dataItem.beginningDateTime ?? dataItem.createdTime;
    var duration = (dataItem.deadline != null && beginningDateTime != null)
        ? DateTime.parse(dataItem.deadline!)
            .difference(DateTime.parse(beginningDateTime))
        : null;
    var percentPass = (beginningDateTime != null && duration != null)
        ? DateTime.now()
                .difference(DateTime.parse(beginningDateTime!))
                .inMinutes /
            duration.inMinutes
        : 0;

    return InkWell(
      onTap: () async {
        debugPrint('Selected taskId: ${dataItem.taskId}');
        if (Responsive.isSmallWidth(context)) {
          var isReload = await Navigator.pushNamed(
            context,
            '${customRouteMapping.taskDetail}/${dataItem.taskId}',
          );
          if (isReload == true && context.mounted) {
            context.read<TaskFilterBloc>().add(InitTaskFilterData());
          }
        } else if (context.mounted) {
          context
              .read<TaskFilterBloc>()
              .add(SelectedFilterItemChanged(dataItem.taskId));
          context.read<TaskDetailBloc>().add(TaskIdChanged(dataItem.taskId));
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
                  child: CText(
                    '${dataItem.taskTitle}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPref.translate('Type')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.taskTypeTitle}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        wrapText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: dataItem.deadline != null
                      ? Row(
                          children: [
                            CText('${sharedPref.translate('Deadline')}: ',
                                style:
                                    const TextStyle(fontSize: smallTextSize)),
                            CText(
                              df2.format(
                                  DateTime.parse(dataItem.deadline!).toLocal()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: (dataItem.lastProgressCode ==
                                            'Completed' ||
                                        dataItem.lastProgressCode == 'Rejected')
                                    ? Colors.black
                                    : percentPass >= 1
                                        ? Colors.red
                                        : percentPass >= 0.9
                                            ? Colors.orange
                                            : Colors.black,
                              ),
                              wrapText: true,
                            )
                          ],
                        )
                      : Container(),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPref.translate('Creator')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.createdName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        wrapText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPref.translate('Executor')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.assignedName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: Colors.black,
                        ),
                        wrapText: true,
                      )
                    ],
                  ),
                ),
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPref.translate('Status')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.taskStatusText}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: dataItem.taskStatusCode == "Completed"
                              ? Colors.green
                              : dataItem.taskStatusCode == "WaitToConfirm"
                                  ? Colors.orange
                                  : dataItem.taskStatusCode == "Rejected"
                                      ? Colors.grey
                                      : Colors.black,
                        ),
                        wrapText: true,
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
                //               CText('${dataItem['taskDescription'] ?? '-'}'))
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
