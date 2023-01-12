import 'package:on_audio_query/on_audio_query.dart';
import '../../../core/values/constants.dart';

/// To fetch audio files from device storage using audio query package .
class SongProvider {
  List result = [];

  Future<List<SongModel>> fetchSongList() async {
    List<SongModel> songList = await audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.DESC_OR_GREATER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    result.add(songList);
    return songList;
  }
}
