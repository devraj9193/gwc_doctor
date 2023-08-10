import 'app_config.dart';

final _prefs = AppConfig().preferences;

class DoctorDetailsStorage{
  static String doctorDetailsName = "doctorDetailsName";
  static String doctorDetailsEmail = "doctorDetailsEmail";
  static String doctorDetailsUvId = "doctorDetailsUvId";
  static String doctorDetailsUvToken = "doctorDetailsUvToken";

  static String uvDeskAccessToken = "${_prefs!.getString(DoctorDetailsStorage.doctorDetailsUvToken)}";
}