import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_tracker_get_cli/app/data/models/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final CategoryType type;
  @HiveField(2)
  CategoryModel category;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final String remarks;
  @HiveField(5)
  String id;
  @HiveField(6)
  String? image;
  TransactionModel(
      {required this.date,
      required this.type,
      required this.category,
      required this.amount,
      required this.remarks,
      required this.id,
      this.image});
}
