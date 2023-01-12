import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../core/values/constants.dart';
import '../../data/models/song.dart';
import '../home/home_controller.dart';

class SettingsController extends GetxController {
  TimeOfDay? newTime;
  final _favBox = Hive.box('favList');
  final _songBox = Hive.box<Song>('songList');
  final _sleepTimerBox = Hive.box('sleepTime');
  final _homeController = Get.find<HomeController>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> setSleepTimer(TimeOfDay updatedTime) async {
    DateTime now = new DateTime.now();
    DateTime selectedTime = DateTime(
        now.year, now.month, now.day, updatedTime.hour, updatedTime.minute);
    Duration timeLeft = selectedTime.difference(now);
    _sleepTimerBox.put("sleepTimer", selectedTime);
    await Future.delayed(timeLeft, () {
      DateTime lastSelectedTime = _sleepTimerBox.get("sleepTimer");
      if (lastSelectedTime.minute == DateTime.now().minute) {
        audioPlayer.stop();
      }
    });
    print(timeLeft);
  }

  Future<void> clearDB() async {
    await _favBox.clear();
    await _sleepTimerBox.clear();
    await _songBox.clear();
    _homeController.updatePlaylist();
  }
}
