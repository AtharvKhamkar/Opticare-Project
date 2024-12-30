import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:vizzhy/src/core/injection/injection.dart';
import 'package:vizzhy/src/data/remote/api_client.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/macro_neutrient_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/meal_by_date_response.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/meal_input_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_category_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/post_meal_by_date_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/post_meal_response_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/services/error_handler.dart';

///This repository class contains all the network request related to the Meals functionality
class MealsRepository {
  ///Instance of a Api Client class
  final apiClient = getIt<ApiClient>();

  ///This function make request for 'customer/meal/input' endpoint
  Future<List<MealInput>?> getMealsInput() async {
    try {
      final response = await apiClient.getRequest('customer/meal/input',
          serverType: ServerTypes.meals);
// return response;
      response.fold((l) {
        ErrorHandle.error(l.message);

        return null;
      }, (r) {
        // if (r.data['mealInputs']) return null;
        List<MealInput> mealInputsList = (r.data['mealInputs'] as List?)
                ?.map((mealInput) => MealInput.fromJson(mealInput))
                .toList() ??
            [];

        mealInputsList = mealInputsList.reversed.toList();
        return mealInputsList;
      });
    } catch (e) {
      return Future.error(e);
    }
    return null;
  }

  Future<bool> postMealInputs(String mealInput) async {
    try {
      String timeZoneName = await FlutterTimezone.getLocalTimezone();
      Map<String, dynamic> body = {
        'checksum': '123',
        'data': {
          'mealInput': mealInput.trim(),
          'timeZone': timeZoneName,
          'addedBy': 'CUSTOMER'
        }
      };

      debugPrint('Making post request to post meal');

      final response = await apiClient.postRequest('customer/meal/input',
          serverType: ServerTypes.meals, request: body);

      bool isMealAdded = false;

      response.fold((l) {
        debugPrint(
            'Error in left of postMealInputs in MealsRepo : ${l.message}');
      }, (r) {
        // debugPrint('meal posted success :$value');
        final data = PostMealData.fromJson(r.data);
        if (data.isAdded) {
          isMealAdded = true;
        }
      });
      return isMealAdded;
    } catch (e) {
      // return Future.error(e);
      debugPrint('Error caught in postMealInputs : $e');
      ErrorHandle.error('$e');
      return false;
    }
  }

  Future<bool> postMealInputsByDate({
    required String mealInput,
    required String mealType,
    required String mealTime,
    required String foodUnit,
    required num foodQuantity,
  }) async {
    try {
      String timeZoneName = await FlutterTimezone.getLocalTimezone();
      Map<String, dynamic> body = {
        'checksum': '123',
        'data': {
          'mealType': mealType,
          'mealTime': mealTime,
          'timeZone': timeZoneName,
          'foodItems': [
            {
              'foodName': mealInput.trim(),
              'foodUnit': foodUnit,
              'foodQuantity': foodQuantity
            }
          ]
        }
      };

      debugPrint('Making post request to post meal');

      final response = await apiClient.postRequest('/meal/inputs',
          serverType: ServerTypes.customer, request: body);

      bool isMealAdded = false;

      response.fold((l) {
        debugPrint(
            'Error in left of postMealInputs in MealsRepo : ${l.message}');
      }, (r) {
        // debugPrint('meal posted success :$value');
        final data = PostMealByDateModel.fromJson(r.data);
        if (data.isAdded ?? false) {
          isMealAdded = true;
        }
      });
      return isMealAdded;
    } catch (e) {
      // return Future.error(e);
      debugPrint('Error caught in postMealInputs : $e');
      ErrorHandle.error('$e');
      return false;
    }
  }

  Future<bool> updateMealInputs({
    required String cmiDetailsId,
    required String mealInput,
    required String mealType,
    required String mealTime,
    required String foodUnit,
    required num foodQuantity,
  }) async {
    try {
      String timeZoneName = await FlutterTimezone.getLocalTimezone();
      Map<String, dynamic> body = {
        'checksum': '123',
        'data': {
          'mealType': mealType,
          'mealTime': mealTime,
          'timeZone': timeZoneName,
          'foodItems': [
            {
              'foodName': mealInput.trim(),
              'foodUnit': foodUnit,
              'foodQuantity': foodQuantity
            }
          ]
        }
      };

      debugPrint('Making patch  request to update meal');

      final response = await apiClient.patchRequest('/meal/input/$cmiDetailsId',
          serverType: ServerTypes.customer, request: body);

      bool isMealUpdated = false;

      response.fold((l) {
        debugPrint(
            'Error in left of updateMealsInput in MealsRepo : ${l.message}');
      }, (r) {
        // debugPrint('meal posted success :$value');
        final result = r.data;
        isMealUpdated = result['isUpdateded'];
      });
      return isMealUpdated;
    } catch (e) {
      // return Future.error(e);
      debugPrint('Error caught in postMealInputs : $e');
      ErrorHandle.error('$e');
      return false;
    }
  }

