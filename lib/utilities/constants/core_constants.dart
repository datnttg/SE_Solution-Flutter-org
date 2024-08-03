import 'dart:ui';
import 'package:flutter/foundation.dart';
import '../classes/app_models.dart';

final constants = Constants();

class Constants {
  String appName = 'SE Solution';
  String hostAddress = kDebugMode == false
      ? 'https://api.sepower.vn'
      // : 'https://test-api.sepower.vn';
      : kIsWeb
          ? 'https://test-api.sepower.vn'
          : 'http://localhost:5155';

  String defaultLocaleName = 'vi_VN';
  Locale defaultLocale = const Locale('vi', 'VN');
  String? fcmApiKey;

  List<LocaleDescription> supportedLocales = <LocaleDescription>[
    const LocaleDescription(Locale('en', 'US'), 'English'),
    const LocaleDescription(Locale('vi', 'VN'), 'Tiếng Việt'),
  ];

// List<Locale> supportedLocales = <Locale>[
//   const Locale('en', 'US'),
//   const Locale('vi', 'VN'),
//   const Locale('de', "DE"),
//   const Locale('es', 'ES'),
//   const Locale('fr', "FR"),
//   const Locale('hi', "IN"),
//   const Locale('ja', "JP"),
//   const Locale('ko', 'KR'),
//   const Locale('pt', "PT"),
//   const Locale('ru', "RU"),
//   const Locale('tr', "TR"),
//   const Locale('zh', "CN"),
// ];
}
