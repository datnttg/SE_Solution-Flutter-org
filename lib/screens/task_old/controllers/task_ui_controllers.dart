import 'package:get/get.dart';
import '../../../utilities/enums/ui_enums.dart';

class TaskUIController extends GetxController {
  var mode = ScreenModeEnum.view.obs;
  var btnBack = DisplayTypeEnum.normal.obs;
  var btnSave = DisplayTypeEnum.hidden.obs;
  var btnConfirm = DisplayTypeEnum.hidden.obs;
  var btnReject = DisplayTypeEnum.hidden.obs;
  var btnUpdate = DisplayTypeEnum.hidden.obs;
  var btnRevoke = DisplayTypeEnum.hidden.obs;
  var fieldMappings = [].obs;
  var showReferenceSubjects = false.obs;

  void resetTaskDetailUI() {
    mode = ScreenModeEnum.view.obs;
    btnBack = DisplayTypeEnum.normal.obs;
    btnSave = DisplayTypeEnum.hidden.obs;
    btnConfirm = DisplayTypeEnum.hidden.obs;
    btnReject = DisplayTypeEnum.hidden.obs;
    btnUpdate = DisplayTypeEnum.hidden.obs;
    fieldMappings = [].obs;
    showReferenceSubjects = false.obs;
  }

  void showTaskSubject(String taskTypeId) {
    if (fieldMappings
        .where((element) =>
            element['conditionValue'].toString().toLowerCase() ==
            taskTypeId.toString().toLowerCase())
        .isNotEmpty) {
      showReferenceSubjects.value = true;
    } else {
      showReferenceSubjects.value = false;
    }
  }
}
