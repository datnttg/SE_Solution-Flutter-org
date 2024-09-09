import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/configs.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/responsive.dart';
import '../../../utilities/shared_preferences.dart';
import 'bloc/task_detail_bloc.dart';
import 'bloc/task_detail_events.dart';
import 'bloc/task_detail_states.dart';
import 'components/task_flow.dart';
import 'models/task_update_model.dart';

class TaskDetailBody extends StatelessWidget {
  const TaskDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        var readOnly = state.taskUpdate.taskAssignment?.id != '' &&
            state.screenMode == ScreenModeEnum.view;
        var showSubject = state.mappingConditions.any((e) =>
            e.conditionValue == state.taskUpdate.taskAssignment?.taskType &&
            e.mappingEntity == 'AppSubject');
        double basicWidth = 360;
        return Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(builder: (context, constrains) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CGroup(
                    child: ResponsiveRow(
                      basicWidth: basicWidth,
                      context: context,
                      children: [
                        /// TYPE
                        ResponsiveItem(
                          percentWidthOnParent:
                              constrains.maxWidth < 3 * basicWidth ? 100 : null,
                          child: CDropdownMenu(
                            labelText: sharedPref.translate('Type'),
                            required: state.screenMode == ScreenModeEnum.edit,
                            readOnly: readOnly,
                            dropdownMenuEntries:
                                state.dropdownData.taskTypes ?? [],
                            selectedMenuEntries: state.dropdownData.taskTypes!
                                .where((e) =>
                                    e.value ==
                                    state.taskUpdate.taskAssignment?.taskType)
                                .toList(),
                            onSelected: (value) {
                              context.read<TaskDetailBloc>().add(
                                  TaskTypeChanged(value.firstOrNull?.value));
                            },
                          ),
                        ),

                        /// CONTACT PHONE
                        if (state.taskUpdate.taskAssignment?.taskType ==
                                'Basic' ||
                            (state.taskUpdate.taskAssignment?.taskTitle
                                    ?.isNotEmpty ??
                                false))
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Title'),
                              required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: readOnly,
                              initialValue:
                                  state.taskUpdate.taskAssignment?.taskTitle ??
                                      '',
                              onChanged: (value) {
                                context
                                    .read<TaskDetailBloc>()
                                    .add(TaskTitleChanged(value));
                              },
                            ),
                          ),

                        /// CONTACT PHONE
                        if (showSubject)
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Phone'),
                              required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: readOnly,
                              autoFocus: state.taskUpdate.subjects?.isEmpty,
                              initialValue:
                                  state.taskUpdate.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskUpdate.subjects?[0].phone,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskUpdate.subjects?[0]
                                              .copyWith(phone: value) ??
                                          TaskSubjectUpdateModel()
                                    ]));
                              },
                            ),
                          ),

                        /// CONTACT NAME
                        if (showSubject)
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Name'),
                              required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: readOnly,
                              initialValue:
                                  state.taskUpdate.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskUpdate.subjects?[0].name,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskUpdate.subjects?[0]
                                              .copyWith(name: value) ??
                                          TaskSubjectUpdateModel()
                                    ]));
                              },
                            ),
                          ),

                        /// CONTACT ADDRESS
                        if (showSubject)
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 4 * basicWidth
                                    ? 100
                                    : null,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Address'),
                              readOnly: readOnly,
                              initialValue:
                                  state.taskUpdate.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskUpdate.subjects?[0].address,
                              onChanged: (value) {
                                context
                                    .read<TaskDetailBloc>()
                                    .add(TaskContactPointsChanged([
                                      state.taskUpdate.subjects?[0]
                                              .copyWith(address: value) ??
                                          TaskSubjectUpdateModel()
                                    ]));
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  CGroup(
                    child: ResponsiveRow(
                      basicWidth: basicWidth,
                      context: context,
                      children: [
                        /// DESCRIPTION
                        if (state.screenMode == ScreenModeEnum.edit ||
                            state.taskUpdate.taskAssignment?.id == null ||
                            (state.taskUpdate.taskAssignment?.taskDescription
                                    ?.isNotEmpty ??
                                false))
                          ResponsiveItem(
                            percentWidthOnParent: 100,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Description'),
                              maxLines: 5,
                              readOnly: readOnly,
                              autoFocus: state.taskUpdate.subjects?.isEmpty,
                              initialValue:
                                  state.taskUpdate.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskUpdate.subjects?[0].phone,
                              onChanged: (value) {
                                context
                                    .read<TaskDetailBloc>()
                                    .add(TaskDescriptionChanged(value));
                              },
                            ),
                          ),

                        /// BEGINNING DATE
                        ResponsiveItem(
                          percentWidthOnParent:
                              constrains.maxWidth < 3 * basicWidth ? 100 : null,
                          child: CTextFormField(
                            labelText: sharedPref.translate('Beginning date'),
                            readOnly: readOnly,
                            initialValue: state.taskUpdate.taskAssignment
                                        ?.beginningDateTime !=
                                    null
                                ? df2.format(state.taskUpdate.taskAssignment!
                                    .beginningDateTime!)
                                : '',
                            onChanged: (value) {
                              context
                                  .read<TaskDetailBloc>()
                                  .add(TaskBeginningTimeChanged(value));
                            },
                            suffix: state.screenMode == ScreenModeEnum.edit
                                ? IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () {},
                                  )
                                : null,
                          ),
                        ),

                        /// DEADLINE
                        ResponsiveItem(
                          percentWidthOnParent:
                              constrains.maxWidth < 3 * basicWidth ? 100 : null,
                          child: CTextFormField(
                            labelText: sharedPref.translate('Deadline'),
                            required: state.screenMode == ScreenModeEnum.edit,
                            readOnly: readOnly,
                            initialValue: state
                                        .taskUpdate.taskAssignment?.deadline !=
                                    null
                                ? df2.format(
                                    state.taskUpdate.taskAssignment!.deadline!)
                                : '',
                            onChanged: (value) {
                              context
                                  .read<TaskDetailBloc>()
                                  .add(TaskDeadlineChanged(value));
                            },
                            suffix: state.screenMode == ScreenModeEnum.edit
                                ? IconButton(
                                    icon: const Icon(Icons.calendar_month),
                                    onPressed: () {},
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// OBJECTS
                  CGroup(
                    titleText: sharedPref.translate('Objects'),
                    child: ResponsiveRow(
                      basicWidth: basicWidth,
                      context: context,
                      children: [
                        /// CREATOR
                        if (state.taskUpdate.taskAssignment?.id != null)
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                            child: CDropdownMenu(
                              labelText: sharedPref.translate('Creator'),
                              required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: true,
                              dropdownMenuEntries:
                                  state.dropdownData.creators ?? [],
                              selectedMenuEntries:
                                  state.dropdownData.creators != null
                                      ? state.dropdownData.creators!
                                          .where((e) =>
                                              e.value ==
                                              state.taskDetail.taskAssignment
                                                  ?.createdUserId)
                                          .toList()
                                      : [],
                            ),
                          ),

                        /// IN-CHARGE USER
                        ResponsiveItem(
                          percentWidthOnParent:
                              constrains.maxWidth < 3 * basicWidth ? 100 : null,
                          child: CDropdownMenu(
                            labelText: sharedPref.translate('In charge'),
                            required: state.screenMode == ScreenModeEnum.edit,
                            readOnly: readOnly,
                            dropdownMenuEntries:
                                state.dropdownData.assignedUsers ?? [],
                            selectedMenuEntries:
                                state.dropdownData.assignedUsers != null
                                    ? state.dropdownData.assignedUsers!
                                        .where((e) =>
                                            e.value ==
                                            state.taskUpdate.taskAssignment
                                                ?.assignedUserId)
                                        .toList()
                                    : [],
                            onSelected: (selections) {
                              context.read<TaskDetailBloc>().add(
                                  TaskAssignedUsersChanged(selections
                                      .map<String>((e) => e.value)
                                      .toList()));
                            },
                          ),
                        ),

                        /// PARTICIPANTS
                        ResponsiveItem(
                          percentWidthOnParent:
                              constrains.maxWidth < 3 * basicWidth ? 100 : null,
                          child: CDropdownMenu(
                            labelText: sharedPref.translate('Participants'),
                            multiSelect: true,
                            // wrap: true,
                            readOnly: readOnly,
                            dropdownMenuEntries:
                                state.dropdownData.participants ?? [],
                            selectedMenuEntries: state
                                        .dropdownData.participants !=
                                    null
                                ? state.dropdownData.participants!
                                    .where((e) => (state.taskUpdate.participants
                                            ?.any((i) => i.userId == e.value) ??
                                        false))
                                    .toList()
                                : [],
                            onSelected: (selections) {
                              context.read<TaskDetailBloc>().add(
                                  TaskParticipantsChanged(selections
                                      .map<TaskParticipantUpdateModel>((e) =>
                                          TaskParticipantUpdateModel(
                                              userId: e.value))
                                      .toList()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// TASK FLOW
                  if (state.taskUpdate.taskAssignment?.id != null)
                    CGroup(
                      titleText: sharedPref.translate('History'),
                      child: Container(
                          constraints: const BoxConstraints(maxHeight: 300),
                          child: TaskFlows(flows: state.taskDetail.flows)),
                    ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
