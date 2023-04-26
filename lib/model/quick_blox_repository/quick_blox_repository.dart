// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:quickblox_sdk/models/qb_settings.dart';
// import 'package:quickblox_sdk/push/constants.dart';
// import 'package:quickblox_sdk/quickblox_sdk.dart';
//
// import '../../controller/services/local_notification_service.dart';
//
// class QuickBloxRepository {
//   Future<void> init(String appId, String authKey, String authSecret, String accountKey,
//       {String? apiEndpoint, String? chatEndpoint}) async {
//     await QB.settings.init(appId, authKey, authSecret, accountKey,
//         apiEndpoint: apiEndpoint, chatEndpoint: chatEndpoint);
//   }
//
//   Future<QBSettings?> get() async {
//     return await QB.settings.get();
//   }
//
//   Future<void> enableCarbons() async {
//     await QB.settings.enableCarbons();
//   }
//
//   Future<void> disableCarbons() async {
//     await QB.settings.disableCarbons();
//   }
//
//   Future<void> initStreamManagement(bool autoReconnect, int messageTimeout) async {
//     await QB.settings.initStreamManagement(messageTimeout, autoReconnect: autoReconnect);
//   }
//
//   Future<void> enableXMPPLogging() async {
//     await QB.settings.enableXMPPLogging();
//   }
//
//   Future<void> enableLogging() async {
//     await QB.settings.enableLogging();
//   }
//
//   Future<void> enableAutoReconnect(bool enable) async {
//     await QB.settings.enableAutoReconnect(enable);
//   }
//
//   void initSubscription(String fcmToken) async {
//     print("QB initSubscription to fcm- ${fcmToken}");
//     if(fcmToken.isNotEmpty){
//       QB.subscriptions.create(fcmToken, QBPushChannelNames.GCM)
//           .then((value) => print("subscribe success"))
//           .onError((error, stackTrace) => print("subscribe error: ${error}"));
//       try {
//         FirebaseMessaging.onMessage.listen((message) {
//           print("message recieved: ${message.toMap()}");
//           LocalNotificationService().showQBNotification(message);
//           // LocalNotificationService.createanddisplaynotification(message);
//
//         });
//       } on PlatformException catch (e) {
//         //some error occurred
//         print("qb subscribe error: ${e.message}");
//       }
//     }
//     else{
//       if (kDebugMode) {
//         print("fcm Token is empty");
//       }}
//   }
//
// }
