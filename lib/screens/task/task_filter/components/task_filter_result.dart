import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se_solution/utilities/shared_preferences.dart';
import 'package:se_solution/utilities/ui_styles.dart';
import '../../controllers/task_data_controllers.dart';
import 'task_list.dart';

class TaskFilterResult extends StatefulWidget {
  const TaskFilterResult({super.key});

  @override
  State<TaskFilterResult> createState() => _TaskFilterResultState();
}

class _TaskFilterResultState extends State<TaskFilterResult>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  var taskFilterController = Get.find<TaskFilterController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var allTasks = taskFilterController.listTask;
    allTasks.sort((a, b) => b['createdTime'].compareTo(a['createdTime']));
    var assignedTasks = allTasks
        .where((e) => e['createdUserId'] == sharedPrefs.getUserId())
        .toList();
    var beAssignedTasks = allTasks
        .where((e) => e['userIdAssigned'] == sharedPrefs.getUserId())
        .toList();

    return Obx(() => Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                    child: Text(
                        '${sharedPrefs.translate("All")} (${allTasks.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                Tab(
                    child: Text(
                        '${sharedPrefs.translate("Be assigned")} (${beAssignedTasks.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                Tab(
                    child: Text(
                        '${sharedPrefs.translate("Assigned")} (${assignedTasks.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TaskList(tasks: allTasks),
                  TaskList(tasks: beAssignedTasks),
                  TaskList(tasks: assignedTasks),
                ],
              ),
            )
          ],
        ));
  }
}
