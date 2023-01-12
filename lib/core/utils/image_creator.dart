import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/// Utility class for creating local image files in cache .

abstract class ImageCreator {
  /// To create dummy art image for songs .

  static Future<String> getImageFileFromAssets(String path) async {
    Directory? directoryPath = await getTemporaryDirectory();
    final byteData = await rootBundle.load('assets$path');
    final file = await File(directoryPath.path + "/cover_image").create();
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;
  }

  /// To create art image for songs from meta data of corresponding song

  static Future<String?> getImageFileFromAudio(String filePath) async {
    final metadata = await MetadataRetriever.fromFile(File(filePath));
    Uint8List? imageInUnit8List = metadata.albumArt;
    if (imageInUnit8List == null) {
      return null;
    }
    Directory? directoryPath = await getTemporaryDirectory();
    final file =
        await File(directoryPath.path + "/" + metadata.trackName!).create();
    await file.writeAsBytes(imageInUnit8List);
    return file.path;
  }
}
