import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hougaku/core/values/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../controller/player_controller.dart';
import '../home/home_controller.dart';

/// Controller for player screen .
class PlayerScreenController extends GetxController {
  final _playerController = Get.find<PlayerController>();
  final _homeController = Get.find<HomeController>();

  final _favBox = Hive.box('favList');

  final List<SongModel> _songs = Get.arguments["songList"];
  int _index = Get.arguments["index"];

  Rx<bool> is_favourite = true.obs;
  Rx<bool> is_shuffle = true.obs;

  @override
  void onInit() async {
    _playerController.addNewPlaylist(_songs, _index);

    /// initial value for favourite state.
    _playerController.mediaItem.listen((p0) {
      is_favourite.value =
          !_favBox.containsKey(_playerController.mediaItem.value.id);
    });

    /// initial value for favourite state.

    /// initial value for shuffle state.
    is_shuffle.value = !audioPlayer.shuffleModeEnabled;
    super.onInit();
  }

  /// The favourite controller .
  void favourite() {
    is_favourite.value = !is_favourite.value;
    if (is_favourite.value) {
      /// delete if already exists .
      _favBox.delete(_playerController.mediaItem.value.id);
    } else {
      /// add if not already added .
      _favBox.put(_playerController.mediaItem.value.id,
          _playerController.mediaItem.value.id);
    }
    _homeController.updatePlaylist();
  }

  /// The shuffle controller .
  void shuffleControl() {
    is_shuffle.value = !is_shuffle.value;

    /// Change shuffle mode .
    audioPlayer.setShuffleModeEnabled(!audioPlayer.shuffleModeEnabled);
  }
}
