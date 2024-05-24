import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../controllers/task_data_controllers.dart';
import '../../models/task_models.dart';

class TaskReferenceSubjectAdding extends StatelessWidget {
  const TaskReferenceSubjectAdding({super.key});

  @override
  Widget build(BuildContext context) {
    var taskDetailController = Get.find<TaskDetailController>();
    var taskReferenceSubjectAddingController =
        Get.put(TaskReferenceSubjectAddingController());
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var addressController = TextEditingController();
    var customerSourceController = TextEditingController();
    var customerSourceEntries = [
      {
        "id": "Website",
        "title": "Website",
      },
      {
        "id": "Facebook",
        "title": "Facebook",
      },
      {
        "id": "Other",
        "title": "(${sharedPrefs.translate('Other')})",
      },
    ]
        .map((e) => DropdownMenuEntry(value: e['id'], label: e['title']!))
        .toList();

    bool addSubject() {
      var subject = TaskReferenceSubjectModel(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          customerSource:
              taskReferenceSubjectAddingController.customerSource.value);
      if (taskDetailController.referenceSubjects
          .where((p0) => p0.phone == subject.phone)
          .isEmpty) {
        taskDetailController.referenceSubjects.add(subject);
        nameController.text = '';
        phoneController.text = '';
        addressController.text = '';
        customerSourceController.text = '';
        return true;
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: KText(sharedPrefs.translate('Duplicate')),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KText(
                          '${subject.phone} ${sharedPrefs.translate('is already existed!')}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK')),
                  ],
                ));
      }
      return false;
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(borderDefaultPadding),
              child: ResponsiveRow(context: context, children: [
                ResponsiveItem(
                    child: KTextFormField(
                  autoFocus: true,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return sharedPrefs.translate('This field is required!');
                    }
                    return null;
                  },
                  label: Text(sharedPrefs.translate('Name')),
                )),
                ResponsiveItem(
                    child: KTextFormField(
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return sharedPrefs.translate('This field is required!');
                    }
                    return null;
                  },
                  label: Text(sharedPrefs.translate('Phone')),
                )),
                ResponsiveItem(
                    widthRatio: 2,
                    child: KTextFormField(
                      controller: addressController,
                      label: Text(sharedPrefs.translate('Address')),
                    )),
                ResponsiveItem(
                    child: KDropdownMenu(
                  onSelected: (selected) {
                    taskReferenceSubjectAddingController.customerSource.value =
                        selected;
                  },
                  controller: customerSourceController,
                  dropdownMenuEntries: customerSourceEntries,
                      labelText: sharedPrefs.translate('Customer source'),
                ))
              ]),
            ),
          ),
          const SizedBox(
            height: defaultPadding * 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              KElevatedButton(
                backgroundColor: Colors.blue,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (addSubject()) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  sharedPrefs.translate('Add & Close'),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: defaultPadding * 3,
              ),
              KElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addSubject();
                  }
                },
                backgroundColor: Colors.green,
                child: Text(
                  sharedPrefs.translate('Add & New'),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
