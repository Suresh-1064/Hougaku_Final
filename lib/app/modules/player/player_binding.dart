import 'package:get/get.dart';
import 'package:hougaku/app/modules/player/player_screen_controller.dart';

/// Dependency injection for player screen .
class PlayerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayerScreenController>(() => PlayerScreenController());
  }
}
