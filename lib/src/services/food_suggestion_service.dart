import 'package:get/get.dart';
import 'package:vizzhy/src/features/conversation/presentation/Repository/meals_repository.dart';

///This class is used to handle food suggestion functionality.
class FoodSuggestionService {
  FoodSuggestionService._();

  static final FoodSuggestionService _instance = FoodSuggestionService._();

  ///Getter method to get instance of the service
  static FoodSuggestionService get service => _instance;

  final _mealsRepo = MealsRepository();

  ///Initialize empty array of foodNames
  List<String> foodNames = [];

  ///Loader to handle loading state of fetchFoodNamesFromApi API
  RxBool isLoading = false.obs;

  ///After getting all the foodNames from fetchFoodNamesFromApi API foodNames are updated in foodNames array
  void updateFoodNames(List<String> newFoodNames) {
    foodNames = newFoodNames;
  }

  ///Function to fetch food data from VFS endpoint and make list of only foodnames from that data
  void fetchFoodNamesFromApi() async {
    isLoading(true);
    final result = await _mealsRepo.getFoodItemsFromVfs();

    if (result['status'] == 'success') {
      List<String> parsedFoodNames = (result['data'] as List)
          .map<String>((item) => item['food_name'].toString())
          .toList();

      updateFoodNames(parsedFoodNames);
    }
    isLoading(false);
  }

  ///Function to give suggestion list that depends upon the query
  List<String> getSuggestions(String query) {
    return foodNames
        .where((food) => food.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
