import 'package:hive/hive.dart';

part 'song.g.dart';

/// Song model class for hive .
@HiveType(typeId: 1)
class Song extends HiveObject {
  @HiveField(0)
  int totalTimesPlayed;
  @HiveField(1)
  DateTime lastPlayed;
  @HiveField(2)
  String key;

  Song({
    required this.totalTimesPlayed,
    required this.lastPlayed,
    required this.key
  });
}
