import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import 'bloc/task_detail_bloc.dart';
import 'bloc/task_detail_events.dart';
import 'bloc/task_detail_states.dart';
import 'components/task_detail_action_button.dart';
import 'task_detail_body.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, this.taskId});

  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskDetailBloc(),
      child: Container(
        color: cAppBarColor,
        child: SafeArea(
          child: CScaffold(
            drawer: const MainMenu(),
            appBar: AppBar(
              title: Text(sharedPref.translate('Task information'),
                  style: const TextStyle(
                      fontSize: mediumTextSize * 1.2,
                      fontWeight: FontWeight.bold)),
              actions: [
                Responsive.isMobileAndPortrait(context)
                    ? const SizedBox()
                    : const Row(
                        children: [
                          SaveTaskButton(),
                          EditTaskButton(),
                          DiscardTaskButton(),
                          BackTaskButton(),
                        ],
                      ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return BlocSelector<TaskDetailBloc, TaskDetailState,
                          ProcessingStatusEnum>(
                        selector: (state) => state.loadingStatus,
                        builder: (context, loadingStatus) {
                          switch (loadingStatus) {
                            case ProcessingStatusEnum.success:

                              /// TASK DETAIL BODY
                              return const TaskDetailBody();
                            default:
                              context
                                  .read<TaskDetailBloc>()
                                  .add(TaskIdChanged(taskId ?? ''));
                              return const Center(
                                  child: CircularProgressIndicator());
                          }
                        },
                      );
                    },
                  ),
                ),
                !Responsive.isMobileAndPortrait(context)
                    ? const SizedBox()
                    : Container(
                        color: cBottomBarColor,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// BOTTOM BUTTONS
                            SaveTaskButton(),
                            EditTaskButton(),
                            DiscardTaskButton(),
                            BackTaskButton(),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
