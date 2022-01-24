import 'dart:io';

//[path] : test/fiture/auth/
//[name] : filename.json
String fixture({required String path, required String name}) =>
    File('$path$name').readAsStringSync();
