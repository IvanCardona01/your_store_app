import 'package:drift/drift.dart';
import 'categories.dart';

@DataClassName('Product')
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get category => text().nullable()();
  RealColumn get discountPercentage => real().nullable()();
  RealColumn get price => real()();
  RealColumn get rating => real().nullable()();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  TextColumn get sku => text().unique()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get warrantyInformation => text().nullable()();
  TextColumn get shippingInformation => text().nullable()();
  TextColumn get availabilityStatus => text().nullable()();
  TextColumn get returnPolicy => text().nullable()();
  TextColumn get images => text().nullable()();
  TextColumn get thumbnail => text().nullable()();
}