import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:hero/util/filesystem/itgzfile.dart';
import 'package:path_provider/path_provider.dart';

const photo = 'photo';
const video = 'video';

class TgzFile implements ITgzFile {
  @override
  Future<bool> isPathExist(String path) async {
    try {
      final file = File(path);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteDirectory() async {
    try {
      final Directory? dirVideo = await _getDirectoryVideo();
      await dirVideo!.delete(recursive: true);

      final Directory? dirPhoto = await _getDirectoryPhoto();
      await dirPhoto!.delete(recursive: true);
      return true;
    } catch (e) {
      return false;
    }
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String?> copyPhotoFroCacheToDestinationDirectory(
      XFile sourceFile) async {
    try {
      final String dirPath = await _createDirPathIfNotExist(photo);
      final String filePath = '$dirPath/${_timestamp()}.jpeg';

      File imageFile = File(sourceFile.path);

      await imageFile.copy(
        filePath,
      );
      return filePath;
    } catch (e) {
      return null;
    }
  }

  Future<String> _createDirPathIfNotExist(String foldername) async {
    final Directory? extDir =
        await _getDirectory(); //await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir!.path}/$foldername';
    await Directory(dirPath).create(recursive: true);
    return dirPath;
  }

  Future<Directory?> _getDirectory() async {
    return await getTemporaryDirectory();
  }

  Future<Directory?> _getDirectoryVideo() async {
    return await _getDirectoryByFolderName(video);
  }

  Future<Directory?> _getDirectoryPhoto() async {
    return await _getDirectoryByFolderName(photo);
  }

  Future<Directory?> _getDirectoryByFolderName(String foldername) async {
    final Directory? extDir = await _getDirectory();
    final String dirPath = '${extDir!.path}/$foldername';
    return await Directory(dirPath).create(recursive: true);
  }

  Future<String?> copyVideoFromCacheToDestinationDirectory(
      XFile sourceFile) async {
    try {
      final String dirPath = await _createDirPathIfNotExist(video);
      final String filePath = '$dirPath/${_timestamp()}.mp4';

      File imageFile = File(sourceFile.path);

      await imageFile.copy(
        filePath,
      );
      return filePath;
    } catch (e) {
      return null;
    }
  }
}
