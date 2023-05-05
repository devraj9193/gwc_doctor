import 'dart:io';

import 'package:doctor_app_new/splash_screen.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'model/internet_connection/dependency_injecion.dart';
import 'package:upgrader/upgrader.dart';
import 'package:store_redirect/store_redirect.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  AppConfig().preferences = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.black26),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  DependencyInjection.init();
  await Upgrader.clearSavedSettings();
  runApp(
    const MyApp(),
  );

  // await FirebaseMessaging.instance.getToken();
  //
  // final fcmToken = await FirebaseMessaging.instance.getToken();
  //
  // print("fcmToken: $fcmToken");
  //
  // QuickBloxRepository().init(AppConfig.QB_APP_ID, AppConfig.QB_AUTH_KEY, AppConfig.QB_AUTH_SECRET, AppConfig.QB_ACCOUNT_KEY);
  //
  // QuickBloxRepository().initSubscription(fcmToken!);
}
//
// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
//   );
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => const MyApp(), // Wrap your app
//     ),
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getDeviceId() async {
    final _pref = AppConfig().preferences;
    await AppConfig().getDeviceId().then((id) {
      print("deviceId: $id");
      if (id != null) {
        _pref!.setString(AppConfig().deviceId, id);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    const appCastURL =
        'https://github.com/devraj9193/gwc_success/blob/master/test/AppCast.xml';
    final cfg = AppcastConfiguration(url: appCastURL, supportedOS: ['android']);

    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: UpgradeAlert(
          upgrader: Upgrader(
             appcastConfig: cfg,
            durationUntilAlertAgain: const Duration(days: 1 ),
            dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
            shouldPopScope: () => true,
            messages: UpgraderMessages(code: 'en'),
            onIgnore: () {
              SystemNavigator.pop();
              throw UnsupportedError('_');
            },
            onUpdate: () {
              launchURL();
              return true;
            },
            onLater: () {
              SystemNavigator.pop();
              throw UnsupportedError('_');
            },
          ),
          child:SplashScreen(),
        ),
      );
    });
  }

  launchURL() async {
    StoreRedirect.redirect(
      androidAppId: "com.fembuddy.doctor",
      // iOSAppId: "284882215",
    );
  }
}
