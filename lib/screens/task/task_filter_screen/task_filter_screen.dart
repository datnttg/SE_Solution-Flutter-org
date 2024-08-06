import 'package:flutter/material.dart';
import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import 'bloc/task_filter_bloc.dart';
import 'components/task_filter_form.dart';
import 'components/task_list.dart';
import 'models/task_filter_item_model.dart';

class TaskFilterScreen extends StatefulWidget {
  const TaskFilterScreen({super.key});

  @override
  State<TaskFilterScreen> createState() => _TaskFilterScreenState();
}

class _TaskFilterScreenState extends State<TaskFilterScreen>
    with SingleTickerProviderStateMixin {
  final TaskFilterBloc bloc = TaskFilterBloc();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    bloc.loadData();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  List<TaskFilterItemModel> allTasks = [];
  List<TaskFilterItemModel> waitToConfirm = [];
  List<TaskFilterItemModel> notCompleted = [];
  List<TaskFilterItemModel> completed = [];
  List<TaskFilterItemModel> rejected = [];

  @override
  Widget build(BuildContext context) {
    bloc.stateController.stream.listen((data) {
      setState(() {
        allTasks = data.taskList ?? [];
        if (allTasks.isNotEmpty) {
          allTasks.sort((a, b) => b.createdTime == null
              ? -1
              : a.createdTime == null
                  ? 1
                  : b.createdTime!.compareTo(a.createdTime!));
        }
        waitToConfirm = allTasks
            .where((e) => ['WaitToConfirm'].any((u) => u == e.taskStatusCode))
            .toList();
        completed = allTasks
            .where((e) => ['Completed'].any((u) => u == e.taskStatusCode))
            .toList();
        rejected = allTasks
            .where((e) => ['Rejected'].any((u) => u == e.taskStatusCode))
            .toList();
        notCompleted = allTasks
            .where((e) => !['WaitToConfirm', 'Completed', 'Rejected']
                .any((u) => u == e.taskStatusCode))
            .toList();
      });
    });

    /// RETURN WIDGET
    return CScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Task'),
            style: const TextStyle(
                fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPrefs.translate('Create'),
              onPressed: () async {
                final isReload = await Navigator.pushNamed(
                    context, customRouteMapping.taskAdd);
                if (isReload == true) {
                  bloc.loadData();
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
                height: defaultPadding * 2,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: kBgColor,
                padding: const EdgeInsets.all(defaultPadding),
                child: TaskFilterForm(bloc: bloc),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: defaultPadding * 2,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
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
                            '${sharedPrefs.translate("Not completed")} (${notCompleted.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Wait to confirm")} (${waitToConfirm.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Completed")} (${completed.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("Rejected")} (${rejected.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Tab(
                        child: Text(
                            '${sharedPrefs.translate("All")} (${allTasks.length})',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: TabBarView(
            controller: _tabController,
            children: [
              TaskList(list: notCompleted),
              TaskList(list: waitToConfirm),
              TaskList(list: completed),
              TaskList(list: rejected),
              TaskList(list: allTasks),
            ],
          ),
        ),
      ),
    );
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
