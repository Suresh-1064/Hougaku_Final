import 'package:get/get.dart';
import 'package:hougaku/app/modules/settings/settings_controller.dart';

/// Dependency injection for settings screen .
class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
