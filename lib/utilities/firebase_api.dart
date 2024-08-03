import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'constants/core_constants.dart';
import 'shared_preferences.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future initialFCM() async {
    await firebaseMessaging.requestPermission(provisional: true);
    String fCMId = await FirebaseInstallations.instance.getId();
    String? fCMToken;

    /// For Apple platform
    String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    if (apnsToken != null) {
      // APNS token is available, make FCM plugin API requests...
      // Ensure the APNS token is available before making any FCM plugin API calls
    }

    if (kIsWeb) {
      /// TODO: Waiting for fcmApiKey
      String? webPushCertificate = Constants().fcmApiKey;
      fCMToken = await firebaseMessaging.getToken(vapidKey: webPushCertificate);
      firebaseMessaging.onTokenRefresh.listen((fcmToken) {
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new
        // token is generated.
      }).onError((err) {
        // Error getting token.
      });
    } else {
      fCMToken = await firebaseMessaging.getToken();
    }

    if (fCMId != '') {
      sharedPrefs.setFirebaseInstallationId(fCMId);
    }
    if (fCMToken != null && fCMToken != '') {
      sharedPrefs.setFirebaseToken(fCMToken);
    }
  }
}
