import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/costant_widget/Basic_wigdet.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:money_managment/screens/pages/newhome/widget.dart';

class IncomeTransaction extends StatefulWidget {
  const IncomeTransaction({Key? key}) : super(key: key);

  @override
  _IncomeTransactionState createState() => _IncomeTransactionState();
}

class _IncomeTransactionState extends State<IncomeTransaction> {
  DateTime? _selectedDate;
  CategoryModel? _selectedcategorymodel;
  CategoryType? _selectedcategorytype;
 
  String? _categoryID;

  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    _selectedcategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
             Container(
                color: HexColor("20202B"),
                child: TextButton(
                    onPressed: () async {
                      final _selectedDateTemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now());
                      if (_selectedDateTemp == null) {
                        return;
                      } else {
                        print(_selectedDateTemp);
                        setState(() {
                          _selectedDate = _selectedDateTemp;
                        });
                      }
                    },
                    child: Text(
                      _selectedDate == null
                          ? "date"
                          : _selectedDate!.toString(),
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ))),
            // Container(
            //     color: HexColor("20202B"),
            //     child: TextButton(
            //         onPressed: () async {
            //           final _selecetedDateTemp = await showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate:
            //                   DateTime.now().subtract(const Duration(days: 50)),
            //               lastDate: DateTime.now());
            //           if (_selecetedDateTemp == null) {
            //             return;
            //           } else {
            //             print(_selecetedDateTemp.toString());
            //             setState(() {
            //               _selectedDate = _selecetedDateTemp;
            //             });
            //           }
            //         },
            //         child: const Text(
            //           "Date",
            //           style: TextStyle(color: Colors.grey, fontSize: 18),
            //         ))),
            const SizedBox(
              height: 25,
            ),
            Container(
              color: HexColor("20202B"),
              child: TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 20, bottom: 11, top: 11, right: 15),
                    label: Text(
                      "Amount",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    )),
              ),
            ),
            const SizedBox(height: 35),
            //======DROPDOWN==//
            Container(
              color: HexColor("20202B"),
              child: DropdownButton<String>(
                dropdownColor: HexColor("20202B"),
                style: const TextStyle(color: Colors.grey, fontSize: 18),
                hint: const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Selecet Category",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                icon: const Icon(Icons.arrow_drop_down),
                value: _categoryID,
                items: categoryDB().incomeCategoryList.value.map((e) {
                  return DropdownMenuItem(
                    value: e.id, 
                    child: Text(e.name),
                    onTap:(){
                      print(e.toString());
                       _selectedcategorymodel=e;
                    },);
                }).toList(),
                onChanged: (newValue) {
                  print(newValue);
                  setState(() {
                    _categoryID=newValue;
                  });
                },
              ),
            ),
            const SizedBox(height: 35),
            Container(
              height: 130,
              color: HexColor("20202B"),
              child: TextFormField(
                controller: _noteController,
                keyboardType: TextInputType.name,
                cursorColor: Colors.grey,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 20, bottom: 11, top: 11, right: 15),
                    label: Text(
                      "Transaction note",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    )),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                style:
                    TextButton.styleFrom(backgroundColor: HexColor("43A79B")),
                onPressed: () {
                  addTransaction();
                },
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _amount = _amountController.text;
    final _note = _noteController.text;

    if (_amount.isEmpty) {
      return;
     }
    if (_note.isEmpty) {
      return;

    } if(_selectedcategorymodel==null) {
      return;
    }
   final _parsedAmount= double.tryParse(_amount);
   if (_parsedAmount==null) {
     return;
   }
   if(_selectedDate==null){
     return;
   }
   
   if(_selectedcategorytype==null){
     return;
   }

  final transaction=  TransactionModel(
    date: _selectedDate!,
    amount: _parsedAmount, 
    category: _selectedcategorymodel!,
    type: _selectedcategorytype!,
    notes:_note,
    );
   await TransactionDB.instance.insertTransaction(transaction);
   await total();
  
   Navigator.of(context).pop();
   TransactionDB.instance.refreshUi();
  }
  
}

class card extends StatelessWidget {
  final ShapeBorder? shape;
  final Color? color;
  const card({
    Key? key,
    this.shape,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: shape,
      color: color,
    );
  }
}

























// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:money_managment/screens/floating/screen.dart';

// class AddIncome extends StatelessWidget {
//   const AddIncome({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:  ListView.separated(
//             physics: ScrollPhysics(),
//             itemBuilder: (cnt, index) {
//               return Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 color: HexColor("20202B"),
//                 elevation: 0,
//                 child: ListTile(
//                     leading: const Text(
//                       "Travel",
//                       style: TextStyle(color: Colors.white, fontSize: 20),
//                     ),
//                     trailing: Wrap(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: const [
//                             Text("\u{20B9}2500"),
//                             Text(
//                               "Dec-12,2021",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         )
//                       ],
//                     )),
//               );
//             },
//             separatorBuilder: (ctx, index) {
//               return const SizedBox(
//                 height: 10,
//               );
//             },
//             itemCount: 5),
//             // floatingActionButton: FloatingActionButton(
//             //     backgroundColor: Colors.grey.withOpacity(0.8) ,
//             //     onPressed: () =>
//             //      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ScreenFloating()))
//             //      ,
//             //     child: const Icon(
//             //       Icons.add,
//             //       color: Colors.white,
//             //     ),
//             //   ),
//             //   floatingActionButtonLocation:
//             //       FloatingActionButtonLocation.centerDocked,
//     );
//   }

