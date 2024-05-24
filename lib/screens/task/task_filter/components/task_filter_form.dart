import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../controllers/task_data_controllers.dart';
import '../../services/task_services.dart';

class TaskFilterForm extends StatefulWidget {
  const TaskFilterForm({super.key});

  @override
  State<TaskFilterForm> createState() => _TaskFilterFormState();
}

class _TaskFilterFormState extends State<TaskFilterForm> {
  final taskFilterController = Get.find<TaskFilterController>();
  final formKey = GlobalKey<FormState>();
  final dateRangeInputController = TextEditingController();
  final taskTypeController = TextEditingController();
  final taskAssignedController = TextEditingController();

  late final Future<List> listUser;
  late final Future<List> taskStatuses;
  late final Future<List> listTaskCategory;

  @override
  initState() {
    listUser = taskUsersFilter();
    listTaskCategory = fetchTaskCategoryFilter(categoryProperty: "Type");
    taskStatuses = fetchTaskCategoryFilter(categoryProperty: "Status");
    dateRangeInputController.text =
        taskFilterController.taskAssignedDateRange.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void changeDate(DateTimeRange? pickedDateRange) {
      if (pickedDateRange != null) {
        String formattedDateRange =
            '${DateFormat('dd/MM/yyyy').format(pickedDateRange.start)} - ${DateFormat('dd/MM/yyyy').format(pickedDateRange.end)}';
        setState(() {
          dateRangeInputController.text = formattedDateRange;
        });
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          ResponsiveRow(
            context: context,
            basicWidth: Responsive.isSmallWidth(context) ? 200 : 250,
            horizontalSpacing: defaultPadding * 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ResponsiveItem(
                widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
                child: KTextFormField(
                  controller: dateRangeInputController,
                  label: Text(sharedPrefs.translate('Assigned date')),
                  hintText: sharedPrefs.translate('dd/mm/yyyy - dd/mm/yyyy'),
                  suffix: InkWell(
                    child: const Icon(Icons.calendar_month),
                    onTap: () async {
                      var dateRange =
                          dateRangeInputController.text.split(' - ').toList();
                      var initialDateRange = dateRangeInputController.text == ''
                          ? DateTimeRange(
                              start: DateTime(
                                  DateTime.now().year, DateTime.now().month, 1),
                              end: DateTime.now(),
                            )
                          : DateTimeRange(
                              start:
                                  DateFormat('dd/MM/yyyy').parse(dateRange[0]),
                              end: DateFormat('dd/MM/yyyy').parse(dateRange[1]),
                            );
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
                    taskFilterController.taskAssignedDateRange.value = input;
                    refreshTaskList();
                  },
                ),
              ),
              ResponsiveItem(
                child: FutureBuilder(
                  future: taskStatuses,
                  builder: (context, snapshot) {
                    Widget child = Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return KOnLoadingDropdownMenu(
                        label: Text(sharedPrefs.translate('Status')),
                      );
                    }
                    if (snapshot.hasData) {
                      return KDropdownMenu(
                        menuHeight: null,
                        labelText: sharedPrefs.translate('Status'),
                        hintText: sharedPrefs.translate('Choose one'),
                        dropdownMenuEntries: snapshot.data!
                            .map((e) => DropdownMenuEntry(
                                value: e['code'],
                                label: e[sharedPrefs.getLocale().languageCode]))
                            .toList(),
                        initialSelection: snapshot.data![0]['code'],
                        onSelected: (selected) {
                          taskFilterController.taskStatus.value = selected;
                          refreshTaskList();
                        },
                      );
                    }
                    return Container(
                      child: child,
                    );
                  },
                ),
              ),
              ResponsiveItem(
                child: FutureBuilder(
                  future: listTaskCategory,
                  builder: (context, snapshot) {
                    Widget child = Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return KOnLoadingDropdownMenu(
                        label: Text(sharedPrefs.translate('Task type')),
                      );
                    }
                    if (snapshot.hasData) {
                      return KDropdownMenu(
                        menuHeight: null,
                        labelText: sharedPrefs.translate('Task type'),
                        hintText: sharedPrefs.translate('Choose one'),
                        dropdownMenuEntries: snapshot.data!
                            .map((e) => DropdownMenuEntry(
                                value: e['id'],
                                label: e[sharedPrefs.getLocale().languageCode]))
                            .toList(),
                        initialSelection: snapshot.data![0]['id'],
                        onSelected: (selected) {
                          // taskTypeId = selected;
                          taskFilterController.taskTypeId.value = selected;
                          refreshTaskList();
                        },
                      );
                    }
                    return Container(
                      child: child,
                    );
                  },
                ),
              ),
              ResponsiveItem(
                widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
                child: FutureBuilder(
                  future: listUser,
                  builder: (context, snapshot) {
                    Widget child = Container();
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return KOnLoadingDropdownMenu(
                        label: Text(sharedPrefs.translate('Assigned to')),
                      );
                    }
                    if (snapshot.hasData) {
                      return KDropdownMenu(
                        // label: Text(sharedPrefs.translate('Assigned to')),
                        labelText: sharedPrefs.translate('Assigned to'),
                        hintText: sharedPrefs.translate('Choose one'),
                        dropdownMenuEntries: snapshot.data!
                            .map((e) => DropdownMenuEntry(
                                value: e['id'],
                                label: e['displayName'] +
                                    (e['username'] == null
                                        ? ''
                                        : ' (${e['username']})'),
                                labelWidget: Text(
                                  e['displayName'] +
                                      (e['username'] == null
                                          ? ''
                                          : ' (${e['username']})'),
                                  overflow: TextOverflow.clip,
                                )))
                            .toList(),
                        initialSelection: snapshot.data![0]['id'],
                        onSelected: (selected) {
                          taskFilterController.taskAssignedUserId.value =
                              selected;
                          refreshTaskList();
                        },
                      );
                    }
                    return Container(
                      child: child,
                    );
                  },
                ),
              ),
              // ResponsiveItem(
              //   parentPercentWidth: Responsive.isPortrait(context) ? 100 : null,
              //   child: Column(
              //     children: [
              //       KElevatedButton(
              //         onPressed: () async {
              //           if (formKey.currentState!.validate()) {
              //             var dateRange = dateRangeInputController.text
              //                 .split(' - ')
              //                 .toList();
              //             var payload = {
              //               "assignedDateStart":
              //                   kDateTimeConvert(dateRange[0]).toString(),
              //               "assignedDateEnd":
              //                   kDateTimeConvert(dateRange[1]).toString(),
              //               "taskTypeId": taskTypeId,
              //               "userIdAssigned": userIdAssigned
              //             };
              //             var res = await fetchDataUI(
              //                 Uri.parse('${constants.hostAddress}/task/list'),
              //                 parameters: payload);
              //             if (res['responseData'] != null) {
              //               taskFilterController.listTask.value =
              //                   res['responseData'];
              //             }
              //           }
              //         },
              //         child: Text(
              //           sharedPrefs.translate('Filter'),
              //           style: const TextStyle(color: Colors.white),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: defaultPadding * 3,
          ),
        ],
      ),
    );
  }
}
