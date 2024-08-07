import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_service.dart';
import 'constants/core_constants.dart';

final sharedPref = SharedPref();
late String currency;

class SharedPref {
  static SharedPreferences? _sharedPref;

  /// Implementations
  String getFunctions() => _sharedPref!.getString('functions').toString();
  void setFunctions(String functionValues) {
    _sharedPref!.setString('functions', functionValues);
  }

  bool get isDarkMode {
    // final brightness = SchedulerBinding.instance.window.platformBrightness;
    final brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark;
  }

  String getThemeMode() => _sharedPref?.getString('themeMode').toString() ?? '';
  void setThemeMode(String themeModeValue) =>
      _sharedPref!.setString('themeMode', themeModeValue);

  String getFirebaseToken() => _sharedPref?.getString('firebaseToken') ?? '';
  void setFirebaseToken(String firebaseToken) =>
      _sharedPref!.setString('firebaseToken', firebaseToken);

  String getFirebaseInstallationId() =>
      _sharedPref?.getString('firebaseInstallationId') ?? '';
  void setFirebaseInstallationId(String firebaseInstallationId) =>
      _sharedPref!.setString('firebaseInstallationId', firebaseInstallationId);

  String getUsername() => _sharedPref?.getString('username') ?? '';
  void setUsername(String username) =>
      _sharedPref!.setString('username', username);

  String getPassword() => _sharedPref?.getString('password') ?? '';
  void setPassword(String password) =>
      _sharedPref!.setString('password', password);

  String getUserId() => _sharedPref?.getString('userId') ?? '';
  void setUserId(String userId) => _sharedPref!.setString('userId', userId);

  String translate(String key) {
    var dictionary = _sharedPref!.getString('dictionary').toString();
    var res = json.decode(dictionary);
    return res[key] ?? key;
  }

  String getRefreshToken() => _sharedPref!.getString('refreshToken').toString();
  void setRefreshToken(String refreshToken) =>
      _sharedPref!.setString('refreshToken', refreshToken);

  String getAccessToken() => _sharedPref!.getString('accessToken').toString();
  void setAccessToken(String accessToken) =>
      _sharedPref!.setString('accessToken', accessToken);

  String getDictionary() => _sharedPref!.getString('dictionary')!;
  Future setDictionary(Locale? locale) async {
    locale ??= constants.defaultLocale;
    String jsonStringValues = await rootBundle.loadString(
        'lib/utilities/localization/languages/${locale.languageCode}.json');
    await _sharedPref!.setString('dictionary', jsonStringValues);
  }

  void setSharedPrefItems({required bool setCategoriesToDefault}) {
    if (setCategoriesToDefault) {
      _sharedPref!.clear();
    }
  }

  void removeItem(String itemName) {
    _sharedPref!.remove(itemName);
  }

  String get appCurrency =>
      _sharedPref!.getString('appCurrency') ?? constants.defaultLocaleName;
  set appCurrency(String appCurrency) =>
      _sharedPref!.setString('appCurrency', appCurrency);

  void getCurrency() {
    if (_sharedPref!.containsKey('appCurrency')) {
      var format = NumberFormat.simpleCurrency(locale: sharedPref.appCurrency);
      currency = format.currencySymbol;
    } else {
      var format =
          NumberFormat.simpleCurrency(locale: constants.defaultLocaleName);
      currency = format.currencySymbol;
    }
  }

  Locale getLocale() {
    String languageCode =
        _sharedPref!.getString('locale') ?? constants.defaultLocale.toString();
    return mapLocale(languageCode);
  }

  Future setLocale(Locale? locale) async {
    String localeString = locale.toString();
    _sharedPref!.setString('locale', localeString);
    await setDictionary(locale);
    // getCurrency();
  }

  String getVersion() => _sharedPref?.getString('version') ?? '';
  void setVersion(String version) => _sharedPref!.setString('version', version);

  // not yet use this set method
  String get selectedDate => _sharedPref!.getString('selectedDate')!;

  set selectedDate(String value) {
    _sharedPref!.setString('selectedDate', value);
  }

  String get dateFormat => _sharedPref!.getString('dateFormat') ?? 'dd-MM-yyyy';
  set dateFormat(String dateFormat) =>
      _sharedPref!.setString('dateFormat', dateFormat);

  bool get isPasscodeOn => _sharedPref!.getBool('isPasscodeOn') ?? false;
  set isPasscodeOn(bool value) => _sharedPref!.setBool('isPasscodeOn', value);

  String get passcodeScreenLock =>
      _sharedPref!.getString('passcodeScreenLock')!;
  set passcodeScreenLock(String value) =>
      _sharedPref!.setString('passcodeScreenLock', value);

  List<String> get parentExpenseItemNames =>
      _sharedPref!.getStringList('parent expense item names')!;
  set parentExpenseItemNames(List<String> parentExpenseItemNames) =>
      _sharedPref!
          .setStringList('parent expense item names', parentExpenseItemNames);

  sharePrefInit() async {
    _sharedPref ??= await SharedPreferences.getInstance();
    await sharedPref.setLocale(sharedPref.getLocale());
    sharedPref.setSharedPrefItems(setCategoriesToDefault: false);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setVersion(packageInfo.version);
  }
}
