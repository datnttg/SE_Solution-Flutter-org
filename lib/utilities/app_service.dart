import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:open_app_file/open_app_file.dart';
import 'package:path/path.dart';
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
    "userId": sharedPref.getUserId(),
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
    kShowProcessingDialog(title: sharedPref.translate('Processing...'));
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
                title: Text(sharedPref.translate('Update available')),
                content: SizedBox(
                  height: 100,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${sharedPref.translate('A new version is available! You need to update to continue!')} '),
                        const SizedBox(height: defaultPadding * 2),
                        Text(
                            '- ${sharedPref.translate('New version')}: $targetVersion'),
                        Text(
                            '- ${sharedPref.translate('Current version')}: $appVersion'),
                        const SizedBox(height: defaultPadding * 2),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                        sharedPref.translate('Download update').toUpperCase()),
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

String numberFormat0(double number) {
  return nf0.format(number);
}

String numberFormat1(double number) {
  return nf1.format(number);
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
    var responseBody = await fetchDataUI(hostAddress,
        parameters: payload, showSuccessNotification: false);
    var responseData = responseBody['responseData'];
    if (responseBody['success'] == true) {
      var accessToken = responseData['accessToken'];
      var refreshToken = responseData['refreshToken'];
      sharedPref.setAccessToken(accessToken);
      sharedPref.setRefreshToken(refreshToken);
      sharedPref.setUserId(responseData['userId']);
      sharedPref.setUsername(payload['username']);
      sharedPref.setPassword(payload['password']);
      updateFirebaseToken(
          firebaseToken: sharedPref.getFirebaseToken(),
          firebaseInstallationId: sharedPref.getFirebaseInstallationId());
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
      // } else {
      //   kShowToast(
      //     title: sharedPref.translate('Fail'),
      //     content: sharedPref.translate('Login failed'),
      //     detail: responseData?.toString(),
      //     style: 'danger',
      //   );
    }
  } catch (e) {
    Get.dialog(
        AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(sharedPref.translate("Connection failed!")),
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

kShowToast({
  required String title,
  required String content,
  String? detail,
  String? style,
}) {
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
  Get.snackbar(title, content,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content),
          detail?.isNotEmpty ?? false
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${sharedPref.translate('Detail')}: ',
                      style: const TextStyle(fontSize: smallTextSize),
                    ),
                    Flexible(
                      child: SelectableText(
                        detail!,
                        style: const TextStyle(fontSize: smallTextSize),
                      ),
                    )
                  ],
                )
              : const SizedBox()
        ],
      ),
      icon: icon,
      maxWidth: 400,
      isDismissible: true,
      backgroundColor: kBgColor,
      borderColor: cBoxBorderColor,
      borderWidth: 1,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(bottom: 70));
}

kShowAlert({required Widget body, String? title}) {
  return Get.dialog(
    AlertDialog(
      title:
          title == null ? null : KSelectableText(sharedPref.translate(title)),
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

kShowDialog(
  Widget child, {
  String? title,
  double? maxWidth,
  bool? dismissible = true,
  Function? onCancel,
}) {
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
                    sharedPref.translate(title),
                  )),
        if (dismissible == true)
          KElevatedButton(
            msBackgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return kSecondaryColor;
              }
              if (states.contains(WidgetState.pressed)) {
                return kButtonPressedBgColor;
              }
              return kButtonBgColor1;
            }),
            child: Text(
              sharedPref.translate('Close'),
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              onCancel?.call();
              Get.back();
            },
          )
      ]),
      content: SizedBox(
        width: maxWidth ?? double.maxFinite,
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
      sharedPref.setFunctions(functions);
      return true;
    }
  } catch (e) {
    return false;
  }
  return false;
}

