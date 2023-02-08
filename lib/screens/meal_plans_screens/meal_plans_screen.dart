import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants.dart';
import '../../widgets/widgets.dart';
import '../../doctor_status_screen.dart';
import '../customer_screens/customers_lists/meal_plan_list.dart';

class MealPlansScreen extends StatefulWidget {
  const MealPlansScreen({Key? key}) : super(key: key);

  @override
  State<MealPlansScreen> createState() => _MealPlansScreenState();
}

class _MealPlansScreenState extends State<MealPlansScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: gWhiteColor,
        appBar: buildAppBar(() {
          Navigator.pop(context);
        }),
          body: Padding(
            padding: EdgeInsets.only(
              left: 4.w,
              right: 4.w,
              top: 1.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomerStatusScreen(),
                SizedBox(height: 2.h),
                TabBar(
                    labelColor: gPrimaryColor,
                    unselectedLabelColor: gTextColor,
                    isScrollable: true,
                    indicatorColor: gPrimaryColor,
                    labelPadding:
                        EdgeInsets.only(right: 10.w, top: 1.h, bottom: 1.h),
                    indicatorPadding: EdgeInsets.only(right: 7.w),
                    labelStyle: TextStyle(
                        fontFamily: "GothamMedium",
                        color: gPrimaryColor,
                        fontSize: 11.sp),
                    tabs: const [
                      Text('Meal Plans'),
                    ]),
                const Expanded(
                  child: TabBarView(children: [
                    CustomersMealPlanList(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
