import 'package:flutter/Material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:pie_chart/pie_chart.dart';

class ContainerBox extends StatelessWidget {
  final title;
  final onpressed;

  const ContainerBox({Key? key, required this.title, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        color: HexColor("20202B"),
        child: TextButton(
          onPressed: onpressed,
          child: Text(title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
        ));
  }
}

const sized15 = SizedBox(
  height: 15,
);

class HomeWidgets extends StatelessWidget {
  final icon;
  final color;
  final text;
  const HomeWidgets(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      decoration: BoxDecoration(
          color: HexColor("20202B"), borderRadius: BorderRadius.circular(18.0)),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}

// //=============piechart=======//

List<dynamic> incomeCategories = [];
List expenseCategories = [];
List incomeCatname = [];
List incomeAmt = [];
List expenseCatname = [];
List expenseAmt = [];

Map<String, double> incAllMap = {};
Map<String, double> expAllMap = {};

incomePieDate() async {
  final _transactionDB = await Hive.openBox<TransactionModel>("TransactionDB");
  incomeCategories.clear();
  expenseCategories.clear();

  List<int> incomeCategorykey = _transactionDB.keys
      .cast<int>()
      .where((Key) => _transactionDB.get(Key)!.type == CategoryType.income)
      .toList();
  for (var i = 0; i < incomeCategorykey.length; i++) {
    final TransactionModel? incomecatgry =
        _transactionDB.get(incomeCategorykey[i]);
    incomeCategories.add(incomecatgry!.category.name);
    incomeCategories.add(incomecatgry.amount);
  }

  List<int> expenseeCategoryKey = _transactionDB.keys
      .cast<int>()
      .where((Key) => _transactionDB.get(Key)!.type == CategoryType.expense)
      .toList();
   for (var i = 0; i < expenseeCategoryKey.length; i++) {
     final TransactionModel? expensecatgry =_transactionDB.get(expenseeCategoryKey[i]);
     expenseCategories.add(expensecatgry!.category.name);
     expenseCategories.add(expensecatgry.amount);
   } 
  
  incomeCatname.clear();
  incomeAmt.clear();
  expenseCatname.clear();
  expenseAmt.clear();


 for (int i = 0; i < incomeCategories.length; i++) {
   if (i%2==0 || i==0) {
     incomeCatname.add(incomeCategories[i]);
   }else{
     incomeAmt.add(incomeCategories[i]);
   }
 } 
 
 for (int i = 0; i < expenseCategories.length; i++) {
   if (i%2==0|| i==0) {
     expenseCatname.add(expenseCategories[i]);
   } else {
     expenseAmt.add(expenseCategories[i]);
   }
 }
incAllMap.clear();
expAllMap.clear();
 
for (int i = 0; i < incomeCatname.length; i++) {
  for (int j =i+1 ; j <incomeAmt.length ;j++) {
    if (incomeCatname[i]==incomeCatname[j]) {
      incomeAmt[i]=incomeAmt[i]+incomeAmt[i];
      incomeAmt[j]=0.0;
      incomeCatname[j]="";
    }
  }
  incomeAmt.removeWhere((iteam) => iteam==0.0);
  incomeCatname.removeWhere((iteam) => iteam=="");
  incAllMap.addAll({incomeCatname[i]:incomeAmt[i]});
 } 

 for (int i = 0; i < expenseCatname.length; i++) {
   for (int j = i+1; j < expenseAmt.length; j++) {
     if (expenseCatname[i]==expenseCatname[j]) {
       expenseAmt[i]=expenseAmt[i]+expenseAmt[j];
       expenseAmt[j]=0.0;
       expenseCatname[j]="";
     }
   }
   expenseAmt.removeWhere((iteam) => iteam==0.0);
   expenseCatname.removeWhere((iteam) => iteam=="");
   expAllMap.addAll({expenseCatname[i]:expenseAmt[i]});
 }

}

// //---by date--//
// incomePieDatebyDate({dat}) async {
//   final _transactionDB = await Hive.openBox<TransactionModel>("TransactionDB");
//   incomeCategories.clear();
//   expenseCategories.clear();

//   List<int> incomeCategorykey = _transactionDB.keys
//       .cast<int>()
//       .where((Key) => 
//       _transactionDB.get(Key)!.type == CategoryType.income &&
//       _transactionDB.get(Key)!.date.day==dat)
//       .toList();
//   for (var i = 0; i < incomeCategorykey.length; i++) {
//     final TransactionModel? incomecatgry =
//         _transactionDB.get(incomeCategorykey[i]);
//     incomeCategories.add(incomecatgry!.category.name);
//     incomeCategories.add(incomecatgry.amount);
//   }

//   List<int> expenseeCategoryKey = _transactionDB.keys
//       .cast<int>()
//       .where((Key) => _transactionDB.get(Key)!.type == CategoryType.expense)
//       .toList();
//    for (var i = 0; i < expenseeCategoryKey.length; i++) {
//      final TransactionModel? expensecatgry =_transactionDB.get(expenseeCategoryKey[i]);
//      expenseCategories.add(expensecatgry!.category.name);
//      expenseCategories.add(expensecatgry.amount);
//    } 
  
//   incomeCatname.clear();
//   incomeAmt.clear();
//   expenseCatname.clear();
//   expenseAmt.clear();


//  for (int i = 0; i < incomeCategories.length; i++) {
//    if (i%2==0 || i==0) {
//      incomeCatname.add(incomeCategories[i]);
//    }else{
//      incomeAmt.add(incomeCategories[i]);
//    }
//  } 
 
//  for (int i = 0; i < expenseCategories.length; i++) {
//    if (i%2==0|| i==0) {
//      expenseCatname.add(expenseCategories[i]);
//    } else {
//      expenseAmt.add(expenseCategories[i]);
//    }
//  }
// incAllMap.clear();
// expAllMap.clear();
 
// for (int i = 0; i < incomeCatname.length; i++) {
//   for (int j =i+1 ; j <incomeAmt.length ;j++) {
//     if (incomeCatname[i]==incomeCatname[j]) {
//       incomeAmt[i]=incomeAmt[i]+incomeAmt[i];
//       incomeAmt[j]=0.0;
//       incomeCatname[j]="";
//     }
//   }
//   incomeAmt.removeWhere((iteam) => iteam==0.0);
//   incomeCatname.removeWhere((iteam) => iteam=="");
//   incAllMap.addAll({incomeCatname[i]:incomeAmt[i]});
//  } 

//  for (int i = 0; i < expenseCatname.length; i++) {
//    for (int j = i+1; j < expenseAmt.length; j++) {
//      if (expenseCatname[i]==expenseCatname[j]) {
//        expenseAmt[i]=expenseAmt[i]+expenseAmt[j];
//        expenseAmt[j]=0.0;
//        expenseCatname[j]="";
//      }
//    }
//    expenseAmt.removeWhere((iteam) => iteam==0.0);
//    expenseCatname.removeWhere((iteam) => iteam=="");
//    expAllMap.addAll({expenseCatname[i]:expenseAmt[i]});
//  }

// }
// //== by monyhly===//
// incomePieDatebyMonthyl({monthly}) async {
//   final _transactionDB = await Hive.openBox<TransactionModel>("TransactionDB");
//   incomeCategories.clear();
//   expenseCategories.clear();

//   List<int> incomeCategorykey = _transactionDB.keys
//       .cast<int>()
//       .where((Key) => 
//       _transactionDB.get(Key)!.type == CategoryType.income &&
//       _transactionDB.get(Key)!.date.month==monthly
//       )
//       .toList();
//   for (var i = 0; i < incomeCategorykey.length; i++) {
//     final TransactionModel? incomecatgry =
//         _transactionDB.get(incomeCategorykey[i]);
//     incomeCategories.add(incomecatgry!.category.name);
//     incomeCategories.add(incomecatgry.amount);
//   }

//   List<int> expenseeCategoryKey = _transactionDB.keys
//       .cast<int>()
//       .where((Key) => _transactionDB.get(Key)!.type == CategoryType.expense)
//       .toList();
//    for (var i = 0; i < expenseeCategoryKey.length; i++) {
//      final TransactionModel? expensecatgry =_transactionDB.get(expenseeCategoryKey[i]);
//      expenseCategories.add(expensecatgry!.category.name);
//      expenseCategories.add(expensecatgry.amount);
//    } 
  
//   incomeCatname.clear();
//   incomeAmt.clear();
//   expenseCatname.clear();
//   expenseAmt.clear();


//  for (int i = 0; i < incomeCategories.length; i++) {
//    if (i%2==0 || i==0) {
//      incomeCatname.add(incomeCategories[i]);
//    }else{
//      incomeAmt.add(incomeCategories[i]);
//    }
//  } 
 
//  for (int i = 0; i < expenseCategories.length; i++) {
//    if (i%2==0|| i==0) {
//      expenseCatname.add(expenseCategories[i]);
//    } else {
//      expenseAmt.add(expenseCategories[i]);
//    }
//  }
// incAllMap.clear();
// expAllMap.clear();
 
// for (int i = 0; i < incomeCatname.length; i++) {
//   for (int j =i+1 ; j <incomeAmt.length ;j++) {
//     if (incomeCatname[i]==incomeCatname[j]) {
//       incomeAmt[i]=incomeAmt[i]+incomeAmt[i];
//       incomeAmt[j]=0.0;
//       incomeCatname[j]="";
//     }
//   }
//   incomeAmt.removeWhere((iteam) => iteam==0.0);
//   incomeCatname.removeWhere((iteam) => iteam=="");
//   incAllMap.addAll({incomeCatname[i]:incomeAmt[i]});
//  } 

//  for (int i = 0; i < expenseCatname.length; i++) {
//    for (int j = i+1; j < expenseAmt.length; j++) {
//      if (expenseCatname[i]==expenseCatname[j]) {
//        expenseAmt[i]=expenseAmt[i]+expenseAmt[j];
//        expenseAmt[j]=0.0;
//        expenseCatname[j]="";
//      }
//    }
//    expenseAmt.removeWhere((iteam) => iteam==0.0);
//    expenseCatname.removeWhere((iteam) => iteam=="");
//    expAllMap.addAll({expenseCatname[i]:expenseAmt[i]});
//  }

// }
























































