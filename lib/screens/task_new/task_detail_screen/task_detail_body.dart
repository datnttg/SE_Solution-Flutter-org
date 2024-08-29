import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se_solution_ori/screens/task_new/task_detail_screen/models/task_detail_model.dart';
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
        var hideSubjectList = ['Basic'];
        var showSubject = !hideSubjectList
            .where((e) => e == state.taskDetail.taskAssignment?.taskType)
            .isNotEmpty;
        double basicWidth = 360;
        return LayoutBuilder(builder: (context, constrains) {
          return Column(
            children: [
              CGroup(
                child: ResponsiveRow(
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
                        dropdownMenuEntries: state.dropdownData.taskTypes ?? [],
                        selectedMenuEntries: state.dropdownData.taskTypes!
                            .where((e) =>
                                e.value ==
                                state.taskDetail.taskAssignment?.taskType)
                            .toList(),
                        onSelected: (value) {
                          context
                              .read<TaskDetailBloc>()
                              .add(TaskTypeChanged(value.firstOrNull?.value));
                        },
                      ),
                    ),

                    /// CONTACT PHONE
                    if (showSubject)
                      ResponsiveItem(
                        percentWidthOnParent:
                            constrains.maxWidth < 3 * basicWidth ? 100 : null,
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
                            constrains.maxWidth < 3 * basicWidth ? 100 : null,
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
                            constrains.maxWidth < 3 * basicWidth ? 100 : null,
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
                  context: context,
                  children: [
                    /// DESCRIPTION
                    ResponsiveItem(
                      percentWidthOnParent:
                          constrains.maxWidth < 3 * basicWidth ? 100 : null,
                      child: CTextFormField(
                        labelText: sharedPref.translate('Description'),
                        maxLines: 5,
                        // required: state.screenMode == ScreenModeEnum.edit,
                        readOnly: readOnly,
                        autoFocus: state.taskDetail.subjects?.isEmpty,
                        initialValue: state.taskDetail.subjects?.isEmpty == true
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
                                    ?.beginningDateTime?.isEmpty ==
                                true
                            ? ''
                            : state
                                .taskDetail.taskAssignment?.beginningDateTime,
                        onChanged: (value) {
                          context
                              .read<TaskDetailBloc>()
                              .add(TaskBeginningTimeChanged(value));
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {},
                        ),
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
                        initialValue: state.taskDetail.taskAssignment?.deadline
                                    ?.isEmpty ==
                                true
                            ? ''
                            : state.taskDetail.taskAssignment?.deadline,
                        onChanged: (value) {
                          context
                              .read<TaskDetailBloc>()
                              .add(TaskBeginningTimeChanged(value));
                        },
                        suffix: IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.taskDetail.taskAssignment?.id != null)
                CGroup(
                  titleText: sharedPref.translate('Task flow'),
                  child: ResponsiveRow(
                    context: context,
                    children: [
                      /// DESCRIPTION
                      ResponsiveItem(
                        percentWidthOnParent:
                            constrains.maxWidth < 3 * basicWidth ? 100 : null,
                      ),
                    ],
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}
