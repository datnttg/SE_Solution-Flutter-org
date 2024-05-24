import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:se_solution/utilities/shared_preferences.dart';

class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future initialNotifications() async {
    await firebaseMessaging.requestPermission(provisional: true);
    final fCMToken = await firebaseMessaging.getToken();
    String fCMId = await FirebaseInstallations.instance.getId();
    if (fCMToken != null) {
      sharedPrefs.setFirebaseInstallationId(fCMId);
      sharedPrefs.setFirebaseToken(fCMToken);
    }
  }
}
