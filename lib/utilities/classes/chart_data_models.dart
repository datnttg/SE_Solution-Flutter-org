class ProjectSummaryData {
  final Map projectStatus;
  final Map summaryData;
  final List<TimeChartData> timelyChartData;
  final List<TimeChartData> daiyChartData;
  final List<TimeChartData> monthlyChartData;
  final List<TimeChartData> yearlyChartData;

  const ProjectSummaryData(
    this.projectStatus,
    this.summaryData,
    this.timelyChartData,
    this.daiyChartData,
    this.monthlyChartData,
    this.yearlyChartData,
  );
}

class TimeChartData {
  DateTime time;
  double value;

  TimeChartData({required this.time, required this.value});

  factory TimeChartData.fromJson(Map<String, dynamic> json) => TimeChartData(
        time: DateTime.parse(json['time'] as String),
        value: json['value'] ?? 0,
      );

  // TimeChartData.fromJson(Map<String, dynamic> json) {
  //   time = json['time'];
  //   value = json['value'];
  // }

  // Map<String, dynamic> toJson() => {
  //       'time': time,
  //       'value': value,
  //     };
}

// class MenuModel {
//   String? id;
//   String? code;
//   String? parentId;
//   String? link;
//   String? type;
//   String? icon;
//   String? credentialCode;
//   int? order;
//   String? note;
//   String? en;
//   String? vi;

//   MenuModel(this.id, this.code, this.parentId, this.link, this.type, this.icon,
//       this.credentialCode, this.order, this.note, this.en, this.vi);

//   MenuModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     parentId = json['parentId'];
//     link = json['link'];
//     type = json['type'];
//     icon = json['icon'];
//     credentialCode = json['credentialCode'];
//     order = json['order'];
//     note = json['note'];
//     en = json['en'];
//     vi = json['vi'];
//   }
// }
