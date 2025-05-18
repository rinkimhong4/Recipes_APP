import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipe_app/core/data/data.dart';
import 'package:recipe_app/core/services/api_service.dart';
import 'package:recipe_app/core/services/local_service.dart';
import 'package:recipe_app/core/string/string_con.dart';
import 'package:recipe_app/modules/Home/models/about_us_model.dart';
import 'package:recipe_app/modules/Home/models/recipe_models.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);

  final refreshController = RefreshController(initialRefresh: false).obs;

  Future<void> autoRefresh() async {
    refreshController.value.requestRefresh();
    isLoading.value = true;
    // await loadingApiData();
    await loadingRecipe();
    await loadingAboutUs();
    await _loadSavedProfile();
    isLoading.value = false;
    refreshController.value.refreshCompleted();
  }

  Future<void> onRefresh() async {
    // await loadingApiData();
    // await loadingData();
    await loadingRecipe();
    await loadingAboutUs();
    await _loadSavedProfile();
    refreshController.value.refreshCompleted();
  }

  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;

  // Form field observables
  final RxString name = ''.obs;
  final RxString phone = ''.obs;
  final RxString email = ''.obs;
  final RxString gender = ''.obs;
  final Rx<DateTime?> birthDate = DateTime.now().obs;
  final Rx<File?> profileImage = Rx<File?>(null);

  Future<void> _loadSavedProfile() async {
    isLoading.value = true;

    name.value = LocalStorageService.instance.getString('name') ?? '';
    phone.value = LocalStorageService.instance.getString('phone') ?? '';
    email.value = LocalStorageService.instance.getString('email') ?? '';
    gender.value = LocalStorageService.instance.getString('gender') ?? 'Gender';

    final savedDate = LocalStorageService.instance.getString('birthDate');
    if (savedDate != null) {
      birthDate.value = DateTime.parse(savedDate);
    }

    // final imagePath = LocalStorageService.instance.getString(
    //   'profileImagePath',
    // );
    // if (imagePath != null) {
    //   profileImage.value = File(imagePath);
    // }

    final base64Image = LocalStorageService.instance.getString('profileImage');
    if (base64Image != null) {
      final bytes = base64Decode(base64Image);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/profile_image.jpg');
      await file.writeAsBytes(bytes);
      profileImage.value = file;
    }
    isLoading.value = false;
  }

  Future<void> saveProfile() async {
    isLoading.value = true;
    await LocalStorageService.instance.setString('name', name.value);
    await LocalStorageService.instance.setString('phone', phone.value);
    await LocalStorageService.instance.setString('email', email.value);
    await LocalStorageService.instance.setString('gender', gender.value);

    if (birthDate.value != null) {
      await LocalStorageService.instance.setString(
        'birthDate',
        birthDate.value!.toIso8601String(),
      );
    }

    // if (profileImage.value != null) {
    //   await LocalStorageService.instance.setString(
    //     'profileImagePath',
    //     profileImage.value!.path,
    //   );
    // }

    if (profileImage.value != null) {
      final bytes = await profileImage.value!.readAsBytes();
      final base64Image = base64Encode(bytes);
      await LocalStorageService.instance.setString('profileImage', base64Image);
    }
    isLoading.value = false;
  }

  //
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

  AboutUsModels aboutUsModels = AboutUsModels();
  List<AboutUsModels> aboutUsModelsList = [];
  Future<void> loadingAboutUs() async {
    isLoading.value = true;
    aboutUsModels = AboutUsModels.fromJson(Datas.data["data"]!);
    isLoading.value = false;
  }

  // var getInputsEditProfile = TextEditingController();
  // var loading = false;
  // final _textValue = ''.obs;
  // void setTextValue(String value) async {
  //   await LocalStorageService.instance.setString('name', value);
  //   _textValue.value = LocalStorageService.instance.getString('name') ?? '';
  // }

  // get getTextValue => _textValue.value;

  @override
  Future<void> onInit() async {
    super.onInit();

    // _textValue.value = LocalStorageService.instance.getString('name') ?? '';

    await loadingRecipe();
    await loadingAboutUs();
    await _loadSavedProfile();

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