  Future<List<MealInputByDate>?> getMealsInputByDates(String date) async {
    try {
      final response = await apiClient.getRequest('/meal/inputs/$date',
          serverType: ServerTypes.customer);
      // return response;
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final mealInputsList = r.data['mealInputs'] as List;
        debugPrint('${mealInputsList.length}');

        // Map each item in mealInputsList to a MealInputByDate object and assign to mealInputsByDates
        return mealInputsList
            .map((json) =>
                MealInputByDate.fromJson(json as Map<String, dynamic>))
            .toList();
      });
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> deleteMealInput(String cmiDetailsId) async {
    try {
      final response = await apiClient.deleteRequest(
          '/meal/input/$cmiDetailsId',
          serverType: ServerTypes.customer);

      bool isMealDeleted = false;
      response.fold((l) {
        debugPrint(
            'Error while deleteing meals in deleteMealInput function ${l.code} :: ${l.message}');
        ErrorHandle.error(l.message);
        return false;
      }, (r) {
        final mealDeletionStatus = r.success;
        if (mealDeletionStatus == true) {
          isMealDeleted = true;
        }
      });
      return isMealDeleted;
    } catch (e) {
      debugPrint('Error caught in deleteMealInput : $e');
      ErrorHandle.error('Something went wrong while deleting meal');
      return false;
    }
  }

  Future<List<MacronutrientModel>?> getMacroNutrients(String date) async {
    try {
      final response = await apiClient.getRequest('/meal/macronutrients/$date',
          serverType: ServerTypes.customer);
      // return response;
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final macroNeutrientsList = r.data['macronutrients'] as List;
        debugPrint('${macroNeutrientsList.length}');

        // Map each item in mealInputsList to a MealInputByDate object and assign to mealInputsByDates
        return macroNeutrientsList
            .map((json) =>
                MacronutrientModel.fromJson(json as Map<String, dynamic>))
            .toList();
      });
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  ///Function to get micronutrients of a customer by date
  Future<List<MicronutrientsModel>?> getMicroNutrients(String date) async {
    try {
      final response = await apiClient.getRequest('/meal/micronutrients/$date',
          serverType: ServerTypes.customer);
      //return response
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final microNeutrientsMap = r.data['micronutrients']
            ['minerals_and_trace_elements'] as Map<String, dynamic>?;

        if (microNeutrientsMap == null) return <MicronutrientsModel>[];

        return microNeutrientsMap.entries.map<MicronutrientsModel>((entry) {
          final key = entry.key;
          final value = entry.value as Map<String, dynamic>;
          return MicronutrientsModel.fromJson({
            'micronutrients': key,
            ...value,
          });
        }).toList();
      });

