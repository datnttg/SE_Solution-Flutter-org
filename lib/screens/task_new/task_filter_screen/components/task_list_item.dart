import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:se_solution_ori/utilities/shared_preferences.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
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
            /// TYPE
            ResponsiveRow(
              context: context,
              children: [
                ResponsiveItem(
                  child: CText(
                    '${dataItem.taskTypeTitle}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: smallTextSize,
                      color: Colors.black,
                    ),
                    wrapText: true,
                  ),
                ),

                /// LAST PROGRESS
                ResponsiveItem(
                  child: CText(
                    '${dataItem.lastProgressText}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: smallTextSize,
                      color: dataItem.lastProgressCode == 'WaitToConfirm'
                          ? Colors.orange
                          : Colors.black,
                    ),
                    wrapText: true,
                  ),
                ),

                /// TITLE
                if (dataItem.taskTitle?.isNotEmpty ?? false)
                  ResponsiveItem(
                    percentWidthOnParent: 100,
                    child: CText(
                      '${dataItem.taskTitle}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                /// SUBJECT NAME
                if ((dataItem.subjects?.length ?? 0) > 0 &&
                    ((dataItem.subjects![0].name?.isNotEmpty ?? false) ||
                        (dataItem.subjects![0].phone?.isNotEmpty ?? false)))
                  ResponsiveItem(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: defaultPadding),
                          child: Icon(
                            Icons.person,
                            size: mediumTextSize,
                          ),
                        ),
                        CText(
                          '${dataItem.subjects?[0].name}',
                          // style: const TextStyle(fontSize: smallTextSize),
                        ),
                      ],
                    ),
                  ),

                /// SUBJECT PHONE
                if ((dataItem.subjects?.length ?? 0) > 0 &&
                    ((dataItem.subjects![0].name?.isNotEmpty ?? false) ||
                        (dataItem.subjects![0].phone?.isNotEmpty ?? false)))
                  ResponsiveItem(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: defaultPadding),
                          child: Icon(
                            Icons.phone,
                            size: mediumTextSize,
                          ),
                        ),
                        CText(
                          '${dataItem.subjects?[0].phone}',
                          // style: const TextStyle(fontSize: smallTextSize),
                        )
                      ],
                    ),
                  ),

                /// DESCRIPTION
                if (dataItem.taskDescription?.isNotEmpty ?? false)
                  ResponsiveItem(
                    percentWidthOnParent: 100,
                    child: CText(
                      '${dataItem.taskDescription}',
                      // style: const TextStyle(fontSize: smallTextSize),
                    ),
                  ),

                /// CREATOR
                ResponsiveItem(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: defaultPadding),
                        child: Icon(
                          Icons.person_add_outlined,
                          size: mediumTextSize,
                        ),
                      ),
                      CText(
                        '${dataItem.createdName}'.capitalize ?? '',
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

                /// DEADLINE
                ResponsiveItem(
                  child: dataItem.deadline != null
                      ? Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: defaultPadding),
                              child: Icon(
                                Icons.av_timer,
                                size: mediumTextSize,
                              ),
                            ),
                            CText(
                              df2.format(
                                  DateTime.parse(dataItem.deadline!).toLocal()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: ([
                                  'Completed',
                                  'Rejected',
                                  'WaitToConfirm'
                                ].any((e) => e == dataItem.lastProgressCode))
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

                /// EXECUTOR
                ResponsiveItem(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: defaultPadding),
                        child: Icon(
                          Icons.how_to_reg_outlined,
                          size: mediumTextSize,
                        ),
                      ),
                      CText(
                        '${dataItem.assignedName}'.capitalize ?? '',
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

                /// STATUS
                ResponsiveItem(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: defaultPadding),
                        child: Icon(
                          Icons.person_outline,
                          size: mediumTextSize,
                        ),
                      ),
                      CText(
                        dataItem.assignedUserId == sharedPref.getUserId()
                            ? sharedPref.translate('Executor')
                            : (dataItem.participants != null
                                ? (dataItem.participants!.any((e) =>
                                        e.participantUserId ==
                                        sharedPref.getUserId())
                                    ? sharedPref.translate('Participant')
                                    : (dataItem.createdUserId ==
                                            sharedPref.getUserId()
                                        ? sharedPref.translate('Creator')
                                        : ''))
                                : ''),
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
