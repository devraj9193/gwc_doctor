import 'package:country_code_picker/country_localizations.dart';
import 'package:doctor_app_new/splash_screen.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart' hide DeviceType;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig().preferences = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.black26),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const MyApp());
}

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
    // TODO: implement initState
    super.initState();
    getDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return const GetMaterialApp(
        supportedLocales: [
          Locale("en"),

          /// THIS IS FOR COUNTRY CODE PICKER
        ],
        localizationsDelegates: [
          CountryLocalizations.delegate,

          /// THIS IS FOR COUNTRY CODE PICKER
        ],
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    });
  }
}
