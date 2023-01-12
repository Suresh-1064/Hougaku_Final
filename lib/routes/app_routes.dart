part of 'app_pages.dart';

/// Routes
abstract class Routes {
  static const SPLASHSCREEN = _Paths.SPLASHSCREEN;
  static const HOME = _Paths.HOME;
  static const PLAYER = _Paths.PLAYER;
  static const SEARCH = _Paths.SEARCH;
  static const SETTINGS = _Paths.Settings;
}

/// Paths
abstract class _Paths {
  static const SPLASHSCREEN = '/splashScreen';
  static const HOME = '/homeScreen';
  static const PLAYER = '/playerScreen';
  static const SEARCH = '/searchScreen';
  static const Settings = '/settings';
}
