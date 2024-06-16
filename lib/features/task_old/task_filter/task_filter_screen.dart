import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../controllers/task_data_controllers.dart';
import '../services/task_services.dart';
import 'components/task_filter_form.dart';
import 'components/task_list.dart';

class TaskFilterScreen extends StatefulWidget {
  const TaskFilterScreen({super.key});

  @override
  State<TaskFilterScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskFilterScreen>
    with SingleTickerProviderStateMixin {
  final taskFilterController = Get.put(TaskFilterController());
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    refreshTaskList();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var allTasks = taskFilterController.listTask.toList();
      allTasks.sort((a, b) => b['createdTime'].compareTo(a['createdTime']));
      var assignedTasks = allTasks
          .where((e) => e['createdUserId'] == sharedPrefs.getUserId())
          .toList();
      var beAssignedTasks = allTasks
          .where((e) => e['userIdAssigned'] == sharedPrefs.getUserId())
          .toList();
      var otherTasks = allTasks
          .where((e) =>
              e['createdUserId'] != sharedPrefs.getUserId() &&
              e['userIdAssigned'] != sharedPrefs.getUserId())
          .toList();

      return KScaffold(
        drawer: const MainMenu(),
        appBar: AppBar(
          title: Text(
            sharedPrefs.translate('Task management'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: CElevatedButton(
                labelText: sharedPrefs.translate('Create'),
                // buttonType: ButtonType.warning,
                onPressed: () async {
                  final isReload = await Navigator.pushNamed(
                      context, customRouteMapping.taskAdd);
                  if (isReload == true) {
                    refreshTaskList();
                  }
                },
              ),
            )
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: defaultPadding,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: kBgColor,
                  padding: const EdgeInsets.all(defaultPadding),
                  child: const TaskFilterForm(),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: defaultPadding,
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabAlignment: TabAlignment.center,
                    tabs: [
                      Tab(
                          child: Text(
                              '${sharedPrefs.translate("Be assigned")} (${beAssignedTasks.length})',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text(
                              '${sharedPrefs.translate("Assigned")} (${assignedTasks.length})',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text(
                              '${sharedPrefs.translate("Others")} (${otherTasks.length})',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                      Tab(
                          child: Text(
                              '${sharedPrefs.translate("All")} (${allTasks.length})',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Center(
            child: TabBarView(
              controller: _tabController,
              children: [
                TaskList(tasks: beAssignedTasks),
                TaskList(tasks: assignedTasks),
                TaskList(tasks: otherTasks),
                TaskList(tasks: allTasks),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
