import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../core/values/constants.dart';

class SearchController extends GetxController {
  List<SongModel> convertedSongs = [];

  @override
  void onInit() {
    super.onInit();
  }

  void search(String keyword) async {
    List<dynamic> querySongs = await audioQuery.queryWithFilters(
      // The text to search
      keyword,
      WithFiltersType.AUDIOS,
    );

    convertedSongs = querySongs.toSongModel();
    update();
  }
}
