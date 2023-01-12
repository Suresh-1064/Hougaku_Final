import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../core/values/constants.dart';
import '../data/models/song.dart';
import '../modules/home/home_controller.dart';

/// Controller for Audio player .
class PlayerController extends GetxController {
  List<SongModel> songs = [];
  AudioSource? _playList;
  final audioPosition = 0.obs;
  final audioDuration = 1.obs;
  Rx<MediaItem> mediaItem = MediaItem(id: "0", title: "song").obs;
  String? currentId;
  Rx<bool> is_pause = true.obs;
  late int initialIndex;
  bool firstPlay = false;
  final box = Hive.box<Song>('songList');

  @override
  void onInit() async {
    // To set stream values to reactive variables .
    audioPosition.bindStream(_getAudioStreamPosition());
    audioDuration.bindStream(_getAudioStreamDuration());
    mediaItem.bindStream(_getSequenceState());
    is_pause.bindStream(_getPlayerState());

    super.onInit();
  }

  /// To add new playList to audio player .
  Future<void> addNewPlaylist(List<SongModel> songsList, int index) async {
    initialIndex = index;
    songs = songsList;
    await createPlaylist(songsList);
    play(songsList[index].uri, index);
    if (firstPlay == false) {
      final homeController = Get.find<HomeController>();
      mediaItem.listen((p0) {
        /// To add first song in the play list to db .
        if (songs[initialIndex].id.toString() == p0.id) {
          currentId = p0.id;
          addToDb();
          homeController.updatePlaylist();
        }

        /// To add next songs in the play list to db .
        else if (currentId != p0.id) {
          currentId = p0.id;
          addToDb();
          homeController.updatePlaylist();
        }
      });
      firstPlay = true;
    }
  }

  /// Update the song details into db .
  void addToDb() {
    /// Add song details to db if it is new .
    if (!box.containsKey(mediaItem.value.id)) {
      box.put(
          mediaItem.value.id,
          Song(
              totalTimesPlayed: 1,
              lastPlayed: DateTime.now(),
              key: mediaItem.value.id));
    }

    /// Update song details to db if it is already exist .
    else {
      final song = box.get((mediaItem.value.id));
      int? totalPlayed = song?.totalTimesPlayed;
      song?.lastPlayed = DateTime.now();
      if (totalPlayed != null) {
        song?.totalTimesPlayed = totalPlayed + 1;
      } else {
        song?.totalTimesPlayed = 1;
      }
      song?.save();
    }
  }

  /// To create new playList with media items .
  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    return _playList = ConcatenatingAudioSource(
        children: songs
            .map(
              (song) => AudioSource.uri(
                Uri.parse(song.uri!),
                tag: MediaItem(
                    id: song.id.toString(),
                    album: song.album,
                    title: song.title,
                    artist: song.artist,
                    artUri: File("/data/user/0/ai.innovature.hougaku/cache/" +
                                song.title)
                            .existsSync()
                        ? Uri.file("/data/user/0/ai.innovature.hougaku/cache/" +
                            song.title)
                        : Uri.file(
                            "/data/user/0/ai.innovature.hougaku/cache/cover_image")),
              ),
            )
            .toList()
            .cast<AudioSource>());
  }

  /// For first time play from new playlist .
  Future<void> play(uri, int index) async {
    audioPlayer.stop();
    await audioPlayer.setAudioSource(_playList!,
        initialIndex: index, preload: false);
    audioPlayer.play();
  }

  /// To control audio player state
  void smartPlay() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
  }

  /// To play next song if exist .
  void next() {
    if (audioPlayer.hasNext) {
      audioPlayer.seekToNext();
      audioPlayer.play();
      update();
    }
  }

  /// To play previous song if exist .
  void previous() {
    if (audioPlayer.hasPrevious) {
      audioPlayer.seekToPrevious();
      audioPlayer.play;
      update();
    }
  }

  /// Return the current position of  audio playing .
  Stream<int> _getAudioStreamPosition() {
    Stream<Duration> stream = audioPlayer.positionStream;
    return stream.map((duration) => duration.inSeconds);
  }

  /// Return the duration of current audio playing .
  Stream<int> _getAudioStreamDuration() {
    Stream<Duration?> stream = audioPlayer.durationStream;
    return stream.map((duration) => duration?.inSeconds ?? 1);
  }

  /// Return the current media item .
  Stream<MediaItem> _getSequenceState() {
    Stream<SequenceState?> stream = audioPlayer.sequenceStateStream;
    return stream.map((state) => state!.currentSource!.tag as MediaItem);
  }

  /// Return the audio player state .
  Stream<bool> _getPlayerState() {
    Stream<PlayerState?> stream = audioPlayer.playerStateStream;
    return stream.map((value) => !value!.playing);
  }
}
