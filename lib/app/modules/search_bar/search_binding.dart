import 'package:get/get.dart';
import 'package:hougaku/app/modules/search_bar/search_controller.dart';

/// Dependency injection for search screen .
class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
