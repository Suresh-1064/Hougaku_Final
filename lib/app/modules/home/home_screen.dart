import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/modules/home/widgets/mini_player.dart';
import 'package:hougaku/app/widgets/screen_title.dart';
import 'package:hougaku/app/modules/home/widgets/horizontal_song_list.dart';
import 'package:hougaku/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import '../../../core/utils/greeting.dart';
import '../../controller/player_controller.dart';
import '../player/widgets/play_control_icons.dart';
import '../player/widgets/player_text.dart';
import 'home_controller.dart';
import 'dart:io';

/// UI for home screen .
class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  final playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    //controller.requestStoragePermission();

    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      controller.obx(
        (songs) => ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: 5.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ScreenTitle(title: greeting),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.SETTINGS);
                  },
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(width: 2),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.SEARCH);
                  },
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                SizedBox(width: 10),
              ])
            ]),
            ScreenTitle(title: "All tracks"),
            HorizontalSongList(controller: controller, songs: songs),
            controller.downloads.isNotEmpty
                ? (Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        ScreenTitle(title: "Downloads"),
                        HorizontalSongList(
                            controller: controller,
                            songs: controller.downloads),
                      ]))
                : Container(),
            GetBuilder<HomeController>(
                builder: (_) => controller.recentlyPlayed.isNotEmpty
                    ? (Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            ScreenTitle(title: "Recently Played"),
                            HorizontalSongList(
                                controller: controller,
                                songs: controller.recentlyPlayed),
                          ]))
                    : Container()),
            GetBuilder<HomeController>(
                builder: (_) => controller.mostPlayed.isNotEmpty
                    ? (Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            ScreenTitle(title: "Most Played"),
                            HorizontalSongList(
                                controller: controller,
                                songs: controller.mostPlayed),
                          ]))
                    : Container()),
            ScreenTitle(title: "Daily mix"),
            HorizontalSongList(
                songs: controller.dailyMix, controller: controller),
            GetBuilder<HomeController>(
                builder: (_) => controller.favourites.isNotEmpty
                    ? (Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            ScreenTitle(title: "Favourites"),
                            HorizontalSongList(
                                controller: controller,
                                songs: controller.favourites),
                          ]))
                    : Container()),
            ScreenTitle(title: "Last Added"),
            HorizontalSongList(
                songs: controller.lastAdded, controller: controller),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: Center(
          child: Text(
            "No Songs Found!!, Add Some",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        onError: (_) => Center(
          child: Text(
            "Something went wrong",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Obx(
                () => playerController.mediaItem.value.id != "0"
                ? playerController.is_pause == true
                ? Dismissible(
              child: MiniPlayer(controller: playerController),
              key: Key(playerController.mediaItem.value.id),
            )
                : MiniPlayer(controller: playerController)
                : Container(),
          ))
    ])));
  }
}
