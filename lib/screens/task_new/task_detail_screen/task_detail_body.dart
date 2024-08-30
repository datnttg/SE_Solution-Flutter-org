import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution_ori/screens/task_new/task_detail_screen/models/task_detail_model.dart';
import 'package:se_solution_ori/utilities/configs.dart';
import 'package:se_solution_ori/utilities/custom_widgets.dart';
import 'package:se_solution_ori/utilities/responsive.dart';

import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/shared_preferences.dart';
import 'bloc/task_detail_bloc.dart';
import 'bloc/task_detail_events.dart';
import 'bloc/task_detail_states.dart';

class TaskDetailBody extends StatelessWidget {
  const TaskDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        var readOnly = state.taskDetail.taskAssignment?.id != '' &&
            state.screenMode == ScreenModeEnum.view;
        var showSubject = state.mappingConditions.any((e) =>
            e.conditionValue == state.taskDetail.taskAssignment?.taskType &&
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
                                    state.taskDetail.taskAssignment?.taskType)
                                .toList(),
                            onSelected: (value) {
                              context.read<TaskDetailBloc>().add(
                                  TaskTypeChanged(value.firstOrNull?.value));
                            },
                          ),
                        ),

                        /// CONTACT PHONE
                        if (state.taskDetail.taskAssignment?.taskType ==
                                'Basic' ||
                            (state.taskDetail.taskAssignment?.taskTitle
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
                                  state.taskDetail.taskAssignment?.taskTitle ??
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
                              autoFocus: state.taskDetail.subjects?.isEmpty,
                              initialValue:
                                  state.taskDetail.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskDetail.subjects?[0].phone,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskDetail.subjects?[0]
                                              .copyWith(phone: value) ??
                                          Subject()
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
                                  state.taskDetail.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskDetail.subjects?[0].name,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskDetail.subjects?[0]
                                              .copyWith(name: value) ??
                                          Subject()
                                    ]));
                              },
                            ),
                          ),

                        /// CONTACT ADDRESS
                        if (showSubject)
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Address'),
                              // required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: readOnly,
                              initialValue:
                                  state.taskDetail.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskDetail.subjects?[0].address,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskDetail.subjects?[0]
                                              .copyWith(name: value) ??
                                          Subject()
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
                        if (state.taskDetail.taskAssignment?.taskDescription
                                ?.isNotEmpty ??
                            false)
                          ResponsiveItem(
                            percentWidthOnParent: 100,
                            child: CTextFormField(
                              labelText: sharedPref.translate('Description'),
                              maxLines: 5,
                              // required: state.screenMode == ScreenModeEnum.edit,
                              readOnly: readOnly,
                              autoFocus: state.taskDetail.subjects?.isEmpty,
                              initialValue:
                                  state.taskDetail.subjects?.isEmpty == true
                                      ? ''
                                      : state.taskDetail.subjects?[0].phone,
                              onChanged: (value) {
                                context.read<TaskDetailBloc>().add(
                                        TaskContactPointsChanged([
                                      state.taskDetail.subjects?[0]
                                              .copyWith(phone: value) ??
                                          Subject()
                                    ]));
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
                            initialValue: state.taskDetail.taskAssignment
                                        ?.beginningDateTime?.isNotEmpty ==
                                    true
                                ? df2.format(DateTime.parse(state.taskDetail
                                        .taskAssignment?.beginningDateTime ??
                                    ''))
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
                            initialValue: state.taskDetail.taskAssignment
                                        ?.deadline?.isNotEmpty ==
                                    true
                                ? df2.format(DateTime.parse(
                                    state.taskDetail.taskAssignment?.deadline ??
                                        ''))
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
                        if (state.taskDetail.taskAssignment?.id != null)
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
                              onSelected: (selections) {
                                // context.read<TaskDetailBloc>().add(
                                //     TaskAssignedUsersChanged(selections
                                //         .map<String>((e) => e.value)
                                //         .toList()));
                              },
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
                                            state.taskDetail.taskAssignment
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
                            required: state.screenMode == ScreenModeEnum.edit,
                            readOnly: readOnly,
                            dropdownMenuEntries:
                                state.dropdownData.participants ?? [],
                            selectedMenuEntries: state
                                        .dropdownData.participants !=
                                    null
                                ? state.dropdownData.participants!
                                    .where((e) => (state.taskDetail.participants
                                            ?.any((i) => i.userId == e.value) ??
                                        false))
                                    .toList()
                                : [],
                            onSelected: (selections) {
                              context.read<TaskDetailBloc>().add(
                                  TaskParticipantsChanged(selections
                                      .map<Participant>(
                                          (e) => Participant(userId: e.value))
                                      .toList()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// TASK FLOW
                  if (state.taskDetail.taskAssignment?.id != null)
                    CGroup(
                      titleText: sharedPref.translate('History'),
                      child: ResponsiveRow(
                        context: context,
                        children: [
                          ResponsiveItem(
                            percentWidthOnParent:
                                constrains.maxWidth < 3 * basicWidth
                                    ? 100
                                    : null,
                          ),
                        ],
                      ),
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
