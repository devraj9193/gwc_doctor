import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../model/chat_support/chat_support_method.dart';
import '../../model/error_model.dart';
import '../../model/kaleyra_chat_list_model.dart/kaleyra_chat_list_model.dart';
import '../../repository/api_service.dart';
import '../../repository/chat_list_repo/chat_list_repository.dart';
import '../../services/chat_list_service/chat_list_service.dart';
import '../../utils/app_config.dart';
import '../../utils/constants.dart';
import '../../utils/gwc_apis.dart';
import '../../widgets/common_screen_widgets.dart';
import '../../widgets/widgets.dart';

class KaleyraChatListScreen extends StatefulWidget {
  const KaleyraChatListScreen({Key? key}) : super(key: key);

  @override
  State<KaleyraChatListScreen> createState() => _KaleyraChatListScreenState();
}

class _KaleyraChatListScreenState extends State<KaleyraChatListScreen>
    with SingleTickerProviderStateMixin {
  final SharedPreferences _pref = AppConfig().preferences!;

  //search
  TextEditingController searchController = TextEditingController();
  List<ChatList> searchResults = [];

  TabController? tabController;
  bool isLoading = false;
  bool isError = false;
  String errorText = '';
  List<ChatList> chatList = [];

  @override
  void initState() {
    super.initState();
    getChatList();
    searchController.addListener(() {
      setState(() {});
    });
    tabController = TabController(
      initialIndex: 0,
      length: 1,
      vsync: this,
    );
  }

  @override
  void dispose() async {
    super.dispose();
    tabController?.dispose();
    searchController.dispose();
  }

  getChatList() async {
    setState(() {
      isLoading = true;
    });
    final res =
        await ChatListService(repository: repository).getChatListService();
    print("result: $res");

    if (res.runtimeType == ErrorModel) {
      final model = res as ErrorModel;
      print("model : $model");
      setState(() {
        isLoading = false;
        isError = true;
        errorText = model.message ?? '';
      });
    } else {
      final model = res;
      chatList = model.chatList;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: gWhiteColor,
          centerTitle: false,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  color: gSecondaryColor,
                  size: 2.h,
                ),
              ),
              SizedBox(width: 2.w),
              CircleAvatar(
                radius: 2.h,
                backgroundImage: NetworkImage(
                  "${_pref.getString(GwcApi.successMemberProfile)}",
                ),
              ),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${_pref.getString(GwcApi.successMemberName)}",
                      style: ProfileScreenText().nameText()),
                  SizedBox(height: 0.6.h),
                  Text("${_pref.getString("kaleyraUserId")}",
                      style: ProfileScreenText().otherText()),
                ],
              ),
            ],
          ),
          actions: [
            AnimSearchBar(
              width: 400,
              textController: searchController,
              color: gChatListBackgroundColor,
              boxShadow: false,
              onSuffixTap: () {
                setState(() {
                  searchController.clear();
                });
              },
              onSubmitted: (value) {
                onSearchTextChanged(value);
              },
            ),
            SizedBox(width: 2.w),
          ],
        ),
        backgroundColor: gChatListBackgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: gWhiteColor,
              width: double.maxFinite,
              child: TabBar(
                controller: tabController,
                labelColor: tapSelectedColor,
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                unselectedLabelColor: tapUnSelectedColor,
                labelStyle: TabBarText().selectedText(),
                unselectedLabelStyle: TabBarText().unSelectedText(),
                isScrollable: true,
                indicatorColor: tapIndicatorColor,
                labelPadding: EdgeInsets.only(
                    right: 7.w, left: 2.w, top: 1.h, bottom: 0.5.h),
                indicatorPadding: EdgeInsets.only(right: 5.w),
                tabs: const [
                  Text('Chats'),
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
            ),
            Expanded(
              child: (isLoading)
                  ? Center(
                      child: buildCircularIndicator(),
                    )
                  : TabBarView(
                      controller: tabController,
                      children: [
                        searchController.text.isEmpty
                            ? buildChatList()
                            : buildSearchList(),
                        // buildBridged(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  buildChatList() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: chatList.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final kaleyraUserId = _pref.getString("kaleyraUserId");
                      final res = await getKaleyraAccessToken(kaleyraUserId!);
                      if (res.runtimeType != ErrorModel) {
                        final accessToken =
                            _pref.getString(GwcApi.kaleyraAccessToken);
                        openKaleyraChat(kaleyraUserId, chatList[index].users[0],
                            accessToken!);
                      } else {
                        final result = res as ErrorModel;
                        print("get Access Token error: ${result.message}");
                        AppConfig().showSnackBar(context, result.message ?? '',
                            isError: true, bottomPadding: 70);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.h,
                          backgroundColor: kNumberCircleRed,
                          child: Text(
                            getInitials(chatList[index].users[0], 2),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: "GothamBold",
                              color: gWhiteColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getUserName(chatList[index].users[0]),
                                style: AllListText().headingText(),
                              ),
                              Text(
                                "${chatList[index].lastMessage?.body}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AllListText().subHeadingText(),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            chatList[index].lastMessage?.date == null
                                ? SizedBox.shrink()
                                : Text(
                                    buildTimeDate(
                                        "${chatList[index].lastMessage?.date}"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AllListText().subHeadingText(),
                                  ),
                            SizedBox(height: 0.5.h),
                            chatList[index].unreadMessagesCount == 0
                                ? SizedBox.shrink()
                                : buildUnreadCount(
                                    "${chatList[index].unreadMessagesCount}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchResults.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    chatList.forEach((userDetail) {
      String s = userDetail.users[0].replaceAll(RegExp("_")," ");
      print(userDetail.users[0].replaceAll(RegExp("_")," "));

      if (s.toLowerCase().contains(text.toLowerCase()) ||
          s.toLowerCase().contains(
              text.toLowerCase())) {
        searchResults.add(userDetail);
      }
    });
    setState(() {});
  }

  buildSearchList() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          ListView.builder(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: searchResults.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final kaleyraUserId = _pref.getString("kaleyraUserId");
                      final res = await getKaleyraAccessToken(kaleyraUserId!);
                      if (res.runtimeType != ErrorModel) {
                        final accessToken =
                            _pref.getString(GwcApi.kaleyraAccessToken);
                        openKaleyraChat(kaleyraUserId, chatList[index].users[0],
                            accessToken!);
                      } else {
                        final result = res as ErrorModel;
                        print("get Access Token error: ${result.message}");
                        AppConfig().showSnackBar(context, result.message ?? '',
                            isError: true, bottomPadding: 70);
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 3.h,
                          backgroundColor: kNumberCircleRed,
                          child: Text(
                            getInitials(chatList[index].users[0], 2),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: "GothamBold",
                              color: gWhiteColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getUserName(chatList[index].users[0]),
                                style: AllListText().headingText(),
                              ),
                              Text(
                                "${chatList[index].lastMessage?.body}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AllListText().subHeadingText(),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            chatList[index].lastMessage?.date == null
                                ? SizedBox.shrink()
                                : Text(
                                    buildTimeDate(
                                        "${chatList[index].lastMessage?.date}"),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AllListText().subHeadingText(),
                                  ),
                            SizedBox(height: 0.5.h),
                            chatList[index].unreadMessagesCount == 0
                                ? SizedBox.shrink()
                                : buildUnreadCount(
                                    "${chatList[index].unreadMessagesCount}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  static String getInitials(String string, int limitTo) {
    String s = string.replaceAll(RegExp("_")," ");
    print(string.replaceAll(RegExp("_")," "));

    String user = s.capitalize!;

    var buffer = StringBuffer();
    var wordList = user.trim().split(' ');

    if (string.isEmpty) {
      return string;
    }

    if (wordList.length <= 1) {
      return string.characters.first;
    }

    if (limitTo > wordList.length) {
      for (var i = 0; i < wordList.length; i++) {
        buffer.write(wordList[i][0]);
      }
      return buffer.toString();
    }

    // Handle all other cases
    for (var i = 0; i < (limitTo); i++) {
      buffer.write(wordList[i][0]);
    }
    return buffer.toString();
  }

  buildTimeDate(String date) {
    DateTime time = DateTime.parse(date);
    DateTime now = DateTime.now();
    if (time == now) {
      String amPm = 'AM';
      if (time.hour >= 12) {
        amPm = 'PM';
      }
      String chatTime = "${time.hour}:${time.minute} $amPm";
      return chatTime;
    } else if (time == DateTime(now.year, now.month, now.day - 1)) {
      return "Yesterday";
    } else {
      return DateFormat('dd MMMM').format(time);
    }
  }

  buildUnreadCount(String count) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration:
          const BoxDecoration(color: gSecondaryColor, shape: BoxShape.circle),
      child: Center(
        child: Text(
          count,
          style: TextStyle(
            fontSize: 7.sp,
            fontFamily: "GothamMedium",
            color: gWhiteColor,
          ),
        ),
      ),
    );
  }

  String getUserName(String user) {
    String s = user.replaceAll(RegExp("_")," ");
    print(user.replaceAll(RegExp("_")," "));

    return s.capitalize!;
  }

  ChatListRepository repository =
      ChatListRepository(apiClient: ApiClient(httpClient: http.Client()));

}
