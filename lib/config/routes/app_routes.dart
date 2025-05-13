import 'package:get/get.dart';

// abstract class AppRoutes {
//   static const home = '/home';
// }

enum RouteView { home }

extension AppPages on RouteView {
  // Use: RouteView.home.go()
  Future<void> go({
    bool replacement = false,
    bool clearAll = false,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) async {
    if (clearAll) {
      return Get.offAllNamed(
        '/$name',
        arguments: arguments,
        id: id,
        parameters: parameters,
      );
    } else if (replacement) {
      return Get.offAndToNamed(
        '/$name',
        arguments: arguments,
        id: id,
        parameters: parameters,
      );
    } else {
      return Get.toNamed(
        '/$name',
        arguments: arguments,
        id: id,
        parameters: parameters,
      );
    }
  }
}
