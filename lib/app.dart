import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:recipe_app/config/routes/app_pages.dart';
import 'package:recipe_app/config/routes/app_routes.dart';
import 'package:recipe_app/modules/Home/binding/home_binding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialBinding: HomeBinding(),
      builder: FlutterSmartDialog.init(),

      // home: SplashScreen(),
      initialRoute: RouteView.home.name,
      getPages: AppRouting.route,
    );
  }
}
