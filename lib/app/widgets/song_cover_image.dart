import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongCoverImage extends StatelessWidget {
  final int id;
  final double size;

  const SongCoverImage({Key? key, required this.id, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
      id: id,
      type: ArtworkType.AUDIO,
      artworkClipBehavior: Clip.none,
      artworkHeight: size,
      artworkWidth: size,
      artworkFit: BoxFit.cover,
      nullArtworkWidget: Image.asset(
        'assets/images/music_cover.webp',
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
