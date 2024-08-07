import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/custom_widgets.dart';
import '../../../../utilities/responsive.dart';
import '../../../../utilities/shared_preferences.dart';
import '../../../../utilities/ui_styles.dart';
import '../../services/task_services.dart';
import '../../controllers/task_data_controllers.dart';
import '../../models/task_models.dart';

class TaskProjectAdding extends StatefulWidget {
  const TaskProjectAdding({super.key});

  @override
  State<TaskProjectAdding> createState() => _TaskProjectAddingState();
}

class _TaskProjectAddingState extends State<TaskProjectAdding> {
  late Future<List> annex;
  late Future<List<DropdownMenuEntry>> annexEntries;
  late Future<List<DropdownMenuEntry>> countries;
  String? address;

  @override
  void initState() {
    Map parameters = {"ContractType": ""};
    var data = fetchContractAnnexs(parameters);
    annex = data.then((value) => value
        .map((e) => {
              "annexId": e["annex"]["id"],
              "annexStatus": e["annex"]["annexStatus"],
              "annexCode": e["annex"]["annexCode"],
              "implementationAddress": e["annex"]["implementationAddress"],
              "contactName": e["annex"]["contactName"],
              "contactPhone": e["annex"]["contractPhone"],
              "contractCode": e["contract"]["contractCode"],
              "subjectName": e["contract"]["subjectName"],
            })
        .toList());

    annexEntries = annex.then((value) => value
        .map((e) => DropdownMenuEntry(
              value: e["annexId"],
              label: (e["subjectName"] == null
                      ? ""
                      : "${e["subjectName"]} | ") +
                  (e["annexCode"] == null
                      ? ""
                      : "${sharedPref.translate("Annex code")}: ${e["annexCode"]} | ") +
                  (e["contractCode"] == null
                      ? ""
                      : "${sharedPref.translate("Contract code")}: ${e["contractCode"]}"),
              labelWidget: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        e["subjectName"],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(e["subjectName"]),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(e["subjectName"])
                    ],
                  ),
                ],
              ),
            ))
        .toList());

    countries = fetchLocaleDropdownEntries({"localeType": "1"});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var taskProjectAddingController = Get.put(TaskProjectAddingController());
    var taskDetailController = Get.find<TaskDetailController>();
    var formKey = GlobalKey<FormState>();
    var annexController = TextEditingController();
    var contactNameController = TextEditingController();
    var phoneController = TextEditingController();
    var countryController = TextEditingController();
    var provinceController = TextEditingController();
    var districtController = TextEditingController();
    var wardController = TextEditingController();
    var addressController = TextEditingController();
    var noteController = TextEditingController();
    bool addProject(TaskProjectModel project) {
      if (taskDetailController.projects
          .where((p0) => p0.annexId == project.annexId)
          .isEmpty) {
        taskDetailController.projects.add(project);
        return true;
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: KText(sharedPref.translate('Duplicate')),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KText(
                          '${sharedPref.translate('Contract annex')} ${sharedPref.translate('is already existed!')}'),
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

    return Obx(
      () => Column(
        children: [
          Form(
            key: formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(borderDefaultPadding),
                child: ResponsiveRow(context: context, children: [
                  ResponsiveItem(
                      percentWidthOnParent: 100,
                      child: KFutureDropdownMenu(
                        controller: annexController,
                        enableFilter: true,
                        label: Text(sharedPref.translate('Contract annex')),
                        hintText: sharedPref.translate('Choose one'),
                        dropdownMenuEntries: annexEntries,
                        initialSelection: "",
                        onSelected: (selected) {
                          taskProjectAddingController.annexId.value = selected;
                        },
                      )),
                  ResponsiveItem(
                      child: KTextFormField(
                    controller: contactNameController,
                    label: Text(sharedPref.translate('Contact name')),
                  )),
                  ResponsiveItem(
                      child: KTextFormField(
                    controller: phoneController,
                    label: Text(sharedPref.translate('Phone')),
                  )),
                  ResponsiveItem(
                      child: KFutureDropdownMenu(
                    controller: countryController,
                    label: Text(sharedPref.translate('Country')),
                    hintText: sharedPref.translate('Choose one'),
                    dropdownMenuEntries: countries,
                    initialSelection: taskProjectAddingController.countryId,
                    onSelected: (selected) async {
                      taskProjectAddingController.countryId.value = selected;
                      var provinces = await fetchLocaleDropdownEntries(
                          {"parentLocaleId": selected});
                      taskProjectAddingController.provinces.value = provinces;
                    },
                  )),
                  ResponsiveItem(
                      child: Obx(
                    () => KDropdownMenu(
                      controller: provinceController,
                      labelText: sharedPref.translate('Province'),
                      hintText: sharedPref.translate('Choose one'),
                      dropdownMenuEntries:
                          taskProjectAddingController.provinces.isEmpty
                              ? []
                              : taskProjectAddingController.provinces,
                      onSelected: (selected) async {
                        taskProjectAddingController.provinceId.value = selected;
                        var districts = await fetchLocaleDropdownEntries(
                            {"parentLocaleId": selected});
                        taskProjectAddingController.districts.value = districts;
                      },
                    ),
                  )),
                  ResponsiveItem(
                      child: KDropdownMenu(
                    controller: districtController,
                    labelText: sharedPref.translate('District'),
                    hintText: sharedPref.translate('Choose one'),
                    dropdownMenuEntries:
                        taskProjectAddingController.districts.isEmpty
                            ? []
                            : taskProjectAddingController.districts,
                    onSelected: (selected) async {
                      taskProjectAddingController.districtId.value = selected;
                      var wards = await fetchLocaleDropdownEntries(
                          {"parentLocaleId": selected});
                      taskProjectAddingController.wards.value = wards;
                    },
                  )),
                  ResponsiveItem(
                      child: KDropdownMenu(
                    controller: wardController,
                    labelText: sharedPref.translate('Ward'),
                    hintText: sharedPref.translate('Choose one'),
                    dropdownMenuEntries:
                        taskProjectAddingController.wards.isEmpty
                            ? []
                            : taskProjectAddingController.wards,
                    onSelected: (selected) {
                      taskProjectAddingController.wardId.value = selected;
                    },
                  )),
                  ResponsiveItem(
                      widthRatio: 2,
                      child: KTextFormField(
                        controller: addressController,
                        label: Text(sharedPref.translate('Address')),
                      )),
                  ResponsiveItem(
                      percentWidthOnParent: 100,
                      child: KTextFormField(
                        controller: noteController,
                        label: Text(sharedPref.translate('Note')),
                        maxLines: null,
                      )),
                ]),
              ),
            ),
          ),
          const SizedBox(
            height: defaultPadding * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              KElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var project = TaskProjectModel(
                        annexId: taskProjectAddingController.annexId.value,
                        countryId: taskProjectAddingController.countryId.value,
                        provinceId:
                            taskProjectAddingController.provinceId.value,
                        districtId:
                            taskProjectAddingController.districtId.value,
                        wardId: taskProjectAddingController.wardId.value,
                        annexCode: annexController.text,
                        address: (addressController.text == ""
                                ? ""
                                : "${addressController.text}, ") +
                            (wardController.text == ""
                                ? ""
                                : "${wardController.text}, ") +
                            (districtController.text == ""
                                ? ""
                                : "${districtController.text} ") +
                            (provinceController.text == ""
                                ? ""
                                : "${provinceController.text}, ") +
                            (countryController.text == ""
                                ? ""
                                : countryController.text),
                        contactName: contactNameController.text,
                        contactPhone: phoneController.text,
                        note: noteController.text);
                    if (addProject(project)) {
                      Navigator.pop(context);
                    }
                  }
                },
                backgroundColor: kPrimaryColor,
                child: Text(
                  sharedPref.translate('Add & Close'),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: defaultPadding * 5,
              ),
              KElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var project = TaskProjectModel(
                        annexId: taskProjectAddingController.annexId.value,
                        countryId: taskProjectAddingController.countryId.value,
                        provinceId:
                            taskProjectAddingController.provinceId.value,
                        districtId:
                            taskProjectAddingController.districtId.value,
                        wardId: taskProjectAddingController.wardId.value,
                        annexCode: annexController.text,
                        address: (addressController.text == ""
                                ? ""
                                : "${addressController.text}, ") +
                            (wardController.text == ""
                                ? ""
                                : "${wardController.text}, ") +
                            (districtController.text == ""
                                ? ""
                                : "${districtController.text} ") +
                            (provinceController.text == ""
                                ? ""
                                : "${provinceController.text}, ") +
                            (countryController.text == ""
                                ? ""
                                : countryController.text),
                        contactName: contactNameController.text,
                        contactPhone: phoneController.text,
                        note: noteController.text);
                    addProject(project);
                  }
                },
                backgroundColor: Colors.green,
                child: Text(
                  sharedPref.translate('Add & New'),
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
