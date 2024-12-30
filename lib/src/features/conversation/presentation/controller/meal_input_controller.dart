import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:vizzhy/src/features/conversation/presentation/Repository/meals_repository.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/macro_neutrient_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/meal_by_date_response.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/meal_input_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_category_model.dart';
import 'package:vizzhy/src/features/conversation/presentation/models/micro_nutrients_model.dart';

///This controller is used to handle all neccessarry function related to meals
class MealInputController extends GetxController {
  final _mealsRepo = MealsRepository();

  ///List for MealInput
  var mealInputs = <MealInput>[].obs;

  ///List to store mealInputs per date
  var mealInputsByDates = <MealInputByDate>[].obs;

  ///List to store Macronutrients per date
  var macroNutrientsByDates = <MacronutrientModel>[].obs;

  ///List to store Micronutrients per date
  var micronutrientsByDates = <MicronutrientsModel>[].obs;

  ///List to store micronutriets per day
  var micronutrientsByDay = <MicronutrientsCategoryModel>[].obs;

  ///Lists according to the meal
  var macroNutrientsByMeal = <MacronutrientModel>[].obs;

  ///List to store micronutrients per category model
  var micronutrientsByMeal = <MicronutrientsCategoryModel>[].obs;

  ///Loader to handle loading state of the controller
  var isLoading = false.obs;

  ///Loader for macronutrient API requests
  var isMacroLoader = false.obs;

  ///Loader for Micronutrients API request
  var isMicroLoader = false.obs;

  /// use while fetching micro via date
  RxBool isMicroByDateLoading = false.obs;

  /// use while fetching micro via day
  RxBool isMicroByDayLoading = false.obs;

  /// use while fetching Macro via date
  RxBool isMacroByDateLoading = false.obs;

  ///to check meal is posted or not
  var isPostMealLoader = false.obs;

  ///to check textfield is empty or not
  var isTextFieldEmpty = true.obs;

  ///boolean used to show nutrients
  var showNutrients = false.obs;

  ///Used to store error messages in the controller
  var errorMessage = ''.obs;

  ///Used to store selected date by user on calender
  var selectedDate = DateTime.now().obs;

  ///Used to store date of the single mealInput
  var mealInputDate = DateTime.now().obs;

  ///Used to format single mealInput date
  var formattedInputDate = DateTime.now().toString().obs;

  ///Used to store selected quantity
  var selectedQuantity = 1.obs;

  ///Used to store selected meal type
  var selectedMealType = ''.obs;

  ///Used to store available units
  var availableUnits = [
    'Medium Cup',
    'Small Cup',
    'Small Glass',
    'Medium Glass',
    'Large Glass',
    'Teacup',
    'Bowl/Large Cup',
    'Plate',
    'Tablespoon',
    'Bottle',
    'Can',
    'Peg',
    'Teaspoon',
    'Scoop',
    'Piece',
    'Slice',
    'Pint',
    'Ounce'
  ].obs;

  ///Used to store available meal type
  var availableMealTypes = [
    'Breakfast',
    'Lunch',
    'Snacks',
    'Dinner',
    'Post dinner',
    'Mid night',
  ].obs;

  ///Used to store selected Meal Unit
  var selectedUnits = 'Medium Cup'.obs;

  ///Boolean to check meal is correct or not
  RxBool isMealCorrect = false.obs;

  ///Boolean used to check whether user want to show calender or not
  RxBool isShowCalender = false.obs;

  ///Scroll controller to handle scroll of the screen
  final ScrollController scrollController = ScrollController();

  ///TextEditing controller
  final TextEditingController textEditingController = TextEditingController();

  ///MacroNutrients details list
  var bigDetailsList = <MacronutrientModel>[].obs;

  ///Macronutrients detail list
  var smallDetailsList = <MicronutrientsCategoryModel>[].obs;

  ///Loader for Macronutrients
  var isBigLoading = false.obs;

