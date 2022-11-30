import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

LazyDatabase connect() {
  return LazyDatabase(() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDir.path, 'favorites.db');
    return NativeDatabase.createInBackground(File(dbPath));
  });
}
