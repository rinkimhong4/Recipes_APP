import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:recipe_app/core/services/api_service.dart';
import 'package:recipe_app/core/string/string_con.dart';
import 'package:recipe_app/modules/Home/models/product_models.dart';

class HomeController extends GetxController {
  ApiService get apiService => ApiService(baseUrl: URL);
  RxBool isLoading = true.obs;

  ProductModels productModels = ProductModels();
  Future<void> loadingApiData() async {
    isLoading.value = true;

    productModels = await apiService.callApi<ProductModels>(
      endpoint: PRODUCT,
      body: {},
      fromJson: (data) => ProductModels.fromJson(data),
    );

    SmartDialog.dismiss();
    isLoading.value = false;
  }

  // await apiService.callApi<ProductModels>(
  //       endpoint: '/product/',
  //       // queryParams: {},
  //       method: 'POST',
  //       headers: {},
  //       body: {},
  //       fromJson: (data) => ProductModels.fromJson(data),
  //       isShowProcessDialog: false,
  //     );

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadingApiData();
  }
}
