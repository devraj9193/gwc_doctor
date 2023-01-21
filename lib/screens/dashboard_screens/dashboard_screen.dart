import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../widgets/will_pop_widget.dart';
import '../calender_screens/calender_screen.dart';
import '../chart_screen/dashboard_chart_screen.dart';
import '../direct_bridged_screens/direct_bridged_screen.dart';
import '../gwc_teams_screens/gwc_teams_screen.dart';
import '../home_screens/common_widget.dart';
import '../home_screens/home_level_screen.dart';
import '../home_screens/level_status.dart';
import '../notification_screens/notification_screen.dart';
import '../profile_screens/profile_screen.dart';
import 'bottom_tap_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _bottomNavIndex = 0;

  // void _onItemTapped(int index) {
  //   if (index != 3) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const ProfileScreen()),
  //     );
  //   }
  //   if (index != 2) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const QuriesScreen()),
  //     );
  //   }
  //   if (index != 1) {
  //     setState(() {
  //       _bottomNavIndex = index;
  //     });
  //   } else {
  //     Navigator.of(context).push(
  //       MaterialPageRoute(builder: (context) => const CustomerStatusScreen()),
  //     );
  //   }
  // }

  pageCaller(int index) {
    switch (index) {
      case 0:
        {
        // return const GanttChartScreen();
          return const CalenderScreen();
        }
      case 1:
        {
          return const GwcTeamsScreen();
        }
      case 2:
        {
          return const DirectBridgedScreen();
        }
      case 3:
        {
          return const NotificationScreen();
        }
      case 4:
        {
          return const ProfileScreen();
              //MyHomePage(title: '',);
              //  LevelStatus();

        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: SafeArea(
        child: Scaffold(
          body: pageCaller(_bottomNavIndex),
          bottomNavigationBar: BottomTapBar(
            index: _bottomNavIndex,
            onChangedTab: onChangedTab,
          ),
        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }
}