  ///Loader for Micronutrients
  var isSmallLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // fetchMealInputs();
    selectedDate.value = DateTime.now();
    fetchMealInputsByDates(selectedDate.value.toString());
    textEditingController.addListener(() {
      isTextFieldEmpty.value = textEditingController.text.isEmpty;
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    textEditingController.dispose();
    super.onClose();
  }

  ///This function is used to reset all the values in the controller
  void reset() async {
    isTextFieldEmpty.value = true;
    errorMessage.value = '';
    textEditingController.text = '';
    selectedMealType.value = '';
    isMealCorrect.value = false;
    mealInputs.clear();
    mealInputsByDates.clear();
    macroNutrientsByDates.clear();
    micronutrientsByDates.clear();
    micronutrientsByDay.clear();
    macroNutrientsByMeal.clear();
    micronutrientsByMeal.clear();
    isLoading.value = false;
    isPostMealLoader.value = false;
    isMicroByDayLoading.value = false;
    selectedDate.value = DateTime.now();
    mealInputDate.value = DateTime.now();
    formattedInputDate.value = DateTime.now().toString();
    selectedUnits.value = 'Medium Cup';
    selectedQuantity.value = 1;
    isMealCorrect.value = false;
    isShowCalender.value = false;
    update();
  }

  ///This function is used to fetch all previous meal inputs of the user
  Future<bool> fetchMealInputs() async {
    mealInputs.clear();
    if (isLoading.value) return false;
    errorMessage('');
    isLoading(true);

    final val = await _mealsRepo.getMealsInput();
    // .then(
    //   (value) {
    isLoading(false);
    if (val != null) {
      mealInputs.value = val;
      return true;
    } else {
      return false;
    }
    //   },
    //   onError: (e) {
    //     debugPrint("error on fetch meal inputs in mealinput controller :$e");
    //     isLoading(false);
    //     ErrorHandle.error('$e');
    //     return false;
    //   },
    // );
    // return val;
  }

  ///This function is used to get meal inputs of the user with respect to date
  Future<void> fetchMealInputsByDates(String date) async {
    mealInputsByDates.clear(); // Clear existing data
    if (isLoading.value) return; // If already loading, do nothing
    errorMessage(''); // Clear any previous errors
    isLoading(true); // Set loading to true

    try {
      // Call the repository method to get the meal input data by dates
      final value = await _mealsRepo.getMealsInputByDates(date);

      isLoading(false); // Set loading to false once the call completes

      // Check if the response indicates success
      if (value != null) {
        // Map each item in mealInputsList to a MealInputByDate object and assign to mealInputsByDates
        mealInputsByDates.value = value;
      }
    } catch (e) {
      // Handle any exception that occurs during the process
      isLoading(false); // Ensure loading is stopped
      debugPrint(
          'Error caught in fetchMealInputsByDates : $e'); // Log or display the error
    }
  }

  ///This function is used to post mealInput through ASR
  Future<bool> postMealInput(String mealInput) async {
    if (isPostMealLoader.value) return false;
    errorMessage('');
    isPostMealLoader(true);

    try {
      debugPrint('Calling from postMealInputs');
      final val = await _mealsRepo.postMealInputs(mealInput);
      isPostMealLoader(false);

      debugPrint('Called function successfully $val');

      return val;
    } catch (e) {
      isPostMealLoader(false);
      debugPrint('Error caught in postMealInput : $e');
      return false;
    }
  }

  ///This function is used to post meal for a respective day
  ///Need to pass mealInput, mealType, mealTime, foodUnit, mealDate
  Future<bool> postMealInputsByDate({
    required String mealInput,
    required String mealType,
    required String mealTime,
    required String foodUnit,
    required String mealDate,
    required num foodQuantity,
  }) async {
    if (isPostMealLoader.value) return false;
    errorMessage('');
    isPostMealLoader(true);

    try {
      debugPrint('Calling from postMealInputsByDate');
      final val = await _mealsRepo.postMealInputsByDate(
          mealInput: mealInput,
          mealType: mealType,
          mealTime: mealTime,
          foodUnit: foodUnit,
          foodQuantity: foodQuantity);
      isPostMealLoader(false);

      debugPrint('Result of the postMealInputsByDate $val');
      if (val) {
        debugPrint(
            'Passed date to update meal --------------------> : $mealDate');
        mealInputsByDates.clear();
        final getResponse = await _mealsRepo.getMealsInputByDates(mealDate);
        if (getResponse != null) {
          mealInputsByDates.value = getResponse;
        }
      }

      update();
      isLoading(false);
      update();

      return val;
    } catch (e) {
      isPostMealLoader(false);
      debugPrint('Error caught in postMealInputsByDate : $e');
      return false;
    }
  }

  ///This function is used to update previous meals of the user
  Future<void> updateMealInput(
      {required String cmiDetailsId,
      required String mealInput,
      required String mealType,
      required String mealTime,
      required String foodUnit,
      required num foodQuantity,
      required String mealDate}) async {
    if (isLoading.value) return;
    errorMessage('');
    isLoading(true);

    try {
      debugPrint('Calling from updateMealInput');
      final val = await _mealsRepo.updateMealInputs(
          cmiDetailsId: cmiDetailsId,
          mealInput: mealInput,
          mealType: mealType,
          mealTime: '$mealDate $mealTime',
          foodUnit: foodUnit,
          foodQuantity: foodQuantity);

      debugPrint('Result of the updateMealInput $val');
      if (val) {
        debugPrint(
            'Passed date to update meal --------------------> : $mealDate');
        mealInputsByDates.clear();
        final getResponse = await _mealsRepo.getMealsInputByDates(mealDate);
        if (getResponse != null) {
          mealInputsByDates.value = getResponse;
        }
      }
      update();
      isLoading(false);
      update();
    } catch (e) {
      isPostMealLoader(false);
      debugPrint('Error caught in postMealInputsByDate : $e');
    }
  }

  ///This function is used delete Meals of the user
  ///Need to pass cmiDetailsId and mealDate
  Future<void> deleteMeal(String cmiDetailsId, String mealDate) async {
    if (isLoading.value) return;
    errorMessage('');
    isLoading(true);

    try {
      final deleteResponse = await _mealsRepo.deleteMealInput(cmiDetailsId);
      if (deleteResponse == true) {
        debugPrint(
            'Passed date to delete meal --------------------> : $mealDate');
        mealInputsByDates.clear();
        final getResponse = await _mealsRepo.getMealsInputByDates(mealDate);
        if (getResponse != null) {
          mealInputsByDates.value = getResponse;
        }
      }
      update();
      isLoading(false);
      update();
    } catch (e) {
      isLoading(false);
      debugPrint('Error caught in deleteMeal : $e');
    }
  }

  ///This function is used to get Macronutrients of the user for the given date
  Future<void> fetchMacroNutrientsByDates(String date) async {
    macroNutrientsByDates.clear();
    if (isMacroByDateLoading.value) return;
    errorMessage('');
    isMacroByDateLoading(true);

    try {
      final value = await _mealsRepo.getMacroNutrients(date);
      isMacroByDateLoading(false);

      if (value != null) {
        macroNutrientsByDates.value = value;
        // debugPrint(macroNutrientsByDates[0].macronutrientName);
      }
    } catch (e) {
      isMacroByDateLoading(false);
      debugPrint('Error caught in fetchMacroNutrientsByDates : $e');
    }
  }

  ///This function is used to get Miconutrients of the user for the given date
  Future<void> fetchMicroNutrientsByDates(String date) async {
    micronutrientsByDates.clear();
    if (isMicroByDateLoading.value) return;
    errorMessage('');
    isMicroByDateLoading(true);

    try {
      final value = await _mealsRepo.getMicroNutrients(date);
      isMicroByDateLoading(false);
      if (value != null) {
        micronutrientsByDates.value = value;
        // debugPrint(micronutrientsByDates[0].micronutrientName);
      }
    } catch (e) {
      isMicroByDateLoading(false);
      debugPrint('Error caught in fetchMicroNutrientsByDates :: $e');
    }
  }

  ///This function is alternative of fetcMacronutrientsByDay & fetcMacronutrientsByMeal
  ///If want to get Macronutrients with respective of single meal then pass cmiDetailsId else pass null
  ///cmiDetailsId is optional
  Future<void> fetchBigDetails(
      {required String date, String? cmiDetailsId}) async {
    bigDetailsList.clear();
    if (isBigLoading.value) return;
    errorMessage('');
    isBigLoading(true);

    try {
      //
      final value = await _mealsRepo.getBigDetails(
          date: date, cmiDetailsId: cmiDetailsId);
      isBigLoading(false);
      if (value != null) {
        bigDetailsList.value = value;
        // debugPrint(macroNutrientsByDates[0].macronutrientName);
      }
    } catch (e) {
      isBigLoading(false);
      debugPrint('Error caught in fetchBigDetails : $e');
    }
  }

  ///This function is alternative of fetcMicronutrientsByDay & fetcMicronutrientsByMeal
  ///If want to get Micronutrients with respective of single meal then pass cmiDetailsId else pass null
  ///cmiDetailsId is optional
  Future<void> fetchSmallDetails(
      {required String date, String? cmiDetailsId}) async {
    smallDetailsList.clear();
    if (isSmallLoading.value) return;
    errorMessage('');
    isSmallLoading(true);

    try {
      final value = await _mealsRepo.getSmallDetails(
          date: date, cmiDetailsId: cmiDetailsId);
      // debugPrint(
      //     'Value of the fetchSmallDetails is ------------> ${value![8].categoryName}');
      isSmallLoading(false);
      if (value != null) {
        smallDetailsList.value = value;

        // ///Below part is only for fetching minerals_and_trace_elements category
        // final mineralsCategory = value
        //     .where(
        //       (element) =>
        //           element.categoryName == 'minerals_and_trace_elements',
        //     )
        //     .toList();

        // if (mineralsCategory.isNotEmpty) {
        //   micronutrientsByDates.value =
        //       mineralsCategory.first.micronutrients.values.toList();
        // } else {
        //   micronutrientsByDates.value = [];
        // }
      }
    } catch (e) {
      isSmallLoading(false);
      debugPrint('Error caught in fetchSmallDetails :: $e');
    }
  }

  // Future<void> fetchMicronutrientsByDay(String date) async {
  //   micronutrientsByDay.clear();
  //   if (isMicroByDayLoading.value) return;
  //   errorMessage('');
  //   isMicroByDayLoading(true);

  //   try {
  //     final value = await _mealsRepo.getMicronutrientsByDay(date);
  //     isMicroByDayLoading(false);
  //     if (value != null) {
  //       micronutrientsByDay.value = value;
  //     }
  //   } catch (e) {
  //     isMicroByDayLoading(false);
  //     debugPrint('Error caught in fetchMicronutrientsByDay :: $e');
  //   }
  // }

  // Future<void> fetchMacroNutrientsByMeal(
  //     String date, String cmiDetailsId) async {
  //   macroNutrientsByMeal.clear();

  //   if (isMacroLoader.value) return;
  //   errorMessage('');
  //   isMacroLoader(true);

  //   try {
  //     final value =
  //         await _mealsRepo.getMacroNutrientsByMeal(date, cmiDetailsId);
  //     isMacroLoader(false);

  //     if (value != null) {
  //       macroNutrientsByMeal.value = value;
  //       // debugPrint(macroNutrientsByDates[0].macronutrientName);
  //     }
  //   } catch (e) {
  //     isMacroLoader(false);
  //     debugPrint('Error caught in fetchMacroNutrientsByDates : $e');
  //   }
  // }

  // Future<void> fetchMicroNutrientsByMeal(
  //     String date, String cmiDetailsId) async {
  //   micronutrientsByMeal.clear();
  //   if (isMicroLoader.value) return;
  //   errorMessage('');
  //   isMicroLoader(true);

  //   try {
  //     final value =
  //         await _mealsRepo.getMicroNutrientsByMeal(date, cmiDetailsId);
  //     isMicroLoader(false);
  //     if (value != null) {
  //       micronutrientsByMeal.value = value;
  //       debugPrint(
  //           'Length of the micronutrients per meal is ${micronutrientsByMeal.length}');
  //       // debugPrint(micronutrientsByDates[0].micronutrientName);
  //     }
  //   } catch (e) {
  //     isMicroLoader(false);
  //     debugPrint('Error caught in fetchMicroNutrientsByDates :: $e');
  //   }
  // }

  ///This function is used to scroll to bottom automatically
  void scrollToBottom() {
    if (scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  ///This function is used to update selected date
  void updateSelectedDate(DateTime date) {
    selectedDate(date);
    fetchMealInputsByDates(date.toString());
  }

  ///This function is used to toggle between calender view
  void updateCalenderView() {
    isShowCalender.value = !isShowCalender.value;
  }

  ///This function is used to update mealInput date
  void updateMealInputDate(DateTime date) {
    final formattedDate = DateFormat('d MMM h:mm a').format(date);
    formattedInputDate(formattedDate);
    mealInputDate(date);
    update();
  }
}

///Binding for MealInputs
class MealsInputBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MealInputController>(() => MealInputController(), fenix: true);
  }
}
