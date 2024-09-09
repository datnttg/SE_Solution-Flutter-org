import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../task_detail_screen/bloc/task_detail_bloc.dart';
import '../task_detail_screen/bloc/task_detail_states.dart';
import '../task_detail_screen/components/task_detail_action_button.dart';
import '../task_detail_screen/task_detail_body.dart';
import 'bloc/task_filter_bloc.dart';
import 'bloc/task_filter_events.dart';
import 'bloc/task_filter_states.dart';
import 'task_filter_body.dart';

class TaskFilterScreen extends StatelessWidget {
  const TaskFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    /// RETURN WIDGET
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskFilterBloc>(create: (_) => TaskFilterBloc()),
        BlocProvider<TaskDetailBloc>(create: (_) => TaskDetailBloc()),
      ],
      child: CScaffold(
        drawer: const MainMenu(),
        appBar: AppBar(
          title: Text(sharedPref.translate('Task'),
              style: const TextStyle(
                  fontSize: mediumTextSize * 1.2, fontWeight: FontWeight.bold)),
          actions: [
            if (!Responsive.isMobileAndPortrait(context))
              const AddTaskFilterButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const EditTaskButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const SaveTaskButton(),
            if (!Responsive.isMobileAndPortrait(context))
              const DiscardTaskButton(),
          ],
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
                maxWidth: double.infinity,
              ),
              child: BlocBuilder<TaskFilterBloc, TaskFilterState>(
                builder: (context, state) {
                  bool isSmallWidthAndActive =
                      Responsive.isSmallWidth(context) &&
                          state.selectedId != null;
                  switch (state.initialStatus) {
                    case ProcessingStatusEnum.success:
                      return Row(
                        children: [
                          const Expanded(
                            /// FILTER BODY
                            child: TaskFilterBody(),
                          ),
                          if (!Responsive.isSmallWidth(context))
                            const SizedBox(
                              width: defaultPadding * 2,
                            ),
                          if (!Responsive.isSmallWidth(context) ||
                              isSmallWidthAndActive)
                            BlocSelector<TaskFilterBloc, TaskFilterState,
                                    String?>(
                                selector: (state) => state.selectedId,
                                builder: (context, selectedId) {
                                  return SizedBox(
                                    width: screenWidth -
                                        (isSmallWidthAndActive == false
                                            ? 450
                                            : 0),
                                    child: selectedId == null
                                        ? Center(
                                            child: SizedBox(
                                                child: Text(sharedPref.translate(
                                                    'Please select an item'))))
                                        : BlocBuilder<TaskDetailBloc,
                                            TaskDetailState>(
                                            builder: (context, state) {
                                              switch (state.loadingStatus) {
                                                case ProcessingStatusEnum
                                                      .success:

                                                  /// DETAIL BODY
                                                  return const TaskDetailBody();
                                                default:
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                              }
                                            },
                                          ),
                                  );
                                }),
                        ],
                      );
                    default:
                      context.read<TaskFilterBloc>().add(InitTaskFilterData());
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }
                },
              ),
            ),

            /// ADD PRODUCT BUTTON
            if (Responsive.isMobileAndPortrait(context))
              const Positioned(
                bottom: 50,
                right: 50,
                child: AddTaskFilterFloatingButton(),
              ),
          ],
        ),
      ),
    );
  }
}
