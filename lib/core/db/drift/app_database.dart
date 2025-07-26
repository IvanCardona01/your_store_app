import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:your_store_app/core/config/env.dart';
import 'tables/users.dart';
import 'tables/products.dart';
import 'tables/carts.dart';
import 'tables/cart_items.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  Users,
  Products,
  Carts,
  CartItems,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => Env.dbVersion;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, Env.dbName));
    return NativeDatabase.createInBackground(file);
  });
}