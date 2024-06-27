import 'package:flutter/material.dart';

class LocaleDescription {
  final Locale locale;
  final String name;

  const LocaleDescription(this.locale, this.name);
}

class ResponseModel {
  final bool success;
  final String responseMessage;
  final dynamic responseData;

  const ResponseModel({
    required this.success,
    required this.responseMessage,
    this.responseData,
  });
}
