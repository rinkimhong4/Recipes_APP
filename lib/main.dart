import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app.dart';
import 'package:recipe_app/core/services/local_service.dart';
import 'package:recipe_app/modules/Home/controller/home_controller.dart';

void main() {
  Get.put(HomeController());
  LocalStorageService.instance.init();
  runApp(const MyApp());
}
