import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime datetime;
  @HiveField(3)
  final CategoryType type;
  @HiveField(4)
  final CategoryModel categorymodel;
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.purpose,
    required this.amount,
    required this.datetime,
    required this.type,
    required this.categorymodel,
  }) {
     
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  //flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs
}
