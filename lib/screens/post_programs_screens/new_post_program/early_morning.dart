import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../widgets/widgets.dart';

class ShowStageUI extends StatefulWidget {
  final Widget topWidget;
  final Widget bottomWidget;
  final VoidCallback? onBackIconTap;
  const ShowStageUI(
      {Key? key,
      required this.topWidget,
      required this.bottomWidget,
      this.onBackIconTap})
      : super(key: key);

  @override
  State<ShowStageUI> createState() => _ShowStageUIState();
}

class _ShowStageUIState extends State<ShowStageUI> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: gWhiteColor,
      appBar: buildAppBar(() {
        Navigator.pop(context);
      }),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              child: widget.topWidget,
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                    // color: Colors.black12.withOpacity(0.1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: widget.bottomWidget,
              ))
        ],
      ),
    ));
  }

  Future<bool> _onWillPop() {
    // setState(() {
    //   if (currentStage != 0) {
    //     currentStage--;
    //   }
    //   else{
    //     Future.value(true);
    //   }
    // });
    return Future.value(false);
  }
}