Future<bool> refreshToken() async {
  try {
    var url = Uri.parse('${constants.hostAddress}/token/refresh');
    Map payload = {
      'AccessToken': sharedPref.getAccessToken(),
      'RefreshToken': sharedPref.getRefreshToken(),
    };
    var responseBody = await fetchData(url, parameters: payload);
    if (responseBody['success'] == true) {
      var responseData = responseBody['responseData'];
      sharedPref.setAccessToken(responseData['accessToken']);
      updateFirebaseToken(
          firebaseToken: sharedPref.getFirebaseToken(),
          firebaseInstallationId: sharedPref.getFirebaseInstallationId());
      checkUpdate();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<Map> streamData(Uri hostAddress,
    {Map<String, String>? parameters,
    List<Map<String, dynamic>>? fileGroups,
    String? method,
    bool? showProgressingDialog = true,
    bool? showSuccessNotification = true}) async {
  debugPrint("streamData(): $hostAddress");
  StreamSubscription? subscription;

  try {
    var request = http.MultipartRequest(method ?? 'POST', hostAddress);
    request = request
      ..headers['Accept'] = '*/*'
      ..headers['Access-Control-Allow-Origin'] = '*'
      ..headers['Content-Type'] = 'application/json'
      ..headers['Authorization'] = 'Bearer ${sharedPref.getAccessToken()}'
      ..headers['Localization'] = sharedPref.getLocale().toString();

    if (parameters != null) {
      request.fields.addAll(parameters);
    }

    if (fileGroups != null) {
      for (var group in fileGroups) {
        String groupName = group['groupName'];
        List<File> files = group['files'];

        request.fields['groupName'] = groupName;

        for (var file in files) {
          var stream = http.ByteStream(Stream.castFrom(file.openRead()));
          var length = await file.length();
          var multipartFile = http.MultipartFile('files', stream, length,
              filename: basename(file.path));
          request.files.add(multipartFile);
        }
      }
    }

    var response = await request.send();
    var totalBytes = request.contentLength;
    var bytesSent = 0;

    var broadcastStream = response.stream.asBroadcastStream();
    subscription = broadcastStream.listen((value) {
      bytesSent += value.length;
      double progress = bytesSent / totalBytes;
      if (showProgressingDialog == true) {
        kShowDialog(
          LinearProgressIndicator(value: progress),
          title: sharedPref.translate('Uploading...'),
          maxWidth: 100,
          dismissible: true,
          onCancel: () {
            subscription?.cancel();
          },
        );
      }
    });

    var responseBodyBytes = await broadcastStream.toBytes();
    var responseBody = jsonDecode(utf8.decode(responseBodyBytes));

    subscription.cancel();

    if (responseBody['success'] == null) {
      kShowToast(
        title: sharedPref.translate('Fail'),
        content: sharedPref.translate("Connection failed!"),
        style: 'danger',
      );
    } else if (responseBody['success'] == true) {
      if (showSuccessNotification == true) {
        kShowToast(
          title: sharedPref.translate('Success'),
          content: responseBody['responseMessage'],
          style: 'success',
        );
      }
    } else {
      if (responseBody['responseMessage'] == null) {
        kShowToast(
          title: sharedPref.translate('Fail'),
          content: responseBody['title'].toString(),
          style: 'danger',
        );
      } else {
        kShowToast(
          title: sharedPref.translate('Fail'),
          content: responseBody['responseMessage'],
          style: 'danger',
        );
      }
    }

    if (showProgressingDialog == true) {
      Get.back();
    }

    return responseBody;
  } catch (e) {
    debugPrint("streamData() error: $e");
    return {
      "success": false,
      "responseMessage": sharedPref.translate("Connection failed!")
    };
  } finally {
    if (showProgressingDialog == true) {
      Get.back();
    }
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

Future<Map> fetchDataUI(Uri url,
    {Map? parameters,
    String? method,
    String? contentType,
    bool? showSuccessNotification = true}) async {
  kShowProcessingDialog(title: sharedPref.translate("Processing..."));
  await Future.delayed(const Duration(milliseconds: 300));
  var response = await fetchData(url, parameters: parameters, method: method);
  Get.back();
  if (response['success'] == true) {
    if (showSuccessNotification == false) {
      return response;
    } else {
      kShowToast(
        title: sharedPref.translate('Success'),
        content: response['responseMessage'],
        style: 'success',
      );
    }
  } else {
    if (response['responseMessage'] != '') {
      kShowToast(
        title: sharedPref.translate('Fail'),
        content: response['responseMessage'],
        style: 'danger',
      );
    } else if (response['success'] == false) {
      kShowToast(
        title: sharedPref.translate('Fail'),
        content: sharedPref.translate("Connection failed!"),
        style: 'danger',
      );
    } else {
      kShowToast(
        title: sharedPref.translate('Fail'),
        content: response['title'].toString(),
        style: 'danger',
      );
    }
  }
  return response;
}

Future<Map> fetchData(Uri url, {Map? parameters, String? method}) async {
  debugPrint("fetchData(): $url");
  try {
    var body = jsonEncode(parameters);
    // var headers = {
    //   'Accept': '*/*',
    //   'Access-Control-Allow-Origin': '*',
    //   'Content-Type': 'application/json',
    //   'Authorization': 'Bearer ${sharedPref.getAccessToken()}',
    //   "Localization": sharedPref.getLocale().toString(),
    // };
    // var encoding = Encoding.getByName('utf-8');
    // http.Response response;
    // switch (method) {
    //   case 'get':
    //     response = await http.get(url, headers: headers)
    //         // .timeout(const Duration(seconds: 10))
    //         ;
    //     break;
    //   case 'post':
    //     response = await http.post(url,
    //         headers: headers, body: body, encoding: encoding);
    //     break;
    //   case 'put':
    //     response = await http.put(url,
    //         headers: headers, body: body, encoding: encoding);
    //     break;
    //   case 'delete':
    //     response = await http.delete(url,
    //         headers: headers, body: body, encoding: encoding);
    //     break;
    //   default:
    //     response = await http.post(url,
    //         headers: headers, body: body, encoding: encoding);
    //     break;
    // }
    var request = http.Request(method ?? 'POST', url);
    request = request
      ..headers['Accept'] = '*/*'
      ..headers['Access-Control-Allow-Origin'] = '*'
      ..headers['Content-Type'] = 'application/json'
      ..headers['Authorization'] = 'Bearer ${sharedPref.getAccessToken()}'
      ..headers['Localization'] = sharedPref.getLocale().toString()
      ..body = body;

    var response = await request.send();
    if (response.statusCode == 401) {
      var success = await refreshToken();
      if (success) {
        return fetchData(url, parameters: parameters);
      } else {
        navigatorKey.currentState?.pushNamed('/login');
        return {};
      }
    }
    // var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
    var responseBodyBytes = await response.stream.bytesToString();
    var responseBody = jsonDecode(responseBodyBytes);
    return responseBody;
  } catch (e) {
    debugPrint("fetchData() error: $e");
    return {
      "success": false,
      "responseMessage": sharedPref.translate("Connection failed!")
    };
  }
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
