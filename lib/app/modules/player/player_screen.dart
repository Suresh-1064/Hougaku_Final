import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/controller/player_controller.dart';
import 'package:hougaku/app/modules/player/player_screen_controller.dart';
import 'package:hougaku/app/modules/player/widgets/play_control_icons.dart';
import 'package:hougaku/app/modules/player/widgets/player_text.dart';
import 'package:hougaku/core/utils/time_format.dart';
import 'package:sizer/sizer.dart';

import '../../../core/values/constants.dart';

/// UI for player screen .
class PlayerScreen extends GetView {
  final playerScreenController = Get.find<PlayerScreenController>();
  final playerController = Get.find<PlayerController>();

  PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          Container(
            height: 50.h,
            child: Image(
              fit: BoxFit.cover,
              image: FileImage(
                File(
                  playerController.mediaItem.value.artUri!.toFilePath(),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80.0, sigmaY: 80.0),
            child: Container(
              height: 50.h,
              decoration:
                  BoxDecoration(color: Colors.grey[900]?.withOpacity(0.5)),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 66.h - 94.w),
                  child: Container(
                    width: 88.w,
                    height: 94.w,
                    child: Image(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(
                          playerController.mediaItem.value.artUri!.toFilePath(),
                        ),
                      ),
                    ),
                  ))),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 66.h),
              child: Container(
                height: 100.h - (66.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        PlayerText(
                            text: playerController.mediaItem.value.title,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.headline4!),
                        PlayerText(
                            text:
                                '${playerController.mediaItem.value.artist}\n',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1!),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 3.w),
                              width: 15.w,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                  TimeFormat.secondsToMinutes(
                                      timeInSecond: playerController
                                          .audioPosition
                                          .toInt()),
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                            Container(
                              width: 70.w,
                              child: Slider(
                                min: 0.0,
                                activeColor:
                                    Colors.blueGrey.shade400.withOpacity(0.5),
                                inactiveColor:
                                    Colors.blueGrey.shade300.withOpacity(0.3),
                                value: (playerController.audioPosition
                                        .floorToDouble() *
                                    990 /
                                    playerController.audioDuration
                                        .ceilToDouble()),
                                onChanged: (double value) => audioPlayer.seek(
                                    Duration(
                                        seconds: (playerController.audioDuration
                                                    .toInt() *
                                                value) ~/
                                            990)),
                                max: 1000,
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomCenter,
                              width: 15.w,
                              padding: EdgeInsets.only(right: 3.w),
                              child: Text(
                                  TimeFormat.secondsToMinutes(
                                      timeInSecond: playerController
                                          .audioDuration
                                          .toInt()),
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayControlIcons(
                                primaryIcon: Icons.favorite_border,
                                secondaryIcon: Icons.favorite,
                                size: 15,
                                function: playerScreenController.favourite,
                                state:
                                    playerScreenController.is_favourite.value),
                            PlayControlIcons(
                                primaryIcon: Icons.skip_previous,
                                secondaryIcon: Icons.skip_previous,
                                size: 32,
                                state: true,
                                function: playerController.previous),
                            PlayControlIcons(
                                primaryIcon: Icons.play_arrow,
                                secondaryIcon: Icons.pause,
                                size: 40,
                                state: playerController.is_pause.value,
                                function: playerController.smartPlay),
                            PlayControlIcons(
                                primaryIcon: Icons.skip_next,
                                secondaryIcon: Icons.skip_next,
                                size: 32,
                                state: true,
                                function: playerController.next),
                            PlayControlIcons(
                                primaryIcon: Icons.shuffle,
                                secondaryIcon: Icons.shuffle_on_outlined,
                                size: 15,
                                state: playerScreenController.is_shuffle.value,
                                function:
                                    playerScreenController.shuffleControl),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
