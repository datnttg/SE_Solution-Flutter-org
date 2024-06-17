import 'task_assignment_model.dart';
import 'task_checklist_model.dart';
import 'task_more_detail_model.dart';
import 'task_participant_model.dart';
import 'task_subject_model.dart';

class TaskInfoModel {
  final TaskAssignmentModel taskAssignment;
  final List<TaskMoreDetailModel>? taskMoreDetail;
  final List<TaskCheckListModel>? checkList;
  final List<TaskParticipantModel>? participants;
  final List<TaskSubjectModel>? subjects;

  TaskInfoModel({
    required this.taskAssignment,
    this.taskMoreDetail,
    this.checkList,
    this.participants,
    this.subjects,
  });
}
