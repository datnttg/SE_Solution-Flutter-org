import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_io/io.dart';
import '../screens/dashboard/dashboard_screen.dart';
import 'configs.dart';
import 'constants/core_constants.dart';
import 'custom_widgets.dart';
import 'responsive.dart';
import 'shared_preferences.dart';
import 'ui_styles.dart';

Future<String?> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    var webDeviceInfo = await deviceInfo.webBrowserInfo;
    return webDeviceInfo.appCodeName;
  } else if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id;
  } else if (Platform.isWindows) {
    var windowsDeviceInfo = await deviceInfo.windowsInfo;
    return windowsDeviceInfo.deviceId;
  }
  return null;
}

Future<String?> getDeviceName() async {
  var deviceInfo = DeviceInfoPlugin();
  if (kIsWeb) {
    var webDeviceInfo = await deviceInfo.webBrowserInfo;
    return webDeviceInfo.appName;
  } else if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.name;
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.model;
  } else if (Platform.isWindows) {
    var windowsDeviceInfo = await deviceInfo.windowsInfo;
    return windowsDeviceInfo.productName;
  }
  return null;
}

Future<bool> updateFirebaseToken(
    {firebaseToken, firebaseInstallationId}) async {
  Uri uri = Uri.parse('${constants.hostAddress}/UI/UpdateFirebaseToken');
  var deviceId = await getDeviceId();
  var deviceName = await getDeviceName();
  Map parameters = {
    "userId": sharedPrefs.getUserId(),
    "deviceId": deviceId,
    "deviceName": deviceName,
    "firebaseInstallationId": firebaseInstallationId,
    "firebaseToken": firebaseToken,
  };
  var response = await fetchData(uri, parameters: parameters);
  return response['success'];
}

Future<void> updateVersion(String downloadUrl) async {
  if (Platform.isAndroid || Platform.isIOS) {
    await Permission.storage.request();
    kShowProcessingDialog(title: sharedPrefs.translate('Processing...'));
    var path = '/storage/emulated/0/Download/se-solution.apk';
    var file = File(path);
    var res = await http.get(Uri.parse(downloadUrl));
    await file.writeAsBytes(res.bodyBytes);
    await OpenAppFile.open(path);
  }
}

Future<void> checkUpdate() async {
  try {
    if (!kIsWeb) {
      var checkVersionResponse = await fetchData(
          Uri.parse('${constants.hostAddress}/UI/TargetUIVersion'));
      var responseData = checkVersionResponse['responseData'];
      var targetVersion = responseData['targetVersion'];
      var appVersion = Config().appVersion;
      var targetVersionItems =
          targetVersion.split('.').map((e) => int.parse(e)).toList();
      var appVersionItems =
          appVersion.split('.').map((e) => int.parse(e)).toList();
      var hasNewVersion = false;

      if (targetVersionItems[0] > appVersionItems[0] ||
          (targetVersionItems[0] == appVersionItems[0] &&
              targetVersionItems[1] > appVersionItems[1]) ||
          (targetVersionItems[0] == appVersionItems[0] &&
              targetVersionItems[1] == appVersionItems[1] &&
              targetVersionItems[2] > appVersionItems[2])) {
        hasNewVersion = true;
      }

      if (hasNewVersion) {
        Get.dialog(
            PopScope(
              canPop: false, // Prevent dialog from closing
              child: AlertDialog(
                title: Text(sharedPrefs.translate('Update available')),
                content: SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${sharedPrefs.translate('A new version is available! You need to update to continue!')} '),
                        const SizedBox(height: defaultPadding * 2),
                        Text(
                            '- ${sharedPrefs.translate('New version')}: $targetVersion'),
                        Text(
                            '- ${sharedPrefs.translate('Current version')}: $appVersion'),
                        const SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                        sharedPrefs.translate('Download update').toUpperCase()),
                    onPressed: () async {
                      String downloadUrl = "";
                      if (Platform.isAndroid) {
                        downloadUrl = responseData['downloadUrlForAndroid'];
                      } else if (Platform.isIOS) {
                        downloadUrl = responseData['downloadUrlForIOS'];
                      }
                      await updateVersion(downloadUrl);
                    },
                  )
                ],
              ),
            ),
            barrierDismissible: false);
      }
    }
  } catch (ex) {
    () {};
  }
}

kPushNamed(BuildContext context, String route) {
  /// Check role before pushing
  Navigator.pushNamed(context, route);
}

