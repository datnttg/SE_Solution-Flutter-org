import 'package:flutter/material.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../models/task_filter_item_model.dart';
import 'task_list_item.dart';

class TaskList extends StatelessWidget {
  final List<TaskFilterItemModel> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(
        child: SelectableText('(${sharedPrefs.translate('Empty list')})'),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: kBgColor,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: index.isEven ? kBgColorRow1 : null,
                      borderRadius: BorderRadius.circular(defaultRadius)),
                  child: TaskListItem(
                    dataItem: tasks[index],
                  ),
                ),
              );
            }),
      );
    }
  }
}
