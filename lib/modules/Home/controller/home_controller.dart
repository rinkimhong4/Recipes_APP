import 'package:get/get.dart';
import 'package:recipe_app/core/services/api_service.dart';
import 'package:recipe_app/core/string/string_con.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);
  RxBool isLoading = true.obs;

  RecipeModels recipeModels = RecipeModels();

  Future<void> loadingRecipe() async {
    isLoading.value = true;
    recipeModels = await apiService.callApi<RecipeModels>(
      endpoint: RECIPE,
      body: {},
      fromJson: (data) => RecipeModels.fromJson(data),
    );
    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadingRecipe();
  }
}
