class MealInputByDateFoodItemsVfsCalories {
  String? unit;
  double? value;

  MealInputByDateFoodItemsVfsCalories({
    this.unit,
    this.value,
  });

  MealInputByDateFoodItemsVfsCalories.fromJson(Map<String, dynamic> json) {
    unit = json['unit']?.toString();
    value = double.tryParse(json['value']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['unit'] = unit ?? '-';
    data['value'] = value ?? '-';
    return data;
  }
}

class MealInputByDateFoodItemsVfsNova {
  int? score;
  String? type;

  MealInputByDateFoodItemsVfsNova({
    this.score,
    this.type,
  });

  MealInputByDateFoodItemsVfsNova.fromJson(Map<String, dynamic> json) {
    score = int.tryParse(json['score']?.toString() ?? '');
    type = json['type']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['score'] = score ?? '-';
    data['type'] = type ?? '-';
    return data;
  }
}

class MealInputByDateFoodItemsVfs {
  MealInputByDateFoodItemsVfsNova? nova;
  int? gi;
  MealInputByDateFoodItemsVfsCalories? calories;
  double? spoonsOfSugar;

  MealInputByDateFoodItemsVfs({
    this.nova,
    this.gi,
    this.calories,
    this.spoonsOfSugar,
  });

  MealInputByDateFoodItemsVfs.fromJson(Map<String, dynamic> json) {
    nova = (json['nova'] != null && (json['nova'] is Map))
        ? MealInputByDateFoodItemsVfsNova.fromJson(json['nova'])
        : null;
    gi = int.tryParse(json['gi']?.toString() ?? '');
    calories = (json['calories'] != null && (json['calories'] is Map))
        ? MealInputByDateFoodItemsVfsCalories.fromJson(json['calories'])
        : null;
    spoonsOfSugar = double.tryParse(json['spoonsOfSugar']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (nova != null) {
      data['nova'] = nova!.toJson();
    }
    data['gi'] = gi ?? '-';
    if (calories != null) {
      data['calories'] = calories!.toJson();
    }
    data['spoonsOfSugar'] = spoonsOfSugar ?? '-';
    return data;
  }
}

class MealInputByDateFoodItemsFood {
  String? foodName;
  num? quantity;
  String? unit;

  MealInputByDateFoodItemsFood({
    this.foodName,
    this.quantity,
    this.unit,
  });

  MealInputByDateFoodItemsFood.fromJson(Map<String, dynamic> json) {
    foodName = json['foodName']?.toString();
    quantity = num.tryParse(json['quantity']?.toString() ?? '') ?? 0;
    unit = json['unit']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foodName'] = foodName ?? '-';
    data['quantity'] = quantity ?? '-';
    data['unit'] = unit ?? '-';
    return data;
  }
}

class MealInputByDateFoodItems {
  String? cmiDetailsId;
  String? mealType;
  MealInputByDateFoodItemsFood? food;
  MealInputByDateFoodItemsVfs? vfs;
  String? mealTime;
  String? localTime;
  String? createdAt;

  MealInputByDateFoodItems({
    this.cmiDetailsId,
    this.mealType,
    this.food,
    this.vfs,
    this.mealTime,
    this.localTime,
    this.createdAt,
  });

  MealInputByDateFoodItems.fromJson(Map<String, dynamic> json) {
    cmiDetailsId = json['cmiDetailsId']?.toString();
    mealType = json['mealType']?.toString();
    food = (json['food'] != null && (json['food'] is Map))
        ? MealInputByDateFoodItemsFood.fromJson(json['food'])
        : null;
    vfs = (json['vfs'] != null && (json['vfs'] is Map))
        ? MealInputByDateFoodItemsVfs.fromJson(json['vfs'])
        : null;
    mealTime = json['mealTime']?.toString();
    localTime = json['localTime']?.toString();
    createdAt = json['createdAt']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cmiDetailsId'] = cmiDetailsId ?? '-';
    data['mealType'] = mealType ?? '-';
    if (food != null) {
      data['food'] = food!.toJson();
    }
    if (vfs != null) {
      data['vfs'] = vfs!.toJson();
    }
    data['mealTime'] = mealTime ?? '-';
    data['localTime'] = localTime ?? '-';
    data['createdAt'] = createdAt ?? '-';
    return data;
  }
}

class MealInputByDate {
  String? customerMealInputId;
  String? mealInput;
  String? timeZone;
  List<MealInputByDateFoodItems?>? foodItems;

  MealInputByDate({
    this.customerMealInputId,
    this.mealInput,
    this.timeZone,
    this.foodItems,
  });

  MealInputByDate.fromJson(Map<String, dynamic> json) {
    customerMealInputId = json['customerMealInputId']?.toString();
    mealInput = json['mealInput']?.toString();
    timeZone = json['timeZone']?.toString();
    if (json['foodItems'] != null && (json['foodItems'] is List)) {
      final v = json['foodItems'];
      final arr0 = <MealInputByDateFoodItems>[];
      v.forEach((v) {
        arr0.add(MealInputByDateFoodItems.fromJson(v));
      });
      foodItems = arr0;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customerMealInputId'] = customerMealInputId ?? '-';
    data['mealInput'] = mealInput ?? '-';
    data['timeZone'] = timeZone ?? '-';
    if (foodItems != null) {
      final v = foodItems;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['foodItems'] = arr0;
    }
    return data;
  }
}
