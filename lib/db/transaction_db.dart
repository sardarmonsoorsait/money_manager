import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/transaction_model/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transactiondatabase';

abstract class TransactionDBFunctions {
  Future<void> insertTransaction(TransactionModel value);
  Future<List<TransactionModel>> getTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDBFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> modelNotifier = ValueNotifier([]);
  @override
  Future<void> insertTransaction(TransactionModel value) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(value.id, value);
  }

  @override
  Future<List<TransactionModel>> getTransaction() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    updatUI();
  }

  Future updatUI() async {
    final _list = await getTransaction();
    _list.sort((a, b) => b.datetime.compareTo(a.datetime));
    modelNotifier.value.clear();
    modelNotifier.value.addAll(_list);
    modelNotifier.notifyListeners();
  }
}
