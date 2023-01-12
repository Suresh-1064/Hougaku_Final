import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/widgets/song_cover_image.dart';
import 'package:hougaku/routes/app_pages.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

/// Vertical song list view .
class VerticalSongList extends GetView {
  final List<SongModel>? songs;
  final AppBar appBar;
  const VerticalSongList({
    Key? key,
    required this.appBar,
    required this.songs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h - 16.w -
          (MediaQueryData.fromWindow(window).padding.top +
              appBar.preferredSize.height),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: songs?.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.PLAYER, arguments: {
                  "songList": songs,
                  "index": index,
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                child: SizedBox(
                    width: 100.w,
                    height: 15.w,
                    child: ListTile(
                      minVerticalPadding: 0,
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:
                          SongCoverImage(id: songs![index].id, size: 12.w)),
                      title: Text(
                        songs![index].title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      subtitle: Text(
                        songs![index].artist!,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2!,
                      ),
                    )),
              ),
            );
          }),
    );
  }
}
