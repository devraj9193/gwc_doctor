import 'package:country_code_picker/country_localizations.dart';
import 'package:doctor_app_new/splash_screen.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart' hide DeviceType;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'controller/services/quick_blox_service.dart';
import 'model/quick_blox_repository/quick_blox_repository.dart';

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
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MultiProvider(
        providers: [
          ListenableProvider<QuickBloxService>.value(value: QuickBloxService()),
        ],
        child: const GetMaterialApp(
          supportedLocales: [
            Locale("en"),
          ],
          localizationsDelegates: [
            CountryLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      );
    });
  }
}
