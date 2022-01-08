import 'dart:async';
import 'dart:io';

import 'package:hero/util/filesystem/itgzfile.dart';
import 'package:path_provider/path_provider.dart';

class TgzFile implements ITgzFile {
  // Future<List<FileSystemEntity>> dirContents() async {
  //   final Directory extDir = await getExternalStorageDirectory();
  //   // extDir.deleteSync(recursive: true);
  //
  //   if (await extDir.exists()) {
  //     Directory dir = Directory('${extDir.path}/video');
  //     if (await dir.exists()) {
  //       var files = <FileSystemEntity>[];
  //       var completer = Completer<List<FileSystemEntity>>();
  //       var lister = dir.list(recursive: false);
  //       lister.listen((file) => files.add(file),
  //           // should also register onError
  //           onDone: () => completer.complete(files));
  //       return completer.future;
  //     } else {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  Future<bool> isPathExist(String path) async {
    try {
      final file = File(path);
      return await file.exists();
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteDirectory() async {
    final Directory? extDir = await getExternalStorageDirectory();
    // extDir.deleteSync(recursive: true);
    try {
      await extDir!.delete();
      return true;
    } catch (e) {
      print("error delete: $e");
      return false;
    }
  }
  //
  // Future<void> deleteFile() async {
  //   try {
  //     var file = File('your_file_path');
  //
  //     if (await file.exists()) {
  //       // file exits, it is safe to call delete on it
  //       await file.delete();
  //     }
  //   } catch (e) {
  //     // error in getting access to the file
  //   }
  // }

  // Future<bool> deleteAllFile() async {
  //   final Directory extDir = await getExternalStorageDirectory();
  //   final String dirPathVideo = '${extDir.path}/video/';
  //   await Directory(dirPathVideo).create(recursive: true);
  //   return true;
  // }
}
