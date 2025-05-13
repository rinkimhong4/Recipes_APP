// import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/routes/app_routes.dart';
// import 'package:recipe_app/modules/Home/views/profile/profile_screen_small.dart';
import 'package:recipe_app/modules/Home/views/splash/splash_screen.dart';

class AppRouting {
  static final route =
      RouteView.values.map((e) {
        switch (e) {
          case RouteView.home:
            return GetPage(
              name: "/",
              page: () => SplashScreen(),
              transition: Transition.noTransition,
            );
          // case RouteView.profile:
          //   return GetPage(
          //     name: "/${e.name}",
          //     page: () => ProfileScreenSmall(),
          //     // binding: (),
          //   );
          // case RouteView.location:
          //   return GetPage(
          //     name: "/${e.name}",
          //     page: () => Container(),
          //     binding: NotificationBinding(),
          //   );
        }
      }).toList();
}
