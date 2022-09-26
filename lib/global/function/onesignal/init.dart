import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:gym_user_ios/ui/intro/controller/splash_controller.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../global_function.dart';

oneSignalSetting() async {
  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("eaed1350-981e-4211-9478-a46a6f45552e");

  SplashController sc = Get.find();

  OneSignal.shared.sendTag("uid", sc.userUid.value);
  OneSignal.shared.setExternalUserId(sc.userUid.value);

  if (M.getString("firstrunSetting") != "done") {
    OneSignal.shared.sendTag("unoti01", "true");
    OneSignal.shared.sendTag("unoti02", "true");
    OneSignal.shared.sendTag("unoti03", "true");
    OneSignal.shared.sendTag("unoti04", "true");
    OneSignal.shared.sendTag("unoti05", "true");
    OneSignal.shared.sendTag("unoti06", "true");
    OneSignal.shared.sendTag("unoti07", "true");
    OneSignal.shared.sendTag("unoti08", "true");
    OneSignal.shared.sendTag("unoti09", "true");

    M.setString("unoti01", "true");
    M.setString("unoti02", "true");
    M.setString("unoti03", "true");
    M.setString("unoti04", "true");
    M.setString("unoti05", "true");
    M.setString("unoti06", "true");
    M.setString("unoti07", "true");
    M.setString("unoti08", "true");
    M.setString("unoti09", "true");

    M.setString("firestrunSetting", "done");
  }

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  // OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //     (OSNotificationReceivedEvent event) async {
  //   print("notiIdAll :: " + event.notification.notificationId.toString());

  //   if (Platform.isAndroid) {
  //     print("notiIdAndroid :: " +
  //         event.notification.androidNotificationId.toString());

  //     var additionalData = event.notification.additionalData;
  //     String collapse_id = event.notification.collapseId;

  //     print("HHAHAHAHAHAH " + event.notification.collapseId);
  //   } else {
  //     var dataToJson = jsonDecode(event.notification.jsonRepresentation());
  //     String collapse_id = dataToJson['custom']['collapse_id']; // ios
  //   }

  //   event.complete(event.notification);
  // });

  // OneSignal.shared
  //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  //   // Will be called whenever a notification is opened/button pressed.
  // });

  // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
  //   // Will be called whenever the permission changes
  //   // (ie. user taps Allow on the permission prompt in iOS)
  // });

  // OneSignal.shared
  //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
  //   // Will be called whenever the subscription changes
  //   // (ie. user gets registered with OneSignal and gets a user ID)
  // });

  // OneSignal.shared.setEmailSubscriptionObserver(
  //     (OSEmailSubscriptionStateChanges emailChanges) {
  //   // Will be called whenever then user's email subscription changes
  //   // (ie. OneSignal.setEmail(email) is called and the user gets registered
  // });
}
