import 'package:flutter/material.dart';
import 'package:hougaku/app/controller/player_controller.dart';
import 'dart:io';

import '../../player/widgets/play_control_icons.dart';
import '../../player/widgets/player_text.dart';

/// Mini player for home screen .
class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key, required this.controller}) : super(key: key);
  final PlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.5),
                offset: const Offset(5, 10),
                spreadRadius: 3,
                blurRadius: 10),
            BoxShadow(
                color: Theme.of(context).scaffoldBackgroundColor,
                offset: const Offset(-3, -4),
                spreadRadius: -2,
                blurRadius: 20)
          ]),
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: PlayerText(
            text: controller.mediaItem.value.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1!),
        subtitle: PlayerText(
            text: '${controller.mediaItem.value.artist}\n',
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1!),
        leading: Image(
          fit: BoxFit.fill,
          image: FileImage(
            File(
              controller.mediaItem.value.artUri!
                  .toFilePath(),
            ),
          ),
        ),
        trailing: PlayControlIcons(
            primaryIcon: Icons.play_arrow,
            secondaryIcon: Icons.pause,
            size: 40,
            state: controller.is_pause.value,
            function: controller.smartPlay),
      ),
    );
  }
}
