import 'dart:async';
import 'package:doctor_app_new/screens/login_screens/doctor_login.dart';
import 'package:doctor_app_new/screens/dashboard_screens/dashboard_screen.dart';
import 'package:doctor_app_new/screens/notification_screens/notification_screen.dart';
import 'package:doctor_app_new/utils/app_config.dart';
import 'package:doctor_app_new/widgets/background_widget.dart';
import 'package:doctor_app_new/utils/constants.dart';
import 'package:doctor_app_new/widgets/will_pop_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/chat_support/chat_support_method.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  static final _notificationsPlugin = FlutterLocalNotificationsPlugin();
  String loginStatus = "";
  String deviceToken = "";

  final SharedPreferences _pref = AppConfig().preferences!;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      loginStatus = preferences.getString(AppConfig().bearerToken)!;
      print("Token: $loginStatus");
    });
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 1;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    super.initState();
    getPref();
    requestPermission();
    getToken();
    initInfo();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  initInfo() {
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      ),
    );
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("---Firebase Message---");
      print(
          "onMessage: ${message.notification?.title}/${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        "gwc",
        "gwc",
        importance: Importance.high,
        styleInformation: bigTextStyleInformation,
        priority: Priority.high,
        playSound: true,
      );
      NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: const DarwinNotificationDetails(),
      );
      await _notificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['title']);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(
              "message.notification!.title : ${message.data["title"].toString()}");
          print(message.notification!.body);
          print(message.toMap());
          print("message.data22 ${message.data['notification_type']}");
          if (message.data != null) {
            if (message.data['notification_type'] == 'new_chat') {

              final uId = _pref.getString("kaleyraUserId");

              final accessToken = _pref.getString(AppConfig.KALEYRA_ACCESS_TOKEN);

              // chat
              await openKaleyraChat(uId!, message.data["title"].toString(), accessToken!);
            }
          } else {
            await Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const NotificationScreen(),
              ),
            );
          }
        }
      },
    );

  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("User Granted Provisional Permission");
    } else {
      print("User declined or has not accepted Permission");
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        deviceToken = value!;
        print("Device Token is : $deviceToken");
      });

      // QuickBloxRepository().init(AppConfig.QB_APP_ID, AppConfig.QB_AUTH_KEY, AppConfig.QB_AUTH_SECRET, AppConfig.QB_ACCOUNT_KEY);
      // QuickBloxRepository().initSubscription(deviceToken);

      _pref.setString("device_token", deviceToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              reverse: false,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              controller: _pageController,
              children: <Widget>[
                splashImage(),
                (loginStatus.isNotEmpty)
                    ? const DashboardScreen()
                    : const DoctorLogin(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  splashImage1() {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: gSecondaryColor,
            child: const Image(
              image: AssetImage("assets/images/Group 2657.png"),
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Image(
              image: AssetImage("assets/images/Gut wellness logo green.png"),
            ),
          ),
        ],
      );
    });
  }

  splashImage() {
    return const BackgroundWidget(
      assetName: 'assets/images/Group 2657.png',
      child: Center(
        child: Image(
          image: AssetImage("assets/images/Gut wellness logo green.png"),
        ),
        // SvgPicture.asset(
        //     "assets/images/splash_screen/Splash screen Logo.svg"),
      ),
    );
  }
}
