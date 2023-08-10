import 'new_detox_model.dart';
import 'new_healing_model.dart';
import 'new_nourish_model.dart';
import 'new_prep_model.dart';

class CombinedMealModel {
  int? status;
  int? errorCode;
  NewPrepModel? prep;
  NewDetoxModel? detox;
  NewHealingModel? healing;
  NewNourishModel? nourish;
  String? trackerVideoUrl;


  CombinedMealModel({this.status, this.errorCode,
    this.prep, this.detox, this.healing, this.nourish, this.trackerVideoUrl});

  CombinedMealModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    prep = json['Prep'] != null ? NewPrepModel.fromJson(json['Prep']) : null;
    detox = json['Detox'] != null ? NewDetoxModel.fromJson(json['Detox']) : null;
    healing = json['Healing'] != null ? NewHealingModel.fromJson(json['Healing']) : null;
    nourish = json['Nourish'] != null ? NewNourishModel.fromJson(json['Nourish']) : null;
    trackerVideoUrl = json['tracker_video'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorCode'] = errorCode;
    data['tracker_video'] = trackerVideoUrl;

    if (prep != null) {
      data['Prep'] = prep!.toJson();
    }
    if (detox != null) {
      data['Detox'] = detox!.toJson();
    }
    if (healing != null) {
      data['Healing'] = healing!.toJson();
    }
    if (nourish != null) {
      data['Nourish'] = nourish!.toJson();
    }
    return data;
  }
}