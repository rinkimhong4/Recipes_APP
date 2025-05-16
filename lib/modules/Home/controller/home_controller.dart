import 'package:get/get.dart';
import 'package:recipe_app/core/data/about_us_data.dart';
import 'package:recipe_app/core/services/api_service.dart';
import 'package:recipe_app/core/string/string_con.dart';
import 'package:recipe_app/modules/Home/models/about_us_model.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  RecipeModels recipeModels = RecipeModels();

  Future<void> loadingRecipe() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      recipeModels = await apiService.callApi<RecipeModels>(
        endpoint: RECIPE,
        body: {},
        fromJson: (data) => RecipeModels.fromJson(data),
      );
    } catch (e) {
      errorMessage.value = 'Failed to load recipes: $e';
    } finally {
      isLoading.value = false;
    }
  }

  AboutUsModels aboutUsModels = AboutUsModels();
  List<AboutUsModels> aboutUsModelsList = [];
  Future<void> loadingAboutUs() async {
    isLoading.value = true;
    aboutUsModels = AboutUsModels.fromJson(Datas.data["data"]!);
    isLoading.value = false;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadingRecipe();
    await loadingAboutUs();
  }
}