DateTime kDateTimeConvert(String dateTimeString) {
  try {
    return DateTime.parse(dateTimeString);
  } catch (e) {
    var data = dateTimeString.split(' ');
    var date = [];
    if (data[0].split('-').length > 1) {
      date = data[0].split('-');
    }
    if (data[0].split('/').length > 1) {
      date = data[0].split('/');
    }
    var time = [];
    if (data.length > 1) {
      time = data[1].split(':');
    }
    return DateTime(
      date.length < 3 ? DateTime.now().year : int.parse(date[2]),
      date.length < 2 ? 1 : int.parse(date[1]),
      date.isEmpty ? 1 : int.parse(date[0]),
      time.isEmpty ? 0 : int.parse(time[0]),
      time.length < 2 ? 0 : int.parse(time[1]),
      // time.length < 3 ? 0 : int.parse(time[2]),
    );
  }
}

String kDateTimeString(DateTime datetime) {
  Duration offset = datetime.timeZoneOffset;
  String dateTime = datetime.toIso8601String();
  // - or -
  // String dateTime = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(now);
  // ----------
  String utcHourOffset = (offset.isNegative ? '-' : '+') +
      offset.inHours.abs().toString().padLeft(2, '0');
  String utcMinuteOffset =
      (offset.inMinutes - offset.inHours * 60).toString().padLeft(2, '0');

  String dateTimeWithOffset = '$dateTime$utcHourOffset:$utcMinuteOffset';
  return dateTimeWithOffset;
}

String kDateTimeFormat(DateTime datetime, DateFormat dateFormat) {
  return dateFormat.format(datetime.toLocal());
}

Future<void> login(BuildContext context, Map payload) async {
  Uri hostAddress = Uri.parse('${constants.hostAddress}/Auth/AccessToken/');
  try {
    var responseBody = await fetchDataUI(hostAddress, parameters: payload);
    var responseData = responseBody['responseData'];
    if (responseBody['success'] == true) {
      var accessToken = responseData['accessToken'];
      var refreshToken = responseData['refreshToken'];
      sharedPrefs.setAccessToken(accessToken);
      sharedPrefs.setRefreshToken(refreshToken);
      sharedPrefs.setUserId(responseData['userId']);
      sharedPrefs.setUsername(payload['username']);
      sharedPrefs.setPassword(payload['password']);
      updateFirebaseToken(
          firebaseToken: sharedPrefs.getFirebaseToken(),
          firebaseInstallationId: sharedPrefs.getFirebaseInstallationId());
      var getFunctions = await getAppFunctions();
      if (context.mounted && getFunctions) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
        Future.delayed(const Duration(milliseconds: 350), () {
          checkUpdate();
        });
      } else if (context.mounted) {
        Navigator.pop(context);
      }
    }
  } catch (e) {
    Get.dialog(
        AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(sharedPrefs.translate("Connection failed!")),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        barrierDismissible: true);
  }
}

kShowToast({required String title, required String content, String? style}) {
  Color? bgColor = Colors.white;
  Icon? icon;
  double iconSize = 36;
  if (style == 'success') {
    icon = Icon(
      Icons.check_circle_outline,
      color: Colors.green,
      size: iconSize,
    );
  } else if (style == 'danger') {
    icon = Icon(
      Icons.circle_notifications_outlined,
      color: Colors.red,
      size: iconSize,
    );
  } else if (style == 'warning') {
    icon = Icon(
      Icons.info_outline,
      color: Colors.orangeAccent,
      size: iconSize,
    );
  }
  Get.snackbar(
    title,
    content,
    maxWidth: 300,
    isDismissible: false,
    backgroundColor: bgColor,
    icon: icon,
    snackPosition: SnackPosition.BOTTOM,
  );
}

kShowAlert({required Widget body, String? title}) {
  return Get.dialog(
    AlertDialog(
      title:
          title == null ? null : KSelectableText(sharedPrefs.translate(title)),
      content: SingleChildScrollView(
        child: body,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ),
    barrierDismissible: false, // user must tap button!
  );
}

kShowDialog(Widget child, {String? title}) {
  return Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(children: [
        Expanded(
            child: title == null
                ? Container()
                : SelectableText(
                    sharedPrefs.translate(title),
                  )),
        KElevatedButton(
          msBackgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return kSecondaryColor;
            }
            if (states.contains(MaterialState.pressed)) {
              return kButtonPressedBgColor;
            }
            return kButtonBgColor1;
          }),
          child: Text(
            sharedPrefs.translate('Close'),
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Get.back();
          },
        )
      ]),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(child: child),
      ),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
    ),
  );
}

