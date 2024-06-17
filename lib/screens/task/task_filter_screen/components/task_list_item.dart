import 'package:flutter/material.dart';
import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/task_filter_bloc.dart';
import '../models/task_filter_item_model.dart';

class TaskListItem extends StatelessWidget {
  final TaskFilterItemModel dataItem;

  const TaskListItem({super.key, required this.dataItem});

  @override
  Widget build(BuildContext context) {
    var bloc = TaskFilterBloc();
    var beginningDateTime =
        dataItem.beginningDateTime ?? dataItem.createdTime ?? '';
    var duration = DateTime.parse(dataItem.deadline ?? '')
        .difference(DateTime.parse(beginningDateTime));
    var percentPass =
        DateTime.now().difference(DateTime.parse(beginningDateTime)).inMinutes /
            duration.inMinutes;

    return InkWell(
      onTap: () async {
        final isReload = await Navigator.pushNamed(
          context, '${customRouteMapping.taskDetail}/${dataItem.taskId}',
          // arguments: {"taskId": dataItem["taskId"]},
        );
        if (isReload == true) {
          bloc.loadData();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding * 2),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            ResponsiveRow(
              context: context,
              basicWidth: Responsive.isSmallWidth(context) == true ? 180 : 240,
              children: [
                /// TASK TYPE
                ResponsiveItem(
                  // percentWidthOnParent: 100,
                  child: Row(
                    children: [
                      // CText('${sharedPrefs.translate('Type')}: ',
                      //     style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.taskTypeTitle}',
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

                /// STATUS
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPrefs.translate('Status')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.taskStatusText}',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: smallTextSize,
                          color: dataItem.taskStatusCode == "Completed"
                              ? Colors.green
                              : dataItem.taskStatusCode == "WaitToConfirm"
                                  ? Colors.orange
                                  : dataItem.taskStatusCode == "Rejected"
                                      ? Colors.grey
                                      : Colors.black,
                        ),
                        warpText: true,
                      )
                    ],
                  ),
                ),

                // /// CREATOR
                // ResponsiveItem(
                //   child: Row(
                //     children: [
                //       CText('${sharedPrefs.translate('Creator')}: ',
                //           style: const TextStyle(fontSize: smallTextSize)),
                //       CText(
                //         '${dataItem.createdName}',
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: smallTextSize,
                //           color: Colors.black,
                //         ),
                //         warpText: true,
                //       )
                //     ],
                //   ),
                // ),

                /// EXECUTOR
                ResponsiveItem(
                  child: Row(
                    children: [
                      CText('${sharedPrefs.translate('Executor')}: ',
                          style: const TextStyle(fontSize: smallTextSize)),
                      CText(
                        '${dataItem.assignedName}',
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

                /// DEADLINE
                ResponsiveItem(
                  child: dataItem.deadline != null
                      ? Row(
                          children: [
                            CText('${sharedPrefs.translate('Deadline')}: ',
                                style:
                                    const TextStyle(fontSize: smallTextSize)),
                            CText(
                              df2.format(DateTime.parse(dataItem.deadline ?? '')
                                  .toLocal()),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: smallTextSize,
                                color: (dataItem.taskStatusCode ==
                                            'Completed' ||
                                        dataItem.taskStatusCode == 'Rejected')
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

                /// TITLE
                ResponsiveItem(
                  widthRatio: 2,
                  child: dataItem.taskTitle == null
                      ? Container()
                      : CText('${dataItem.taskTitle}'),
                ),

                /// DESCRIPTION
                ResponsiveItem(
                  widthRatio: 2,
                  child: dataItem.taskDescription == null
                      ? Container()
                      : CText('${dataItem.taskDescription}'),
                ),

                /// SUBJECTS
                dataItem.subjects?.isNotEmpty == true
                    ? ResponsiveItem(
                        percentWidthOnParent: 100,
                        child: Row(
                          children: [
                            for (var e in dataItem.subjects ?? [])
                              Row(
                                children: [
                                  e.phone != null
                                      ? CText('${e.name} (${e.phone})')
                                      : Container(),
                                ],
                              ),
                            const SizedBox(width: 20)
                          ],
                        ),
                      )
                    : ResponsiveItem(
                        percentWidthOnParent: 0,
                        child: Container(),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
