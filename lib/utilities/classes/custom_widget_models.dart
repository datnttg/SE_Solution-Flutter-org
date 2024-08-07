import 'package:flutter/material.dart';

class CDropdownMenuEntry<T> {
  T? value;
  String? labelText;
  Widget? labelWidget;
  CDropdownMenuEntry({this.value, this.labelText, this.labelWidget});

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'labelText': labelText,
    };
  }
}
