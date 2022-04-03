
import 'package:hive_flutter/adapters.dart';
import 'package:money_managment/model/category/category_model.dart';
 part 'transaction_model.g.dart';


@HiveType(typeId: 3)
class TransactionModel {

  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final CategoryType type;

   @HiveField(4)
  final CategoryModel category;

  @HiveField(3)
  final String? notes;
  
  @HiveField(5)
  String? id;

  TransactionModel({
    required this.date,
    required this.amount,
     required this.category,
    required this.type,
     this.notes
     })
   {
     id=DateTime.now().microsecondsSinceEpoch.toString();
   }


}