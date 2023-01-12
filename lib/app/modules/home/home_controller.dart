import 'dart:core';
import 'dart:math';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/utils/image_creator.dart';
import '../../../core/values/constants.dart';
import '../../data/models/song.dart';
import '../../data/providers/song_provider.dart';

/// Controller class for home screen .
class HomeController extends FullLifeCycleController
    with StateMixin<List<SongModel>>, FullLifeCycleMixin {
  List<SongModel> songs = <SongModel>[];
  late List<SongModel> dailyMix;
  late List<SongModel> lastAdded;
  List<SongModel> recentlyPlayed = <SongModel>[];
  List<SongModel> mostPlayed = <SongModel>[];
  List<SongModel> downloads = <SongModel>[];
  List<SongModel> favourites = <SongModel>[];
  final _songBox = Hive.box<Song>('songList');
  final _favBox = Hive.box('favList');
  late List<Song> _recentlyPlayedDB;
  late List<Song> _mostPlayedDB;
  late List _favoritesDB;

  @override
  void onInit() async {
    requestStoragePermission();
    _fetchSongListFromDB();
    _fetchSongs();
    await ImageCreator.getImageFileFromAssets('/images/music_cover.webp');
    super.onInit();
  }

  // To request storage permission to access audio files .
  void requestStoragePermission() async {
    bool status = await audioQuery.permissionsStatus();

    if (!status) {
      bool updatedStatus = await audioQuery.permissionsRequest();
      if (updatedStatus == false) {
        _permissionHandling();
      }
    }
  }

  // To open permission settings when user denied permission .
  Future<void> _permissionHandling() async {
    bool status = await audioQuery.permissionsStatus();
    Get.back();
    if (!status) {
      Get.defaultDialog(
          title: "Warning",
          middleText: "Enable storage permission of the app to play songs",
          onConfirm: () async {
            await openAppSettings();
          },
          onCancel: () {});
    } else {
      _fetchSongs();
    }
  }

  /// To update playlist from db .
  void updatePlaylist() {
    _fetchSongListFromDB();
    _updateMostPlayed();
    _updateFavorites();
    _updateRecentlyPlayed();
    update();
  }

  /// To fetch song list from db .
  void _fetchSongListFromDB() {
    _recentlyPlayedDB = _songBox.values.toList();
    _mostPlayedDB = _songBox.values.toList();
    _favoritesDB = _favBox.values.toList();

    /// Sort based on last played songs .
    _recentlyPlayedDB.sort((b, a) => a.lastPlayed.compareTo(b.lastPlayed));

    /// Sort based on most played songs.
    _mostPlayedDB
        .sort((b, a) => a.totalTimesPlayed.compareTo(b.totalTimesPlayed));
  }

  /// update favorites list .
  void _updateFavorites() {
    favourites.clear();
    for (var i = 0; i < _favoritesDB.length; i++) {
      for (var e = 0; e < songs.length; e++) {
        if (_favoritesDB[i] == songs[e].id.toString()) {
          favourites.add(songs[e]);
        }
      }
    }
  }

  /// update recently played list .
  void _updateRecentlyPlayed() {
    recentlyPlayed.clear();
    for (var i = 0; i < _recentlyPlayedDB.length; i++) {
      for (var e = 0; e < songs.length; e++) {
        if (_recentlyPlayedDB[i].key == songs[e].id.toString()) {
          recentlyPlayed.add(songs[e]);
        }
      }
    }

    /// sublist of recentlyPlayed songs .
    recentlyPlayed.length < 10
        ? recentlyPlayed = recentlyPlayed.sublist(0, recentlyPlayed.length)
        : recentlyPlayed = recentlyPlayed.sublist(0, 10);
  }

  /// update most played list .
  void _updateMostPlayed() {
    mostPlayed.clear();
    for (var i = 0; i < _mostPlayedDB.length; i++) {
      for (var e = 0; e < songs.length; e++) {
        if (_mostPlayedDB[i].key == songs[e].id.toString()) {
          mostPlayed.add(songs[e]);
        }
      }
    }

    /// sublist of mostPlayed songs .
    mostPlayed.length < 10
        ? mostPlayed = mostPlayed.sublist(0, mostPlayed.length)
        : mostPlayed = mostPlayed.sublist(0, 10);
  }

  /// update daily mix .
  void _updateDailyMix() {
    final _random = Random();
    if (songs.length < 10) {
      dailyMix = List.generate(
              songs.length, (_) => songs[_random.nextInt(songs.length)])
          .toSet()
          .toList();
    } else {
      dailyMix =
          new List.generate(songs.length, (_) => songs[_random.nextInt(10)])
              .toSet()
              .toList();
    }
  }

  /// update last added songs .
  void _updateLastAdded() {
    songs.length < 10
        ? lastAdded = songs.sublist(0, songs.length)
        : lastAdded = songs.sublist(0, 10);
  }

  /// To fetch songs .
  void _fetchSongs() {
    songs.clear();
    SongProvider().fetchSongList().then((resp) {
      if (resp.isEmpty) {
        change(songs, status: RxStatus.empty());
      } else {
        /// add data into song list and filter whatsapp audio.
        resp.forEach((element) {
          if (element.isMusic! &&
              element.fileExtension != "opus" &&
              element.album != "WhatsApp Audio") {
            songs.add(element);
            ImageCreator.getImageFileFromAudio(element.data);

            /// Add downloaded songs in to new list .
            if (element.data.contains("ownload")) {
              downloads.add(element);
            }
          }
        });

        // To generate different song list
        _updateDailyMix();
        _updateLastAdded();
        _updateRecentlyPlayed();
        _updateMostPlayed();
        _updateFavorites();
        // Update the changes
        change(songs, status: RxStatus.success());
      }
    }, onError: (err) {
      change(
        null,
        status: RxStatus.error(err.toString()),
      );
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    _permissionHandling();
  }
}
