import '../../../../utilities/classes/custom_widget_models.dart';

abstract class TaskFilterEvents {}

class ChangeTaskFilterType extends TaskFilterEvents {
  List<CDropdownMenuEntry>? selected;
  ChangeTaskFilterType(this.selected);
}

class ChangeTaskFilterStatus extends TaskFilterEvents {
  List<CDropdownMenuEntry>? selected;
  ChangeTaskFilterStatus(this.selected);
}

class ChangeTaskFilterAssignedUser extends TaskFilterEvents {
  List<CDropdownMenuEntry>? selected;
  ChangeTaskFilterAssignedUser(this.selected);
}

class ChangeTaskFilterCreatedUser extends TaskFilterEvents {
  List<CDropdownMenuEntry>? selected;
  ChangeTaskFilterCreatedUser(this.selected);
}
