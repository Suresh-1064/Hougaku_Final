import 'package:get/get.dart';

import 'home_controller.dart';

/// Dependency injection for home screen .
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
