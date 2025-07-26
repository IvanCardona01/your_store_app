import 'package:drift/drift.dart';
import 'categories.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  RealColumn get salePrice => real().nullable()();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  TextColumn get sku => text().unique()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get brand => text().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get dimensions => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isFeatured => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}