kShowProcessingDialog({String? title}) {
  Get.dialog(
    AlertDialog(
      title: title == null ? null : Text(title),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

Future<bool> getAppFunctions() async {
  Uri hostAddress = Uri.parse('${constants.hostAddress}/Account/GetMenu');
  try {
    var response = await fetchData(hostAddress);
    if (response['success'] == true) {
      var functions = jsonEncode(response['responseData']);
      sharedPrefs.setFunctions(functions);
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}

Future<bool> refreshToken() async {
// var httpClient = http.Client();
  try {
    var url = Uri.parse('${constants.hostAddress}/token/refresh');
    Map payload = {
      'AccessToken': sharedPrefs.getAccessToken(),
      'RefreshToken': sharedPrefs.getRefreshToken(),
    };
// var response = await httpClient.post(url,
//     headers: {
//       'Accept': '*/*',
//       'Access-Control-Allow-Origin': '*',
//       'Content-Type': 'application/json',
//     },
//     encoding: Encoding.getByName('utf-8'),
//     body: jsonEncode(payload));
// var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    var responseBody = await fetchData(url, parameters: payload);
    if (responseBody['success'] == true) {
      var responseData = responseBody['responseData'];
      sharedPrefs.setAccessToken(responseData['accessToken']);
      updateFirebaseToken(
          firebaseToken: sharedPrefs.getFirebaseToken(),
          firebaseInstallationId: sharedPrefs.getFirebaseInstallationId());
      checkUpdate();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
// finally {
//   httpClient.close();
// }
}

Future<Map> fetchDataUI(Uri hostAddress,
    {Map? parameters, String? method}) async {
  kShowProcessingDialog(title: sharedPrefs.translate("Processing..."));
  await Future.delayed(const Duration(milliseconds: 300));
  var response =
      await fetchData(hostAddress, parameters: parameters, method: method);
  Get.back();
  if (response['success'] == false && response['responseMessage'] != '') {
    // kShowAlert(
    //     title: sharedPrefs.translate('Fail'),
    //     body: Text(response['responseMessage']));
    kShowToast(
      title: sharedPrefs.translate('Fail'),
      content: response['responseMessage'],
      style: 'danger',
    );
  } else if (response['success'] == false) {
    // kShowAlert(
    //     title: sharedPrefs.translate('Fail'),
    //     body: Text(sharedPrefs.translate("Connection failed!")));
    kShowToast(
      title: sharedPrefs.translate('Fail'),
      content: sharedPrefs.translate("Connection failed!"),
      style: 'danger',
    );
  }
  return response;
}

Future<Map> fetchData(Uri hostAddress,
    {Map? parameters, String? method}) async {
  try {
    var headers = {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
      'Content-Type': 'application/json',
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      'Authorization': 'Bearer ${sharedPrefs.getAccessToken()}',
      "Localization": sharedPrefs.getLocale().toString(),
    };
    var body = jsonEncode(parameters);
    var encoding = Encoding.getByName('utf-8');
    http.Response response;
    switch (method) {
      case 'get':
        response = await http.get(hostAddress, headers: headers)
// .timeout(const Duration(seconds: 10))
            ;
        break;
      case 'post':
        response = await http.post(hostAddress,
            headers: headers, body: body, encoding: encoding);
        break;
      case 'put':
        response = await http.put(hostAddress,
            headers: headers, body: body, encoding: encoding);
        break;
      case 'delete':
        response = await http.delete(hostAddress,
            headers: headers, body: body, encoding: encoding);
        break;
      default:
        response = await http.post(hostAddress,
            headers: headers, body: body, encoding: encoding);
        break;
    }

    if (response.statusCode == 401) {
      var success = await refreshToken();
      if (success) {
        return fetchData(hostAddress, parameters: parameters);
      } else {
        navigatorKey.currentState?.pushNamed('/login');
        return {};
      }
    }
    var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    return responseBody;
  } catch (e) {
    return {
      "success": false,
      "responseMessage": sharedPrefs.translate("Connection failed!")
    };
  }
}

void showProgressing(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            Text("Loading..."),
          ],
        ),
      );
    },
  );
}

Locale mapLocale(String localeString) {
  switch (localeString) {
    case 'en_US':
      return const Locale('en', 'US');
    case 'vi_VN':
      return const Locale('vi', "VN");
    case 'de_DE':
      return const Locale('de', "DE");
    case 'es_ES':
      return const Locale('es', 'ES');
    case 'fr_FR':
      return const Locale('fr', "FR");
    case 'hi_IN':
      return const Locale('hi', "IN");
    case 'ja_JP':
      return const Locale('ja', "JP");
    case 'ko_KR':
      return const Locale('ko', 'KR');
    case 'pt_PT':
      return const Locale('pt', "PT");
    case 'ru_RU':
      return const Locale('ru', "RU");
    case 'tr_TR':
      return const Locale('tr', "TR");
    case 'zh_CN':
      return const Locale('zh', "CN");
    default:
      return const Locale('en', 'US');
  }
}
