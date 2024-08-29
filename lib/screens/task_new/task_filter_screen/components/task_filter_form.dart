import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:se_solution_ori/screens/task_new/task_filter_screen/bloc/task_filter_events.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../bloc/task_filter_bloc.dart';
import '../bloc/task_filter_states.dart';

class TaskFilterForm extends StatefulWidget {
  const TaskFilterForm({super.key});

  @override
  State<TaskFilterForm> createState() => _TaskFilterFormState();
}

class _TaskFilterFormState extends State<TaskFilterForm> {
  @override
  Widget build(BuildContext context) {
    final dateRangeInputController = TextEditingController();
    void changeDate(DateTimeRange? pickedDateRange) {
      if (pickedDateRange != null) {
        String formattedDateRange =
            '${DateFormat('dd/MM/yyyy').format(pickedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(pickedDateRange.end)}';
        setState(() {
          dateRangeInputController.text = formattedDateRange;
        });
      }
    }

    var dateRange = dateRangeInputController.text.split(' - ').toList();
    var initialDateRange = dateRangeInputController.text == ''
        ? DateTimeRange(
            start: DateTime(DateTime.now().year, DateTime.now().month, 1),
            end: DateTime.now(),
          )
        : DateTimeRange(
            start: DateFormat('dd/MM/yyyy').parse(dateRange[0]),
            end: DateFormat('dd/MM/yyyy').parse(dateRange[1]),
          );

    return BlocBuilder<TaskFilterBloc, TaskFilterState>(
        builder: (context, state) {
      var startDate = state.parameters?.assignedDateStart;
      if (startDate != null) {
        startDate = startDate.split(' ')[0];
      }
      var endDate = state.parameters?.assignedDateEnd;
      if (endDate != null) {
        endDate = endDate.split(' ')[0];
      }
      dateRangeInputController.text = "$startDate - $endDate";
      return CGroup(
        child: Column(
          children: [
            ResponsiveRow(
              context: context,
              basicWidth: Responsive.isSmallWidth(context) ? 300 : 400,
              horizontalSpacing: defaultPadding * 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ResponsiveItem(
                  child: CTextFormField(
                    controller: dateRangeInputController,
                    labelText: sharedPref.translate('Assigned date'),
                    hintText: sharedPref.translate('dd/mm/yyyy - dd/mm/yyyy'),
                    suffix: IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () async {
                        DateTimeRange? pickedDateRange =
                            await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now(),
                          initialDateRange: initialDateRange,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                        );
                        changeDate(pickedDateRange);
                      },
                    ),
                    onChanged: (String input) {
                      context
                          .read<TaskFilterBloc>()
                          .add(TaskFilterCreatedTimeChanged(input));
                    },
                  ),
                ),
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Last progress'),
                    hintText: sharedPref.translate('All'),
                    multiSelect: true,
                    dropdownMenuEntries:
                        state.dropdownData?.lastProgresses ?? [],
                    onSelected: (values) {
                      context
                          .read<TaskFilterBloc>()
                          .add(TaskFilterLastProgressesChanged(values));
                    },
                  ),
                ),
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Status'),
                    hintText: sharedPref.translate('All'),
                    multiSelect: true,
                    dropdownMenuEntries: state.dropdownData?.taskStatuses ?? [],
                    onSelected: (values) {
                      context
                          .read<TaskFilterBloc>()
                          .add(TaskFilterStatusesChanged(values));
                    },
                  ),
                ),
                ResponsiveItem(
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Task type'),
                    hintText: sharedPref.translate('All'),
                    multiSelect: true,
                    dropdownMenuEntries: state.dropdownData?.taskTypes ?? [],
                    onSelected: (values) {
                      context
                          .read<TaskFilterBloc>()
                          .add(TaskFilterTypesChanged(values));
                    },
                  ),
                ),
                ResponsiveItem(
                  // widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
                  child: CDropdownMenu(
                    labelText: sharedPref.translate('Assigned to'),
                    hintText: sharedPref.translate('All'),
                    multiSelect: true,
                    dropdownMenuEntries:
                        state.dropdownData?.assignedUsers ?? [],
                    onSelected: (values) {
                      context
                          .read<TaskFilterBloc>()
                          .add(TaskFilterAssignedUsersChanged(values));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
