import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utilities/app_service.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/enums/ui_enums.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../controllers/task_data_controllers.dart';
import '../../controllers/task_ui_controllers.dart';
import '../../models/task_models.dart';

class TaskReferenceSubjectList extends StatelessWidget {
  const TaskReferenceSubjectList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskReferenceSubjectAddingController =
        Get.put(TaskReferenceSubjectAddingController());
    final taskUIController = Get.find<TaskUIController>();
    final taskDetailController = Get.find<TaskDetailController>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final customerSourceController = TextEditingController();
    final addSubjectFormKey = GlobalKey<FormState>();

    void resetNewSubjectFields() {
      nameController.text = '';
      taskReferenceSubjectAddingController.name.value = '';
      phoneController.text = '';
      taskReferenceSubjectAddingController.phone.value = '';
      addressController.text = '';
      taskReferenceSubjectAddingController.address.value = '';
      customerSourceController.text = '';
      taskReferenceSubjectAddingController.customerSource.value = '';
    }

    bool addSubject() {
      var subject = TaskReferenceSubjectModel(
          name: taskReferenceSubjectAddingController.name.value,
          phone: taskReferenceSubjectAddingController.phone.value,
          address: taskReferenceSubjectAddingController.address.value,
          customerSource:
              taskReferenceSubjectAddingController.customerSource.value);
      if (subject.name == '' || subject.phone == '') {
        kShowAlert(
            body:
                KText(sharedPref.translate('Please input required field(s)!')),
            title: sharedPref.translate('Missing data'));
        return false;
      }
      if (taskDetailController.referenceSubjects
          .where((p0) => p0.phone == subject.phone)
          .isEmpty) {
        taskDetailController.referenceSubjects.add(subject);
        resetNewSubjectFields();
        return true;
      } else {
        kShowAlert(
            body: KText(
                '${subject.phone} ${sharedPref.translate('is already existed!')}'),
            title: sharedPref.translate('Duplicate'));
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) => AlertDialog(
        //           title: KText(sharedPref.translate('Duplicate')),
        //           content: Row(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               KText(
        //                   '${subject.phone} ${sharedPref.translate('is already existed!')}'),
        //             ],
        //           ),
        //           actions: [
        //             TextButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 child: const Text('OK')),
        //           ],
        //         ));
      }
      return false;
    }

    var btnAdd = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        KElevatedButton(
          onPressed: () {
            if (addSubjectFormKey.currentState!.validate()) {
              addSubject();
            }
          },
          child: Text(
            sharedPref.translate('Confirm'),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
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
        "title": "(${sharedPref.translate('Other')})",
      },
    ]
        .map((e) => DropdownMenuEntry(value: e['id'], label: e['title']!))
        .toList();

    return Column(
      children: [
        /// BUTTON
        Row(
          children: [
            Expanded(
              child: KSelectableText(
                sharedPref.translate('Reference subject(s)'),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: largeTextSize),
              ),
            ),
          ],
        ),
        taskUIController.mode.value == ScreenModeEnum.view
            ? Container()
            : Form(
                key: addSubjectFormKey,
                child: Row(
                  children: [
                    Expanded(
                      child: ResponsiveRow(
                        context: context,
                        children: [
                          ResponsiveItem(
                              child: KTextFormField(
                            label: KText(sharedPref.translate('Name')),
                            controller: nameController,
                            required: true,
                            onChanged: (p0) {
                              taskReferenceSubjectAddingController.name.value =
                                  p0;
                            },
                          )),
                          ResponsiveItem(
                              child: KTextFormField(
                            label: KText(sharedPref.translate('Phone')),
                            controller: phoneController,
                            required: true,
                            onChanged: (p0) {
                              taskReferenceSubjectAddingController.phone.value =
                                  p0;
                            },
                          )),
                          ResponsiveItem(
                              widthRatio: 2,
                              child: KTextFormField(
                                label: KText(sharedPref.translate('Address')),
                                controller: addressController,
                                onChanged: (p0) {
                                  taskReferenceSubjectAddingController
                                      .address.value = p0;
                                },
                              )),
                          ResponsiveItem(
                              child: KDropdownMenu(
                            labelText: sharedPref.translate('Customer source'),
                            controller: customerSourceController,
                            dropdownMenuEntries: customerSourceEntries,
                            onSelected: (selected) {
                              taskReferenceSubjectAddingController
                                  .customerSource.value = selected;
                            },
                          )),
                          ResponsiveItem(
                            widthRatio:
                                Responsive.isSmallWidth(context) ? 1 : 0,
                            child: btnAdd,
                          )
                        ],
                      ),
                    ),
                    Responsive.isSmallWidth(context) ? Container() : btnAdd,
                  ],
                ),
              ),
        const SizedBox(
          height: defaultPadding * 3,
        ),

// SUBJECT LIST
        Obx(
          () => taskDetailController.referenceSubjects.isEmpty
              ? Container()
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            taskDetailController.referenceSubjects.length,
                        itemBuilder: (context, index) {
// Define child widgets
                          Widget wgtName = KSelectableText(
                            taskDetailController
                                    .referenceSubjects[index].name ??
                                "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                          Widget wgtAddress = taskDetailController
                                      .referenceSubjects[index].address ==
                                  ''
                              ? Container()
                              : KSelectableText(
                                  taskDetailController
                                          .referenceSubjects[index].address ??
                                      "",
                                  warpText: true,
                                  style:
                                      const TextStyle(fontSize: smallTextSize),
                                );
                          Widget wgtCustomerSource = SizedBox(
                            width: 200,
                            child: taskDetailController.referenceSubjects[index]
                                        .customerSource ==
                                    ''
                                ? Container()
                                : Row(
                                    children: [
                                      Text(
                                          '${sharedPref.translate('Customer source')}: '),
                                      KText(taskDetailController
                                              .referenceSubjects[index]
                                              .customerSource ??
                                          ""),
                                    ],
                                  ),
                          );
                          Widget wgtPhone = SizedBox(
                            width: 150,
                            child: taskDetailController
                                        .referenceSubjects[index].phone ==
                                    null
                                ? Container()
                                : InkWell(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          'tel://${taskDetailController.referenceSubjects[index].phone}'));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.phone),
                                        Container(
                                          width: defaultPadding,
                                        ),
                                        KSelectableText(taskDetailController
                                                .referenceSubjects[index]
                                                .phone ??
                                            ""),
                                      ],
                                    ),
                                  ),
                          );
                          Widget wgtDeleteButton =
                              taskUIController.mode.value != ScreenModeEnum.edit
                                  ? Container()
                                  : InkWell(
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        taskDetailController.referenceSubjects
                                            .removeAt(index);
                                      },
                                    );

// Return
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 300,
                                                  child: Row(
                                                    children: [wgtName],
                                                  ),
                                                ),
                                                Responsive.isSmallWidth(context)
                                                    ? Container()
                                                    : Row(
                                                        children: [wgtAddress],
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Responsive.isSmallWidth(context)
                                              ? Container()
                                              : wgtCustomerSource,
                                          wgtPhone,
                                        ],
                                      ),
                                      Responsive.isSmallWidth(context) == false
                                          ? Container()
                                          : Row(
                                              children: [wgtAddress],
                                            ),
                                      Responsive.isSmallWidth(context) == false
                                          ? Container()
                                          : wgtCustomerSource,
                                    ],
                                  ),
                                ),
                                wgtDeleteButton,
                              ],
                            ),
                          );
                        }),
                  ),
                ),
        )
      ],
    );
  }
}
