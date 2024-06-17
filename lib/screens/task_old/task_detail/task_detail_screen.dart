import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utilities/app_service.dart';
import '../../../utilities/constants/core_constants.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/enums/ui_enums.dart';
import '../../../utilities/shared_preferences.dart';
import '../../../utilities/ui_styles.dart';
import '../../common_components/main_menu.dart';
import '../controllers/task_data_controllers.dart';
import '../controllers/task_ui_controllers.dart';
import '../models/task_models.dart';
import '../services/task_services.dart';
import 'components/task_info.dart';
import 'components/task_reference_subjects.dart';
import 'components/task_update_form.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key, this.taskId});

  final String? taskId;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final taskUIController = Get.put(TaskUIController());
  final taskDetailController = Get.put(TaskDetailController());
  final taskInfoController = Get.put(TaskInfoController());
  final taskInfoFormKey = GlobalKey<FormState>();

  Map taskDetail = {};
  List<DropdownMenuEntry> assignedUsersEntries = <DropdownMenuEntry>[];
  List<DropdownMenuEntry> taskTypeEntries = <DropdownMenuEntry>[];

  @override
  void initState() {
    taskUIController.resetTaskDetailUI();
    taskDetailController.reset();
    super.initState();
  }

  Future<bool?> getReady() async {
    try {
      await getListAssignedUserEntries()
          .then((value) => assignedUsersEntries = value);
      await getTaskTypeEntries().then((value) => taskTypeEntries = value);
      await getFieldMappings({})
          .then((value) => taskUIController.fieldMappings.value = value);

      if (widget.taskId != null) {
        await fetchTaskDetail(widget.taskId!)
            .then((value) => taskDetail = value);

        taskInfoController.taskId.value = widget.taskId ?? '';
        taskInfoController.taskStatus.value =
            taskDetail['taskAssignment']['taskStatus'];
        taskDetailController.referenceSubjects.value =
            (taskDetail['referenceSubjects'] as List)
                .map((e) => TaskReferenceSubjectModel(
                    name: e['name'],
                    phone: e['phone'],
                    address: e['address'],
                    customerSource: e['customerSource']))
                .toList();
        taskUIController
            .showTaskSubject(taskDetail['taskAssignment']['taskTypeId']);
      }
      fieldDisplay();
      return true;
    } catch (e) {
      return null;
    }
  }

  void fieldDisplay() {
    if (widget.taskId == null) {
      taskUIController.mode.value = ScreenModeEnum.edit;
      taskUIController.btnSave.value = DisplayTypeEnum.normal;
    } else {
      taskUIController.showReferenceSubjects.value = false;
      taskUIController.mode.value = ScreenModeEnum.view;
      taskUIController.btnSave.value = DisplayTypeEnum.hidden;
      if (taskDetail['taskAssignment']['userIdAssigned'] ==
          sharedPrefs.getUserId()) {
        if (taskDetail['taskAssignment']['taskStatus'] == 'WaitToConfirm') {
          taskUIController.btnConfirm.value = DisplayTypeEnum.normal;
          taskUIController.btnReject.value = DisplayTypeEnum.normal;
          taskUIController.btnRevoke.value = DisplayTypeEnum.normal;
        } else if (taskDetail['taskAssignment']['taskStatus'] == 'OnProgress') {
          taskUIController.btnUpdate.value = DisplayTypeEnum.normal;
          taskUIController.btnRevoke.value = DisplayTypeEnum.normal;
        }
      }
    }
  }

  Future<Map> postData(Uri uri, Map? parameters) async {
    var response = await fetchDataUI(uri, parameters: parameters);
    if (response['success'] == true) {
      kShowToast(
        title: sharedPrefs.translate('Result'),
        content: response['responseMessage'],
        style: 'success',
      );
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold(
      drawer: const MainMenu(),
      appBar: AppBar(
        title: Text(sharedPrefs.translate('Create task')),
        actions: [
          Obx(
            () => Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child:
                      taskUIController.btnSave.value == DisplayTypeEnum.hidden
                          ? null
                          : KElevatedButton(
                              backgroundColor: Colors.green,
                              child: Text(
                                sharedPrefs.translate('Save'),
                                style: const TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (taskInfoFormKey.currentState!.validate()) {
                                  var parameters = getValue();
                                  var checkResult = checkConditions();
                                  if (checkResult) {
                                    var response = await postData(
                                        Uri.parse(
                                            "${constants.hostAddress}/Task/Create"),
                                        parameters);
                                    if (response['success']) {
                                      taskUIController.btnSave.value =
                                          DisplayTypeEnum.hidden;
                                    }
                                  }
                                }
                              },
                            ),
                ),
                taskUIController.btnConfirm.value == DisplayTypeEnum.hidden
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: KElevatedButton(
                          backgroundColor: Colors.green,
                          child: Text(
                            sharedPrefs.translate('Accept'),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (taskInfoFormKey.currentState!.validate()) {
                              var parameters = getValue();
                              var checkResult = checkConditions();
                              if (checkResult) {
                                var response = await postData(
                                    Uri.parse(
                                        "${constants.hostAddress}/Task/Confirm"),
                                    parameters);
                                if (response['success']) {
                                  taskUIController.btnConfirm.value =
                                      DisplayTypeEnum.hidden;
                                  taskUIController.btnReject.value =
                                      DisplayTypeEnum.hidden;
                                }
                              }
                            }
                          },
                        ),
                      ),
                taskUIController.btnReject.value == DisplayTypeEnum.hidden
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: KElevatedButton(
                          backgroundColor: Colors.red,
                          child: Text(
                            sharedPrefs.translate('Reject'),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (taskInfoFormKey.currentState!.validate()) {
                              var parameters = getValue();
                              var checkResult = checkConditions();
                              if (checkResult) {
                                var response = await postData(
                                    Uri.parse(
                                        "${constants.hostAddress}/Task/Reject"),
                                    parameters);
                                if (response['success']) {
                                  taskUIController.btnConfirm.value =
                                      DisplayTypeEnum.hidden;
                                  taskUIController.btnReject.value =
                                      DisplayTypeEnum.hidden;
                                }
                              }
                            }
                            fieldDisplay();
                          },
                        ),
                      ),
                taskUIController.btnUpdate.value == DisplayTypeEnum.hidden
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: KElevatedButton(
                          backgroundColor: Colors.green,
                          child: Text(
                            sharedPrefs.translate('Update'),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            kShowDialog(const TaskUpdateForm(),
                                title: sharedPrefs.translate('Update'));
                          },
                        ),
                      ),
                taskUIController.btnBack.value == DisplayTypeEnum.hidden
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: KElevatedButton(
                          backgroundColor: Colors.grey[400],
                          child: Text(
                            sharedPrefs.translate('Back'),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                        ),
                      ),
              ],
            ),
          )
        ],
      ),

// BODY
      body: FutureBuilder(
          future: getReady(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Form(
                key: taskInfoFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
// TASK INFO
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            defaultPadding * 2,
                            defaultPadding * 2,
                            defaultPadding * 2,
                            defaultPadding * 4),
                        child: TaskInfo(
                          assignedUsersEntries: assignedUsersEntries,
                          taskTypeEntries: taskTypeEntries,
                          taskAssignment: taskDetail['taskAssignment'],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding * 5,
                    ),
// REFERENCE SUBJECTS
                    Obx(
                      () => taskUIController.showReferenceSubjects.value == true
                          ? const Card(
                              child: Padding(
                                padding: EdgeInsets.all(defaultPadding * 2),
                                child: TaskReferenceSubjectList(),
                              ),
                            )
                          : Container(),
                    ),
// PROJECTS LIST
                    // const Card(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(defaultPadding * 2),
                    //     child: TaskProjectList(),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
