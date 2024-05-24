import 'package:flutter/material.dart';

class AppLocalization {
  final Locale locale;
  // late Map<String, String> _localizedMap;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // Future<void> load() async {
  // // String jsonStringValues = await rootBundle.loadString(
  // //     'lib/utilities/localization/languages/${locale.languageCode}.json');
  // String jsonStringValues = sharedPrefs.getDictionary();
  // Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
  // _localizedMap =
  //     mappedJson.map((key, value) => MapEntry(key, value.toString()));
  // }

  // String? translate(String key) {
  //   return _localizedMap[key];
  // }

  // Map<String, String> localizedMap() => _localizedMap;

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<AppLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'vi',
      'de',
      'es',
      'fr',
      'hi',
      'ja',
      'ko',
      'pt',
      'ru',
      'tr',
      'zh',
    ].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    // await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}
