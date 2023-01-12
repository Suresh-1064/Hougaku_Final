import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hougaku/app/controller/player_controller.dart';
import 'package:hougaku/app/data/models/song.dart';
import 'package:hougaku/routes/app_pages.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sizer/sizer.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  /// Initialise Hive nonSQL database .
  await Hive.initFlutter();
  /// Register custom object class in hive .
  Hive.registerAdapter(SongAdapter());
  await Hive.openBox<Song>('songList');
  await Hive.openBox('favList');
  await Hive.openBox('sleepTime');
  /// Set playerController to permanent through out the app .
  Get.put(PlayerController(), permanent: true);
  /// To initialize Just audio background with notification channel details .
  await JustAudioBackground.init(
      androidNotificationChannelId: 'ai.innovature.hougaku.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
      androidNotificationIcon: 'mipmap/launcher_icon');

  runApp(
      /// Sizer package is used for create responsive UI .
      Sizer(builder: (context, orientation, deviceType) {
    return GetMaterialApp(
      title: 'Hougaku',
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.hougakuThemeLight,
      darkTheme: AppTheme.hougakuTheme,
      defaultTransition: Transition.downToUp,
      getPages: AppPages.routes,
    );
  }));
}
