import 'package:get/get.dart';
import 'package:recipe_app/modules/Home/views/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
