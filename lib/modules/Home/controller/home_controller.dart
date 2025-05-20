import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipe_app/core/services/api_service.dart';
import 'package:recipe_app/core/string/string_con.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);

  final refreshController = RefreshController(initialRefresh: false).obs;
  var isLoading = true.obs;
  RxString errorMessage = ''.obs;

  Future<void> autoRefresh() async {
    refreshController.value.requestRefresh();
    isLoading.value = true;
    await loadingRecipe();
    isLoading.value = false;
    refreshController.value.refreshCompleted();
  }

  Future<void> onRefresh() async {
    await loadingRecipe();
    refreshController.value.refreshCompleted();
  }

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoRefresh();
    });
  }

  @override
  void onClose() {
    refreshController.value.dispose();
    super.onClose();
  }
}
