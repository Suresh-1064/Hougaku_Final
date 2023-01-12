import 'package:get/get.dart';
import 'package:hougaku/app/modules/home/home_binding.dart';
import 'package:hougaku/app/modules/player/player_binding.dart';
import 'package:hougaku/app/modules/player/player_screen.dart';
import 'package:hougaku/app/modules/search_bar/search_binding.dart';
import 'package:hougaku/app/modules/search_bar/search_screen.dart';
import 'package:hougaku/app/modules/settings/settings_binding.dart';
import 'package:hougaku/app/modules/settings/settings_screen.dart';
import 'package:hougaku/app/modules/splash/splash_screen.dart';

part 'app_routes.dart';
/// Pages in the hougaku app .
abstract class AppPages {
  /// First page of the app .
  static const INITIAL = Routes.SPLASHSCREEN;

  /// Named pages with dependency injected .
  static final routes = [
    GetPage(
        name: Routes.SPLASHSCREEN,
        page: () => SplashScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.PLAYER,
        page: () => PlayerScreen(),
        binding: PlayerBindings()),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsScreen(),
        binding: SettingBinding())
  ];
}
