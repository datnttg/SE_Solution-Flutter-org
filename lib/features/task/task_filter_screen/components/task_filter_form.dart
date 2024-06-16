import 'package:flutter/material.dart';
import 'package:se_solution/utilities/custom_widgets.dart';
import 'package:se_solution/utilities/responsive.dart';
import 'package:se_solution/utilities/shared_preferences.dart';
import '../bloc/task_filter_bloc.dart';
import '../bloc/task_filter_events.dart';
import '../services/task_fetch_data_service.dart';

class TaskFilterForm extends StatelessWidget {
  final TaskInfoBloc bloc;

  const TaskFilterForm({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResponsiveRow(
          context: context,
          basicWidth: 400,
          horizontalSpacing: 0,
          children: [
            /// CREATED DATE
            ResponsiveItem(
                child: CTextFormField(
              labelText: sharedPrefs.translate('Assigned date'),
              // wrap: true,
              hintText: '--${sharedPrefs.translate('All')}--',
              suffix: IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: () {},
              ),
            )),

            /// CREATED USER
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: StreamBuilder(
                  stream: fetchAssignedUserEntries(),
                  builder: (context, snapshot) {
                    var labelText = sharedPrefs.translate('Creator');
                    Widget child = COnLoadingDropdownMenu(labelText: labelText);
                    if (snapshot.hasData) {
                      child = CDropdownMenu(
                        labelText: labelText,
                        multiSelect: true,
                        hintText: '--${sharedPrefs.translate('All')}--',
                        dropdownMenuEntries: snapshot.data!,
                        onSelected: (values) {
                          bloc.eventController
                              .add(ChangeTaskFilterCreatedUser(values));
                        },
                      );
                    }
                    return child;
                  }),
            ),

            /// ASSIGNED USER
            ResponsiveItem(
              percentWidthOnParent:
                  Responsive.isSmallWidth(context) == true ? 100 : null,
              child: StreamBuilder(
                  stream: fetchAssignedUserEntries(),
                  builder: (context, snapshot) {
                    var labelText = sharedPrefs.translate('Assigned to');
                    Widget child = COnLoadingDropdownMenu(labelText: labelText);
                    if (snapshot.hasData) {
                      child = CDropdownMenu(
                        labelText: labelText,
                        multiSelect: true,
                        hintText: '--${sharedPrefs.translate('All')}--',
                        dropdownMenuEntries: snapshot.data!,
                        selectedMenuEntries: snapshot.data!
                            .where((e) => e.value == sharedPrefs.getUserId())
                            .toList(),
                        onSelected: (values) {
                          bloc.eventController
                              .add(ChangeTaskFilterAssignedUser(values));
                        },
                      );
                    }
                    return child;
                  }),
            ),

            /// TASK TYPE
            ResponsiveItem(
                percentWidthOnParent:
                    Responsive.isSmallWidth(context) == true ? 100 : null,
                child: StreamBuilder(
                    stream: fetchTaskCategory(categoryProperty: 'TaskType'),
                    builder: (context, snapshot) {
                      var labelText = sharedPrefs.translate('Task type');
                      Widget child =
                          COnLoadingDropdownMenu(labelText: labelText);
                      if (snapshot.hasData) {
                        child = CDropdownMenu(
                          labelText: labelText,
                          // enableSearch: true,
                          multiSelect: true,
                          hintText: '--${sharedPrefs.translate('All')}--',
                          dropdownMenuEntries: snapshot.data!,
                          onSelected: (values) {
                            bloc.eventController
                                .add(ChangeTaskFilterType(values));
                          },
                        );
                      }
                      return child;
                    })),

            /// TASK STATUS
            ResponsiveItem(
                // percentWidthOnParent:
                //     Responsive.isSmallWidth(context) == true ? 100 : 50,
                widthRatio: 2,
                child: StreamBuilder(
                  stream: fetchTaskCategory(categoryProperty: 'TaskStatus'),
                  builder: (context, snapshot) {
                    var labelText = sharedPrefs.translate('Status');
                    Widget child = COnLoadingDropdownMenu(labelText: labelText);
                    if (snapshot.hasData) {
                      child = CDropdownMenu(
                        labelText: labelText,
                        multiSelect: true,
                        hintText: '--${sharedPrefs.translate('All')}--',
                        dropdownMenuEntries: snapshot.data!,
                        selectedMenuEntries: snapshot.data!
                            .where((e) => [
                                  "WaitToConfirm",
                                  "OnProgress",
                                  "CoordinatedTransfer"
                                ].any((u) => u == e.value))
                            .toList(),
                        onSelected: (values) {
                          bloc.eventController
                              .add(ChangeTaskFilterStatus(values));
                        },
                      );
                    }
                    return child;
                  },
                )),
          ],
        ),
      ),
    );
  }
}
