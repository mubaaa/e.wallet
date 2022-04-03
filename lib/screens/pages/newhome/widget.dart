import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';

ValueNotifier<double> incomeNotifier = ValueNotifier(0);
ValueNotifier<double> expenseNotifier = ValueNotifier(0);
ValueNotifier<double> totalAmountNotifier = ValueNotifier(0);

total() async {
  final _transactionDB = await Hive.openBox<TransactionModel>("TransactionDB");
  double totalIncomeAmount= 0;
  double totalExpenseAmount= 0;

  // income
  List<int> incomecategoryKey = _transactionDB.keys
      .cast<int>()
      .where((Key) => _transactionDB.get(Key)!.type == CategoryType.income)
      .toList();

  for (var i = 0; i < incomecategoryKey.length; i++) {
    final TransactionModel? incomeTransaction =
           _transactionDB.get(incomecategoryKey[i]);
    totalIncomeAmount=totalIncomeAmount+ incomeTransaction!.amount;
  }
  incomeNotifier.value=0;
  incomeNotifier.value = totalIncomeAmount;
  incomeNotifier.notifyListeners();

  // expense
  List<int> expensecategoryKey = _transactionDB.keys
      .cast<int>()
      .where((Key) => _transactionDB.get(Key)!.type == CategoryType.expense)
      .toList();

  for (var i = 0; i < expensecategoryKey.length; i++) {
    final TransactionModel? expenseTransaction =
        _transactionDB.get(expensecategoryKey[i]);
    totalExpenseAmount = totalExpenseAmount + expenseTransaction!.amount;
  }

expenseNotifier.value = 0;
expenseNotifier.value = totalIncomeAmount;
expenseNotifier.notifyListeners();

totalAmountNotifier.value=0;
totalAmountNotifier.value= totalIncomeAmount-totalExpenseAmount;
totalAmountNotifier.notifyListeners();
}
