import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import 'bloc/task_filter_bloc.dart';
import 'bloc/task_filter_events.dart';
import 'bloc/task_filter_states.dart';
import 'components/task_filter_form.dart';
import 'components/task_list.dart';

class TaskFilterBody extends StatefulWidget {
  const TaskFilterBody({super.key});

  @override
  State<TaskFilterBody> createState() => _TaskFilterBodyState();
}

class _TaskFilterBodyState extends State<TaskFilterBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    context.read<TaskFilterBloc>().add(InitTaskFilterData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskFilterBloc, TaskFilterState>(
      builder: (context, state) {
        var all = state.tasks ?? [];
        if (all.isNotEmpty) {
          all.sort((a, b) => b.createdTime == null
              ? -1
              : a.createdTime == null
                  ? 1
                  : b.createdTime!.compareTo(a.createdTime!));
        }
        var beAssignedTasks = all
            .where((e) =>
                e.assignedUserId == sharedPref.getUserId() ||
                (e.participants?.any(
                        (i) => i.participantUserId == sharedPref.getUserId()) ??
                    false))
            .toList();
        var inCharge = beAssignedTasks
            .where((e) => e.assignedUserId == sharedPref.getUserId())
            .toList();
        var joinIn = beAssignedTasks
            .where((e) =>
                e.participants?.any(
                    (i) => i.participantUserId == sharedPref.getUserId()) ??
                false)
            .toList();
        var assignedTasks = all
            .where((e) => e.createdUserId == sharedPref.getUserId())
            .toList();
        var otherTasks = all
            .where((e) =>
                e.assignedUserId != sharedPref.getUserId() &&
                e.createdUserId != sharedPref.getUserId())
            .toList();
        return RefreshIndicator(
          onRefresh: () async {
            return context.read<TaskFilterBloc>().add(TaskFilterSubmitted());
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverToBoxAdapter(
                  /// TASK FILTER FORM
                  child: TaskFilterForm(),
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
                                '${sharedPref.translate("Be assigned")} (${beAssignedTasks.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Tab(
                            child: Text(
                                '${sharedPref.translate("In charge")} (${inCharge.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Tab(
                            child: Text(
                                '${sharedPref.translate("Join in")} (${joinIn.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Tab(
                            child: Text(
                                '${sharedPref.translate("Assigned")} (${assignedTasks.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Tab(
                            child: Text(
                                '${sharedPref.translate("Others")} (${otherTasks.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
                        Tab(
                            child: Text(
                                '${sharedPref.translate("All")} (${all.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))),
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
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: beAssignedTasks)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: inCharge)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: joinIn)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: assignedTasks)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: otherTasks)
                      : const Center(child: CircularProgressIndicator()),
                  state.loadingStatus == ProcessingStatusEnum.success
                      ? TaskList(list: all)
                      : const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        );
      },
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
