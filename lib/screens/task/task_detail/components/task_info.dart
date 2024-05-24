import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se_solution/utilities/app_service.dart';
import '../../../../utilities/configs.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../controllers/task_ui_controllers.dart';
import '../../controllers/task_data_controllers.dart';

class TaskInfo extends StatefulWidget {
  final List<DropdownMenuEntry> assignedUsersEntries;
  final List<DropdownMenuEntry> taskTypeEntries;
  final Map? taskAssignment;

  const TaskInfo({
    super.key,
    required this.assignedUsersEntries,
    required this.taskTypeEntries,
    this.taskAssignment,
  });

  @override
  State<TaskInfo> createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  final taskUIController = Get.find<TaskUIController>();
  final taskInfoController = Get.find<TaskInfoController>();
  final titleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final deadlineController = TextEditingController();

  @override
  void initState() {
    var now = DateTime.now();
    var endDay = DateTime(now.year, now.month, now.day)
        .add(const Duration(days: 1) - const Duration(microseconds: 1));
    deadlineController.text = df2.format(endDay);

    if (widget.taskAssignment != null) {
      titleController.text = widget.taskAssignment!['taskTitle'];
      var deadline = df2
          .format(DateTime.parse(widget.taskAssignment!['deadline']).toLocal());
      taskInfoController.deadline.value = deadline;
      deadlineController.text = deadline;
    }
    taskInfoController.taskTitle.value =
        widget.taskAssignment?['taskTitle'] ?? "";
    taskInfoController.userIdAssigned.value =
        widget.taskAssignment?['userIdAssigned'] ?? "";
    taskInfoController.taskTypeId.value =
        widget.taskAssignment?['taskTypeId'] ?? widget.taskTypeEntries[0].value;
    taskInfoController.deadline.value =
        widget.taskAssignment?['deadline'] ?? df2.format(endDay.toLocal());
    taskInfoController.taskDescription.value =
        widget.taskAssignment?['taskDescription'] ?? "";

    taskUIController.showTaskSubject(taskInfoController.taskTypeId.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var initialDate = taskInfoController.deadline.value == ''
        ? DateTime.now()
        : kDateTimeConvert(taskInfoController.deadline.value);
    return Column(
      children: [
        Row(
          children: [
            KText(
              sharedPrefs.translate('Task information'),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: largeTextSize),
            )
          ],
        ),
        const Divider(),
        ResponsiveRow(
          context: context,
          basicWidth: Responsive.isSmallWidth(context) ? 200 : 250,
          children: [
            ResponsiveItem(
              // widthRatio: 2,
              parentPercentWidth: 100,
              child: KTextFormField(
                label: Text(sharedPrefs.translate('Title')),
                controller: titleController,
                autoFocus: true,
                required: true,
                readOnly: taskUIController.mode.value != ScreenModeEnum.edit,
                onChanged: (input) {
                  taskInfoController.taskTitle.value = input;
                },
              ),
            ),
            ResponsiveItem(
              parentPercentWidth: 100,
              child: KTextFormField(
                label: Text(sharedPrefs.translate('Addition information')),
                controller: taskDescriptionController,
                readOnly: taskUIController.mode.value != ScreenModeEnum.edit,
                initialValue: widget.taskAssignment?['taskDescription'],
                onChanged: (input) {
                  taskInfoController.taskDescription.value = input;
                },
              ),
            ),
            ResponsiveItem(
              widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
              child: KDropdownMenu(
                labelText: sharedPrefs.translate('Task type'),
                menuHeight: null,
                required: true,
                enabled: taskUIController.mode.value == ScreenModeEnum.edit,
                hintText: sharedPrefs.translate('Choose one'),
                dropdownMenuEntries: widget.taskTypeEntries,
                initialSelection: taskInfoController.taskTypeId.value,
                onSelected: (p0) {
                  taskInfoController.taskTypeId.value = p0;
                  taskUIController.showTaskSubject(p0);
                },
              ),
            ),
            ResponsiveItem(
              widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
              child: KDropdownMenu(
                labelText: sharedPrefs.translate('Assign to'),
                required: true,
                dropdownMenuEntries: widget.assignedUsersEntries,
                enabled: taskUIController.mode.value == ScreenModeEnum.edit,
                hintText: sharedPrefs.translate('Choose one'),
                initialSelection: taskInfoController.userIdAssigned.value,
                onSelected: (selected) {
                  taskInfoController.userIdAssigned.value = selected;
                },
              ),
            ),
            ResponsiveItem(
              widthRatio: Responsive.isSmallWidth(context) ? 2 : 1,
              child: KTextFormField(
                required: true,
                label: Text(sharedPrefs.translate('Deadline')),
                hintText: sharedPrefs.translate('dd-mm-yyyy HH:mm'),
                controller: deadlineController,
                readOnly: taskUIController.mode.value == ScreenModeEnum.view,
                suffix: InkWell(
                  onTap: taskUIController.mode.value == ScreenModeEnum.view
                      ? null
                      : () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            firstDate: DateTime.now().isBefore(initialDate)
                                ? DateTime.now()
                                : initialDate,
                            lastDate: DateTime(2100),
                            initialDate: initialDate,
                          );
                          if (pickedDate != null) {
                            var deadline = pickedDate.add(
                                const Duration(days: 1) -
                                    const Duration(microseconds: 1));
                            String formattedDate = df2.format(deadline);
                            setState(() {
                              deadlineController.text = formattedDate;
                              taskInfoController.deadline.value =
                                  kDateTimeString(deadline);
                            });
                          }
                        },
                  child: const Icon(Icons.calendar_month),
                ),
                onChanged: (input) {
                  taskInfoController.deadline.value = input;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
