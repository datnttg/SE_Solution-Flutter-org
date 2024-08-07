import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../controllers/task_data_controllers.dart';
import 'task_project_adding.dart';

class TaskProjectList extends StatelessWidget {
  const TaskProjectList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var taskDetailController = Get.find<TaskDetailController>();

    return Column(
      children: [
        /// BUTTON
        Row(
          children: [
            Expanded(
              child: KSelectableText(
                sharedPref.translate('Reference project(s)'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: largeTextSize),
              ),
            ),
            KElevatedButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                kShowDialog(const TaskProjectAdding(),
                    title: sharedPref.translate('Add new project'));
              },
              child: Text(
                sharedPref.translate('Add'),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        const Divider(),
        Obx(
          () => SizedBox(
            child: taskDetailController.projects.isEmpty
                ? Container()
                : ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 300),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: taskDetailController.projects.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: index.isEven ? kBgColorRow1 : null,
                                  borderRadius:
                                      BorderRadius.circular(defaultRadius)),
                              padding: const EdgeInsets.fromLTRB(
                                  defaultPadding * 3,
                                  defaultPadding,
                                  defaultPadding * 3,
                                  defaultPadding),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: defaultPadding * 3),
                                    child:
                                        KSelectableText((index + 1).toString()),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: KSelectableText(
                                                '${taskDetailController.projects[index].contractCode ?? ""} ${taskDetailController.projects[index].annexCode ?? ""}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: KSelectableText(
                                                  taskDetailController
                                                          .projects[index]
                                                          .contactName ??
                                                      ""),
                                            )
                                          ],
                                        ),
                                        KSelectableText(
                                          taskDetailController
                                                  .projects[index].address ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: smallTextSize),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: taskDetailController
                                                .projects[index].contactPhone ==
                                            null
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () async {
                                              await launchUrl(Uri.parse(
                                                  'tel://${taskDetailController.projects[index].contactPhone}'));
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(Icons.phone),
                                                const SizedBox(
                                                  width: defaultPadding,
                                                ),
                                                KSelectableText(
                                                    taskDetailController
                                                            .projects[index]
                                                            .contactPhone ??
                                                        ""),
                                              ],
                                            ),
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      taskDetailController.projects
                                          .removeAt(index);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
