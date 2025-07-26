import 'package:drift/drift.dart';
import 'carts.dart';
import 'products.dart';

@DataClassName('CartItem')
class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cartId => integer().references(Carts, #id)();
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  DateTimeColumn get addedAt => dateTime().withDefault(currentDateAndTime)();
}