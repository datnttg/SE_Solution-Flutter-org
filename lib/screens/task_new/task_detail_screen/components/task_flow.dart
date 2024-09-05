import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se_solution_ori/utilities/custom_widgets.dart';
import 'package:se_solution_ori/utilities/ui_styles.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/responsive.dart';
import '../models/task_detail_model.dart';

class TaskFlows extends StatelessWidget {
  final List<TaskFlowDetailModel>? flows;

  const TaskFlows({super.key, required this.flows});

  @override
  Widget build(BuildContext context) {
    if (flows != null) {
      flows!.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    }
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: flows?.length ?? 0,
          itemBuilder: (item, index) {
            if (flows == null) {
              return Container();
            } else {
              return TaskFlowItem(item: flows![index]);
            }
          }),
    );
  }
}

class TaskFlowItem extends StatelessWidget {
  final TaskFlowDetailModel item;

  const TaskFlowItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: defaultPadding * 3, bottom: defaultPadding * 3),
      child: Row(
        children: [
          const Icon(Icons.history),
          const SizedBox(width: defaultPadding * 2),
          Expanded(
            child: ResponsiveRow(
              context: context,
              basicWidth: 10,
              children: [
                ResponsiveItem(
                  percentWidthOnParent: 50,
                  child: CText(
                    item.actionText,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: smallTextSize),
                  ),
                ),
                ResponsiveItem(
                  percentWidthOnParent: 50,
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      CText(
                        item.progressStatusText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: smallTextSize,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                if (item.taskFlowDescription != null)
                  ResponsiveItem(
                    percentWidthOnParent: 100,
                    child: CText(item.taskFlowDescription!),
                  ),
                ResponsiveItem(
                  percentWidthOnParent: 50,
                  child: CText(
                    item.createdUserName.capitalize!,
                    style: const TextStyle(
                        fontSize: smallTextSize, color: Colors.grey),
                  ),
                ),
                ResponsiveItem(
                  percentWidthOnParent: 50,
                  child: Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      CText(
                        df2.format(item.createdTime),
                        style: const TextStyle(
                            fontSize: smallTextSize, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