      return result;
    } catch (e) {
      debugPrint('Error caught in getMicroNutrients :: $e');
      return Future.error(e);
    }
  }

  // Future<List<MicronutrientsCategoryModel>?> getMicronutrientsByDay(
  //     String date) async {
  //   try {
  //     final response = await apiClient.getRequest('/meal/micronutrients/$date',
  //         serverType: ServerTypes.customer);

  //     final result = response.fold((l) {
  //       ErrorHandle.error(l.message);
  //       return null;
  //     }, (r) {
  //       final micronutrientsResponse =
  //           r.data['micronutrients'] as Map<String, dynamic>?;
  //       if (micronutrientsResponse == null)
  //         return <MicronutrientsCategoryModel>[];

  //       return micronutrientsResponse.entries
  //           .map<MicronutrientsCategoryModel>((entry) {
  //         final categoryName = entry.key;
  //         final categoryMicronutrients = entry.value as Map<String, dynamic>;

  //         return MicronutrientsCategoryModel.fromJson(
  //             categoryName, categoryMicronutrients);
  //       }).toList();
  //     });

  //     return result;
  //   } catch (e) {
  //     debugPrint('Error caught in getMicronutrientsByDay :: $e');
  //     return Future.error(e);
  //   }
  // }

  // Future<List<MacronutrientModel>?> getMacroNutrientsByMeal(
  //     String date, String cmiDetailsId) async {
  //   try {
  //     final response = await apiClient.getRequest(
  //         '/meal/macronutrients/$date/$cmiDetailsId',
  //         serverType: ServerTypes.customer);
  //     // return response;
  //     final result = response.fold((l) {
  //       ErrorHandle.error(l.message);
  //       return null;
  //     }, (r) {
  //       final macroNeutrientsList = r.data['macronutrients'] as List;
  //       debugPrint('${macroNeutrientsList.length}');

  //       // Map each item in mealInputsList to a MealInputByDate object and assign to mealInputsByDates
  //       return macroNeutrientsList
  //           .map((json) =>
  //               MacronutrientModel.fromJson(json as Map<String, dynamic>))
  //           .toList();
  //     });
  //     return result;
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<List<MicronutrientsCategoryModel>?> getMicroNutrientsByMeal(
  //     String date, String cmiDetailsId) async {
  //   try {
  //     final response = await apiClient.getRequest(
  //         '/meal/micronutrients/$date/$cmiDetailsId',
  //         serverType: ServerTypes.customer);
  //     //return response
  //     final result = response.fold((l) {
  //       ErrorHandle.error(l.message);
  //       return null;
  //     }, (r) {
  //       final micronutrientsResponse =
  //           r.data['micronutrients'] as Map<String, dynamic>?;
  //       if (micronutrientsResponse == null)
  //         return <MicronutrientsCategoryModel>[];

  //       return micronutrientsResponse.entries
  //           .map<MicronutrientsCategoryModel>((entry) {
  //         final categoryName = entry.key;
  //         final categoryMicronutrients = entry.value as Map<String, dynamic>;

  //         return MicronutrientsCategoryModel.fromJson(
  //             categoryName, categoryMicronutrients);
  //       }).toList();
  //     });

  //     return result;
  //   } catch (e) {
  //     debugPrint('Error caught in getMicroNutrients :: $e');
  //     return Future.error(e);
  //   }
  // }

  Future<List<MacronutrientModel>?> getBigDetails(
      {required String date, String? cmiDetailsId}) async {
    try {
      String endpoint = '/meal/macronutrients/$date';
      if (cmiDetailsId != null && cmiDetailsId.isNotEmpty) {
        endpoint += '?cmiDetailsId=$cmiDetailsId';
      }

      final response = await apiClient.getRequest(endpoint,
          serverType: ServerTypes.customer);

      // return response;
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final macroNeutrientsList = r.data['macronutrients'] as List;
        debugPrint('${macroNeutrientsList.length}');

        // Map each item in mealInputsList to a MealInputByDate object and assign to mealInputsByDates
        return macroNeutrientsList
            .map((json) =>
                MacronutrientModel.fromJson(json as Map<String, dynamic>))
            .toList();
      });
      return result;
    } catch (e) {
      debugPrint('Error caught in getBigDetails :: $e');
      return Future.error(e);
    }
  }

  Future<List<MicronutrientsCategoryModel>?> getSmallDetails(
      {required String date, String? cmiDetailsId}) async {
    try {
      String endpoint = '/meal/micronutrients/$date';
      if (cmiDetailsId != null && cmiDetailsId.isNotEmpty) {
        endpoint += '?cmiDetailsId=$cmiDetailsId';
      }

      final response = await apiClient.getRequest(endpoint,
          serverType: ServerTypes.customer);

      //return response
      final result = response.fold((l) {
        ErrorHandle.error(l.message);
        return null;
      }, (r) {
        final micronutrientsResponse =
            r.data['micronutrients'] as Map<String, dynamic>?;
        if (micronutrientsResponse == null) {
          return <MicronutrientsCategoryModel>[];
        }

        return micronutrientsResponse.entries
            .map<MicronutrientsCategoryModel>((entry) {
          final categoryName = entry.key;
          final categoryMicronutrients = entry.value as Map<String, dynamic>;

          return MicronutrientsCategoryModel.fromJson(
              categoryName, categoryMicronutrients);
        }).toList();
      });

      return result;
    } catch (e) {
      debugPrint('Error caught in getSmallDetails :: $e');
      return Future.error(e);
    }
  }

  Future<dynamic> getFoodItemsFromVfs() async {
    try {
      final response = await apiClient.request('vfs/approved-food-list',
          method: "GET", serverType: ServerTypes.vfs);

      if (response['status'] == 'success') {
        debugPrint(
            'getFoodItemsFromVfs function called successfully ${response['status']}');
        return response;
      }
    } catch (e) {
      debugPrint('Error caught in getFoodItemsFromVfs :: $e');
      return Future.error(e);
    }
  }
}
