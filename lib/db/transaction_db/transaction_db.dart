import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-database';

abstract class TransactionDbFunction {
  Future<List<TransactionModel>> getTransaction();
  Future<void> insertTransaction(TransactionModel obj);
  Future<void> deleteTransaction(String categoryID);
}

class TransactionDB implements TransactionDbFunction {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> TransactionNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> incomeTransactionNotifier =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseTransactionNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertTransaction(TransactionModel obj) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>("TransactionDB");
    _transactionDB.put(obj.id, obj);
  }

  Future<void> refreshUi() async {
    final _list = await getTransaction();
    _list.sort((first, second) => first.date.compareTo(first.date));
    TransactionNotifier.value.clear();
    incomeTransactionNotifier.value.clear();
    expenseTransactionNotifier.value.clear();


    await Future.forEach(_list, (TransactionModel category) {
      if (category.type == CategoryType.income) {
        incomeTransactionNotifier.value.add(category);
      } else {
        expenseTransactionNotifier.value.add(category);
      }
    });
    TransactionNotifier.value.addAll(_list);

    TransactionNotifier.notifyListeners();
    incomeTransactionNotifier.notifyListeners();
    expenseTransactionNotifier.notifyListeners();
  }
  
  @override
  Future<List<TransactionModel>> getTransaction() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>("TransactionDB");
    return _transactionDB.values.toList();
  }

  @override
  Future<void> deleteTransaction(String categoryID) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>("TransactionDB");
    _transactionDB.delete(categoryID);
  }
}
