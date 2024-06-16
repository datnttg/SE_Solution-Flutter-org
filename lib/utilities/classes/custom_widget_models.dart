class CDropdownMenuEntry<T> {
  T? value;
  String? labelText;
  CDropdownMenuEntry({this.value, this.labelText});

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'labelText': labelText,
    };
  }
}
