import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/widgets/song_cover_image.dart';
import 'package:hougaku/routes/app_pages.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sizer/sizer.dart';
import '../home_controller.dart';

/// Horizontal playlist of songs .
class HorizontalSongList extends GetView {
  final List<SongModel>? songs;
  final HomeController controller;

  const HorizontalSongList({
    Key? key,
    required this.songs,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 55.w,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: songs?.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.PLAYER,
                    arguments: {"songList": songs, "index": index});
              },
              child: Padding(
                padding: EdgeInsets.all(1.5.w),
                child: SizedBox(
                  width: 40.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child:
                              SongCoverImage(id: songs![index].id, size: 39.w)),
                      SizedBox(height: 7),
                      Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Text(
                          songs![index].title,
                          maxLines: 2,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
