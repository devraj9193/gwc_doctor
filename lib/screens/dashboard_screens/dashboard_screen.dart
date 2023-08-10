import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../widgets/exit_widget.dart';
import '../customer_help_screens/ticket_list.dart';
import '../kaleyra_chat_list_screen/kaleyra_chat_list_screen.dart';
import '../chart_screen/dashboard_chart_screen.dart';
import '../direct_bridged_screens/all_customers_list_screen.dart';
import '../direct_bridged_screens/direct_bridged_screen.dart';
import '../gwc_teams_screens/gwc_teams_screen.dart';
import '../profile_screens/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ConvexAppBarState> _appBarKey =
  GlobalKey<ConvexAppBarState>();

  int _bottomNavIndex = 0;

  bool showProgress = false;
  bool showFab = true;
  final int savePrevIndex = 0;

    pageCaller(int index) {
    switch (index) {
      case 0:
        {
          return const GanttChartScreen();
          //  return const CalenderScreen();
        }
      case 1:
        {
          return const TicketListScreen();
          // GwcTeamsScreen();
        }
      case 2:
        {
          return const DirectBridgedScreen();
        }
      case 3:
        {
          return const AllCustomersList();
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pageCaller(_bottomNavIndex),
        floatingActionButton: showFab
            ? FloatingActionButton(
          onPressed: (showProgress)
              ? null
              : () async {
            setState(() {
              showProgress = true;
            });
            await Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                  const KaleyraChatListScreen(),
                ),
              );
              setState(() {
                showProgress = false;
              });
            });
          },
          backgroundColor: gSecondaryColor.withOpacity(0.7),
          child: showProgress
              ? const Center(
            child: SizedBox(
              height: 15,
              width: 15,
              child:  CircularProgressIndicator(
                color: gWhiteColor,
              ),
            ),
          )
              : const ImageIcon(
              AssetImage("assets/images/noun-chat-5153452.png")),
        )
            : null,
        bottomNavigationBar: ConvexAppBar(
          key: _appBarKey,
          style: TabStyle.react,
          backgroundColor: Colors.white,
          height: 6.h,
          items: [
            TabItem(
              icon: _bottomNavIndex == 0
                  ? Image.asset(
                "assets/images/Icon material-dashboard.png",
                color: gSecondaryColor,
              )
                  : Image.asset(
                "assets/images/Icon material-dashboard.png",
                color: gBlackColor,
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 1
                  ? Image.asset(
                "assets/images/Group 4877.png",
                color: gSecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 4877.png",
                color: gBlackColor,
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 2
                  ? Image.asset(
                "assets/images/Group 4876.png",
                color: gSecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 4876.png",
                color: gBlackColor,
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 3
                  ? Image.asset(
                "assets/images/Icon material-message.png",
                color: gSecondaryColor,
              )
                  : Image.asset(
                "assets/images/Icon material-message.png",
                color: gBlackColor,
              ),
            ),
            TabItem(
              icon: _bottomNavIndex == 4
                  ? Image.asset(
                "assets/images/Group 3041.png",
                color: gSecondaryColor,
              )
                  : Image.asset(
                "assets/images/Group 3041.png",
                color: gBlackColor,
              ),
            ),
          ],
          initialActiveIndex: _bottomNavIndex,
          onTap: onChangedTab,
        ),
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      _bottomNavIndex = index;
      if (_bottomNavIndex == 4) {
        showFab = false;
      } else {
        showFab = true;
      }
    });
  }

  Future<bool> _onWillPop() {
    print('back pressed');
    print("_bottomNavIndex: $_bottomNavIndex");
    setState(() {
      if (_bottomNavIndex != 0) {
        if (_bottomNavIndex > savePrevIndex ||
            _bottomNavIndex < savePrevIndex) {
          _bottomNavIndex = savePrevIndex;
          _appBarKey.currentState!.animateTo(_bottomNavIndex);
          setState(() {});
        } else {
          _bottomNavIndex = 0;
          _appBarKey.currentState!.animateTo(_bottomNavIndex);
          setState(() {});
        }
      } else {
        AppConfig().showSheet(
          context,
          const ExitWidget(),
          bottomSheetHeight: 45.h,
          isDismissible: true,
        );
      }
    });
    return Future.value(false);
  }
}

