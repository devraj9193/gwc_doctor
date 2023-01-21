import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/constants.dart';

class BottomTapBar extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChangedTab;
  const BottomTapBar({
    Key? key,
    required this.index,
    required this.onChangedTab,
  }) : super(key: key);

  @override
  _BottomTapBarState createState() => _BottomTapBarState();
}

class _BottomTapBarState extends State<BottomTapBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildTabView1(
            index: 0,
            image: 'assets/images/Icon material-dashboard.png',
          ),
          buildTabView(
            index: 1,
            image: 'assets/images/Group 4877.png',
          ),
          buildTabView(
            index: 2,
            image: 'assets/images/Group 4876.png',
          ),
          buildTabView2(
            index: 3,
          ),
          buildTabView1(
            index: 4,
            image: 'assets/images/Group 3041.png',
          ),

        ],
      ),
    );
  }

  Widget buildTabView({
    required int index,
    required String image,
  }) {
    final isSelected = index == widget.index;

    return Padding(
      padding: EdgeInsets.all(1.h),
      child: InkWell(
        child: Image(
            height: isSelected ? 3.5.h : 3.h,
            image: AssetImage(image),
            color: isSelected ? gPrimaryColor : gBlackColor,
            fit: BoxFit.contain),
        onTap: () => widget.onChangedTab(index),
      ),
    );
  }

  Widget buildTabView1({
    required int index,
    required String image,
  }) {
    final isSelected = index == widget.index;

    return Padding(
      padding: EdgeInsets.all(1.h),
      child: InkWell(
        child: Image(
            height:isSelected ? 2.5.h : 2.h,
            image: AssetImage(image),
            color: isSelected ? gPrimaryColor : gBlackColor,
            fit: BoxFit.contain),
        onTap: () => widget.onChangedTab(index),
      ),
    );
  }

  Widget buildTabView2({
    required int index,
  }) {
    final isSelected = index == widget.index;

    return Padding(
      padding: const EdgeInsets.all(15),
      child: InkWell(
        child: SizedBox(
          height: isSelected ? 3.7.h : 3.2.h,
          child: Icon(
            Icons.notifications_outlined,
            color: isSelected ? gPrimaryColor : gBlackColor,
          ),
        ),
        onTap: () => widget.onChangedTab(index),
      ),
    );
  }

// buildCustomBadge({required Widget child}) {
//   return Stack(
//     clipBehavior: Clip.none,
//     children: [
//       child,
//       const Positioned(
//         top: 0,
//         right: 5,
//         child: CircleAvatar(
//           radius: 5,
//           backgroundColor: Colors.red,
//         ),
//       ),
//     ],
//   );
// }
}
