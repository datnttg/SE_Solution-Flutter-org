import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:se_solution/utilities/custom_widgets.dart';
import 'package:se_solution/utilities/responsive.dart';
import 'package:se_solution/utilities/shared_preferences.dart';
import 'package:se_solution/utilities/ui_styles.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/constants/core_constants.dart';
import '../../controllers/task_data_controllers.dart';
import '../../services/task_services.dart';

class TaskUpdateForm extends StatefulWidget {
  const TaskUpdateForm({super.key});

  @override
  State<TaskUpdateForm> createState() => _TaskUpdateFormState();
}

class _TaskUpdateFormState extends State<TaskUpdateForm> {
  final taskInfoController = Get.find<TaskInfoController>();
  final taskFlowFormKey = GlobalKey<FormState>();
  late List<DropdownMenuEntry> taskStatusEntries;

  Future<bool?> getReady() async {
    try {
      taskStatusEntries = await getTaskStatusEntries();
      return true;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getReady(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Form(
              key: taskFlowFormKey,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 3),
                  child: ResponsiveRow(
                    context: context,
                    children: [
                      ResponsiveItem(
                          percentWidthOfParent:
                              Responsive.isSmallWidth(context) ? 100 : 30,
                          child: KDropdownMenu(
                            labelText: sharedPrefs.translate('Status'),
                            dropdownMenuEntries: taskStatusEntries,
                            initialSelection:
                                taskInfoController.taskStatus.value,
                            onSelected: ((p0) {
                              taskInfoController.taskStatus.value = p0;
                            }),
                          )),
                      ResponsiveItem(
                          percentWidthOfParent:
                              Responsive.isSmallWidth(context) ? 100 : 70,
                          child: KTextFormField(
                            label: Text(sharedPrefs.translate('Description')),
                            onChanged: ((p0) {
                              taskInfoController.taskDescription.value = p0;
                            }),
                          )),
                      ResponsiveItem(
                          percentWidthOfParent: 100,
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: defaultPadding * 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                KElevatedButton(
                                  child: Text(
                                    sharedPrefs.translate('Update'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (taskFlowFormKey.currentState!
                                        .validate()) {
                                      var taskAssignment = {
                                        "id": taskInfoController.taskId.value,
                                        "taskTypeId":
                                            taskInfoController.taskTypeId.value,
                                        "userIdAssigned": taskInfoController
                                            .userIdAssigned.value,
                                        "taskTitle":
                                            taskInfoController.taskTitle.value,
                                        "taskDescription": taskInfoController
                                            .taskDescription.value,
                                        "deadline": kDateTimeConvert(
                                                taskInfoController
                                                    .deadline.value)
                                            .toLocal()
                                            .toString(),
                                        "taskStatus":
                                            taskInfoController.taskStatus.value,
                                      };
                                      var parameters = {
                                        "TaskAssignment":
                                            jsonEncode(taskAssignment),
                                      };
                                      var checkResult = checkConditions();
                                      if (checkResult) {
                                        var response = await fetchDataUI(
                                            Uri.parse(
                                                "${constants.hostAddress}/Task/Update"),
                                            parameters: parameters);
                                        if (response['success'] == true) {
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                          kShowToast(
                                              content:
                                                  response['responseMessage'],
                                              title: sharedPrefs
                                                  .translate('Result'),
                                              style: 'success');
                                        }
                                        // else {
                                        //   kShowAlert(
                                        //       Text(sharedPrefs.translate(
                                        //           "Connection failed!")),
                                        //       sharedPrefs.translate('Result'));
                                        // }
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          }
        }));
  }
}
