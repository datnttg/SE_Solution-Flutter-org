import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_service.dart';
import 'constants/core_constants.dart';

final sharedPrefs = SharedPrefs();
late String currency;

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  /// Implementations
  String getFunctions() => _sharedPrefs!.getString('functions').toString();
  void setFunctions(String functionValues) {
    _sharedPrefs!.setString('functions', functionValues);
  }

  bool get isDarkMode {
    // final brightness = SchedulerBinding.instance.window.platformBrightness;
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  String getThemeMode() =>
      _sharedPrefs?.getString('themeMode').toString() ?? '';
  void setThemeMode(String themeModeValue) =>
      _sharedPrefs!.setString('themeMode', themeModeValue);

  String getFirebaseToken() => _sharedPrefs?.getString('firebaseToken') ?? '';
  void setFirebaseToken(String firebaseToken) =>
      _sharedPrefs!.setString('firebaseToken', firebaseToken);

  String getFirebaseInstallationId() =>
      _sharedPrefs?.getString('firebaseInstallationId') ?? '';
  void setFirebaseInstallationId(String firebaseInstallationId) =>
      _sharedPrefs!.setString('firebaseInstallationId', firebaseInstallationId);

  String getUsername() => _sharedPrefs?.getString('username') ?? '';
  void setUsername(String username) =>
      _sharedPrefs!.setString('username', username);

  String getPassword() => _sharedPrefs?.getString('password') ?? '';
  void setPassword(String password) =>
      _sharedPrefs!.setString('password', password);

  String getUserId() => _sharedPrefs?.getString('userId') ?? '';
  void setUserId(String userId) => _sharedPrefs!.setString('userId', userId);

  String translate(String key) {
    var dictionary = _sharedPrefs!.getString('dictionary').toString();
    var res = json.decode(dictionary);
    return res[key] ?? key;
  }

  String getRefreshToken() =>
      _sharedPrefs!.getString('refreshToken').toString();
  void setRefreshToken(String refreshToken) =>
      _sharedPrefs!.setString('refreshToken', refreshToken);

  String getAccessToken() => _sharedPrefs!.getString('accessToken').toString();
  void setAccessToken(String accessToken) =>
      _sharedPrefs!.setString('accessToken', accessToken);

  String getDictionary() => _sharedPrefs!.getString('dictionary')!;
  Future setDictionary(Locale? locale) async {
    locale ??= constants.defaultLocale;
    String jsonStringValues = await rootBundle.loadString(
        'lib/utilities/localization/languages/${locale.languageCode}.json');
    await _sharedPrefs!.setString('dictionary', jsonStringValues);
  }

  void setSharedPrefsItems({required bool setCategoriesToDefault}) {
    if (setCategoriesToDefault) {
      _sharedPrefs!.clear();
    }
  }

  void removeItem(String itemName) {
    _sharedPrefs!.remove(itemName);
  }

  String get appCurrency =>
      _sharedPrefs!.getString('appCurrency') ?? constants.defaultLocaleName;
  set appCurrency(String appCurrency) =>
      _sharedPrefs!.setString('appCurrency', appCurrency);

  void getCurrency() {
    if (_sharedPrefs!.containsKey('appCurrency')) {
      var format = NumberFormat.simpleCurrency(locale: sharedPrefs.appCurrency);
      currency = format.currencySymbol;
    } else {
      var format =
          NumberFormat.simpleCurrency(locale: constants.defaultLocaleName);
      currency = format.currencySymbol;
    }
  }

  Locale getLocale() {
    String languageCode =
        _sharedPrefs!.getString('locale') ?? constants.defaultLocale.toString();
    return mapLocale(languageCode);
  }

  Future setLocale(Locale? locale) async {
    String localeString = locale.toString();
    _sharedPrefs!.setString('locale', localeString);
    await setDictionary(locale);
    // getCurrency();
  }

  String getVersion() => _sharedPrefs?.getString('version') ?? '';
  void setVersion(String version) =>
      _sharedPrefs!.setString('version', version);

  // not yet use this set method
  String get selectedDate => _sharedPrefs!.getString('selectedDate')!;

  set selectedDate(String value) {
    _sharedPrefs!.setString('selectedDate', value);
  }

  String get dateFormat =>
      _sharedPrefs!.getString('dateFormat') ?? 'dd-MM-yyyy';
  set dateFormat(String dateFormat) =>
      _sharedPrefs!.setString('dateFormat', dateFormat);

  bool get isPasscodeOn => _sharedPrefs!.getBool('isPasscodeOn') ?? false;
  set isPasscodeOn(bool value) => _sharedPrefs!.setBool('isPasscodeOn', value);

  String get passcodeScreenLock =>
      _sharedPrefs!.getString('passcodeScreenLock')!;
  set passcodeScreenLock(String value) =>
      _sharedPrefs!.setString('passcodeScreenLock', value);

  List<String> get parentExpenseItemNames =>
      _sharedPrefs!.getStringList('parent expense item names')!;
  set parentExpenseItemNames(List<String> parentExpenseItemNames) =>
      _sharedPrefs!
          .setStringList('parent expense item names', parentExpenseItemNames);

  sharePrefsInit() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    await sharedPrefs.setLocale(sharedPrefs.getLocale());
    sharedPrefs.setSharedPrefsItems(setCategoriesToDefault: false);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setVersion(packageInfo.version);
  }
}
