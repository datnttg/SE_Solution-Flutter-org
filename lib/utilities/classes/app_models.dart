import 'package:flutter/material.dart';

class LocaleDescription {
  final Locale locale;
  final String name;

  const LocaleDescription(this.locale, this.name);
}

class ResponseModel {
  final bool success;
  final String responseMessege;
  final dynamic responseData;

  const ResponseModel({
    required this.success,
    required this.responseMessege,
    this.responseData,
  });
}
