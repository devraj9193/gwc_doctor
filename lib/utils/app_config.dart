import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AppConfig{
  static AppConfig? _instance;
  factory AppConfig() => _instance ??= AppConfig._();
  AppConfig._();

  final String baseUrl = "https://gwc.disol.in";

  final String bearerToken = "Bearer";

  static const String isLogin = "login";

  final String deviceId = "deviceId";
  final String registerOTP = "R_OTP";
 // String bearerToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiM2Q4ZTI5ZWUzODUyMGExNDI1ODJlMTg1ZjcwMDc3MDJjNjcwMTJjYWI4NDM5NDE5MmM0OGMwNWQ2MzY5YjgwZDJlN2JkYTUzOThmNjZlNzYiLCJpYXQiOjE2NjMzMDk2NDYuNDQxNDU5LCJuYmYiOjE2NjMzMDk2NDYuNDQxNDYyLCJleHAiOjE2OTQ4NDU2NDYuNDM4NjkxLCJzdWIiOiI1NCIsInNjb3BlcyI6W119.z902_OuP_C5c8kAUlMcVmoWaxV_efjpxQIC78Pfh2KciFOazqbX5O2xN8Bld_NurPn4u1_p_mzYcbGCFOrwnIYPtIWtOzeq7TqfZ1g64peCdGij6dntuWFR2aFEAuxUxQ4ZdOW1iNazSkmhKPQq7NBTTii3cbfJaZh8suMDApW8uC7imh2a55vFVAvykfwkC-Nnb4UlbhiunoVKXeyIkUPBlUzlt-CvrYBjOTgbd-UTVCEX2hbTCnSHatLuPFv1CpeZkCnb4SGJZgeqbE8AsBl9snTvMQ_lXSwhMla-AJjQS0oCWYJJrxe_n3tj8MvFLo9HGQORMmXYrUMFMjEX9kQCFb6I_gmwvU5yvCYNjgNuZCO99dLX-HBAFiXopScnYhpSlUu2EQbC5d5OT7nrYuGK0Vq8FTFNTQJ1rYS3jKOMERUilxnAqHoakHCOVGqdSCZ8zb5DWn_dYxpFD4bfSaU_GZbXXtuv9pRmoEP_XZygkJJNp_85N2f0g_nV3uEQ6-Xsx-7IFs0MA6KNFRyT0N6cH1y-JGRc_2PTkSpVTvVWh2oDkmCdf1hfheLAA1ZWMB3Y6ck-kDYa4MN7YyOJbEUFW7AIrSUWfLVmQNZhz88ZDw5N8RaOQ0FQP6tvBjaRT_Uj2kyyGzYHFdMUeYsnmzdRhDzji_KU87jF82XIMPCA";
  late String bearer = '';

  static String slotErrorText = "Slots Not Available Please select different day";
  static String networkErrorText = "Network Error! Please Retry..";

  static const String isSmallMode = "isShrunk";

  String emptyStringMsg = 'Please mention atLeast 2 characters';

  SharedPreferences? preferences;
  Future<String?> getDeviceId() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  showSnackBar(BuildContext context, String message,{int? duration, bool? isError}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:(isError == null || isError == false) ? gPrimaryColor : Colors.redAccent,
        content: Text(message),
        duration: Duration(seconds: duration ?? 2),
      ),
    );
  }
  fixedSnackBar(BuildContext context, String message,String btnName, onPress, {Duration? duration, bool? isError}){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor:(isError == null || isError == false) ? gPrimaryColor : Colors.redAccent,
        content: Text(message),
        actions: [
          TextButton(
              onPressed: onPress,
              child: Text(btnName)
          )
        ],
      ),
    );
  }
}