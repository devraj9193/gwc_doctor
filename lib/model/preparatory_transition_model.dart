class PreparatoryTransitionModel {
  int? status;
  int? errorCode;
  String? key;
  String? days;
  String? currentDay;
  String? isPrepCompleted;
  String? note;
  // early morning <=> Object
  Map<String, SubItems>? data;

  PreparatoryTransitionModel(
      {this.status,
      this.note,
      this.currentDay,
      this.errorCode,
      this.key,
      this.data,
      this.isPrepCompleted,
      this.days});

  PreparatoryTransitionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    key = json['key'].toString();
    currentDay = json['current_day'].toString();
    isPrepCompleted = json['is_prep_completed'].toString();
    note = json['note'].toString();
    days = json['days'].toString();

    if (json['data'] != null) {
      data = {};
      (json['data'] as Map).forEach((key, value) {
        // print("$key <==> ${(value as List).map((element) =>MealSlot.fromJson(element)) as List<MealSlot>}");
        // data!.putIfAbsent(key, () => List.from((value as List).map((element) => MealSlot.fromJson(element))));
        data!.addAll({key: SubItems.fromJson(value)});
      });

      data!.forEach((key, value) {
        print("$key -- $value");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['errorCode'] = errorCode;
    data['key'] = key;
    data['current_day'] = currentDay;
    data['is_prep_completed'] = isPrepCompleted;
    data['days'] = days;
    data['note'] = note;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    return data;
  }
}

class SubItems {
  // [object]
  Map<String, List<Preparatory>>? subItems;

  SubItems({this.subItems});

  SubItems.fromJson(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      subItems = {};
      json.forEach((key, value) {
        subItems!.putIfAbsent(
            key,
            () => List.from(value)
                .map((element) => Preparatory.fromJson(element))
                .toList());
      });
    }
  }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['variation_title'] = this.variationTitle;
//   data['variation_description'] = this.variationDescription;
//   return data;
// }
}

class Preparatory {
  int? id;
  int? itemId;
  String? name;
  String? benefits;
  String? subtitle;
  String? itemPhoto;
  String? recipeUrl;
  String? howToStore;
  String? howToPrepare;
  List<Ingredient>? ingredient;
  List<Variation>? variation;
  List<Faq>? faq;
  String? cookingTime;

  Preparatory(
      {this.id,
      this.itemId,
      this.name,
      this.benefits,
      this.subtitle,
      this.itemPhoto,
      this.recipeUrl,
      this.howToStore,
      this.howToPrepare,
      this.ingredient,
      this.variation,
      this.faq,
      this.cookingTime});

  Preparatory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    name = json['name'].toString();
    benefits = json['benefits'].toString();
    subtitle = json['subtitle'];
    itemPhoto = json['item_photo'].toString();
    recipeUrl = json['recipe_url'].toString();
    howToStore = json['how_to_store'].toString();
    howToPrepare = json['how_to_prepare'].toString();
    if (json['ingredient'] != null) {
      ingredient = <Ingredient>[];
      json['ingredient'].forEach((v) {
        ingredient!.add(Ingredient.fromJson(v));
      });
    }
    if (json['variation'] != null) {
      variation = <Variation>[];
      json['variation'].forEach((v) {
        variation!.add(Variation.fromJson(v));
      });
    }
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
    cookingTime = json['cooking_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['name'] = name;
    data['benefits'] = benefits;
    data['subtitle'] = subtitle;
    data['item_photo'] = itemPhoto;
    data['recipe_url'] = recipeUrl;
    data['how_to_store'] = howToStore;
    data['how_to_prepare'] = howToPrepare;
    if (ingredient != null) {
      data['ingredient'] = ingredient!.map((v) => v.toJson()).toList();
    }
    if (variation != null) {
      data['variation'] = variation!.map((v) => v.toJson()).toList();
    }
    if (faq != null) {
      data['faq'] = faq!.map((v) => v.toJson()).toList();
    }
    data['cooking_time'] = cookingTime;
    return data;
  }
}

class Ingredient {
  String? ingredientName;
  String? ingredientThumbnail;
  String? unit;
  String? qty;
  String? ingredientId;
  String? weightTypeId;

  Ingredient(
      {this.ingredientName,
      this.ingredientThumbnail,
      this.unit,
      this.qty,
      this.ingredientId,
      this.weightTypeId});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingredientName = json['ingredient_name'].toString();
    ingredientThumbnail = json['ingredient_thumbnail'].toString();
    unit = json['unit'].toString();
    qty = json['qty'].toString();
    ingredientId = json['ingredient_id'].toString();
    weightTypeId = json['weight_type_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredient_name'] = ingredientName;
    data['ingredient_thumbnail'] = ingredientThumbnail;
    data['unit'] = unit;
    data['qty'] = qty;
    data['ingredient_id'] = ingredientId;
    data['weight_type_id'] = weightTypeId;
    return data;
  }
}

class Variation {
  String? variationTitle;
  String? variationDescription;

  Variation({this.variationTitle, this.variationDescription});

  Variation.fromJson(Map<String, dynamic> json) {
    variationTitle = json['variation_title'].toString();
    variationDescription = json['variation_description'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variation_title'] = variationTitle;
    data['variation_description'] = variationDescription;
    return data;
  }
}

class Faq {
  String? faqQuestion;
  String? faqAnswer;

  Faq({this.faqQuestion, this.faqAnswer});

  Faq.fromJson(Map<String, dynamic> json) {
    faqQuestion = json['faq_question'].toString();
    faqAnswer = json['faq_answer'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['faq_question'] = faqQuestion;
    data['faq_answer'] = faqAnswer;
    return data;
  }
}
