import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../task_filter_screen/bloc/task_filter_bloc.dart';
import '../../task_filter_screen/bloc/task_filter_events.dart';
import '../bloc/task_detail_bloc.dart';
import '../bloc/task_detail_events.dart';
import '../bloc/task_detail_states.dart';

class AddTaskFilterButton extends StatelessWidget {
  const AddTaskFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Add'),
              onPressed: () async {
                if (Responsive.isSmallWidth(context)) {
                  Navigator.of(context)
                      .pushNamed(customRouteMapping.productAdd);
                } else {
                  context
                      .read<TaskFilterBloc>()
                      .add(SelectedFilterItemChanged(''));
                  context.read<TaskDetailBloc>().add(TaskIdChanged(''));
                }
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class AddTaskFilterFloatingButton extends StatelessWidget {
  const AddTaskFilterFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: FloatingActionButton(
              tooltip: sharedPref.translate('Add'),
              backgroundColor: cButtonTextHoverColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: cButtonBorderColor, width: 1.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () async {
                if (Responsive.isSmallWidth(context)) {
                  Navigator.of(context).pushNamed(customRouteMapping.taskAdd);
                } else {
                  context
                      .read<TaskFilterBloc>()
                      .add(SelectedFilterItemChanged(''));
                  context.read<TaskDetailBloc>().add(TaskIdChanged(''));
                }
              },
              child: const Icon(Icons.add, color: kBgColorHeader, size: 30),
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class SaveTaskButton extends StatelessWidget {
  const SaveTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.edit) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Save'),
              onPressed: () async {
                context
                    .read<TaskDetailBloc>()
                    .add(TaskSaving(state.taskDetail));
                if (context.mounted) {
                  context
                      .read<TaskDetailBloc>()
                      .add(TaskIdChanged(state.taskDetail.taskAssignment?.id));
                  context.read<TaskFilterBloc>().add(TaskFilterListLoading());
                }
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class EditTaskButton extends StatelessWidget {
  const EditTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view &&
          state.taskDetail.taskAssignment?.id != null) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Edit'),
              onPressed: () {
                context
                    .read<TaskDetailBloc>()
                    .add(ScreenModeChanged(ScreenModeEnum.edit));
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class DiscardTaskButton extends StatelessWidget {
  const DiscardTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.edit) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Discard'),
              onPressed: () {
                context
                    .read<TaskDetailBloc>()
                    .add(ScreenModeChanged(ScreenModeEnum.view));
                var taskId = state.taskDetail.taskAssignment?.id;
                if (Responsive.isSmallWidth(context)) {
                  if (taskId == null) {
                    Navigator.pop(context);
                  } else {
                    context.read<TaskDetailBloc>().add(TaskIdChanged(taskId));
                  }
                } else {
                  var selectedId =
                      context.read<TaskFilterBloc>().getSelectedId();
                  if (selectedId == '') {
                    context
                        .read<TaskFilterBloc>()
                        .add(SelectedFilterItemChanged(null));
                  } else {
                    context.read<TaskDetailBloc>().add(TaskIdChanged(taskId));
                  }
                }
                // context.read<TaskDetailBloc>().add(TaskDiscardChanges());
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}

class BackTaskButton extends StatelessWidget {
  const BackTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      if (state.screenMode == ScreenModeEnum.view) {
        return Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: CElevatedButton(
              labelText: sharedPref.translate('Back'),
              onPressed: () {
                Navigator.pop(context);
              },
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}
