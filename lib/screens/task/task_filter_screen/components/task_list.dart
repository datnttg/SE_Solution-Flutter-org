import 'package:flutter/material.dart';

import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../models/task_filter_item_model.dart';
import 'task_list_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.list});

  final List<TaskFilterItemModel> list;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Container(
        color: Colors.white,
        child: Center(
          child: SelectableText('(${sharedPref.translate('Empty list')})'),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: kBgColor,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: defaultPadding, right: defaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                      color: index.isEven ? kBgColorRow1 : null,
                      borderRadius: BorderRadius.circular(defaultRadius)),

                  /// PRODUCT ITEM
                  child: TaskListItem(dataItem: list[index]),
                ),
              );
            }),
      );
    }
  }
}
