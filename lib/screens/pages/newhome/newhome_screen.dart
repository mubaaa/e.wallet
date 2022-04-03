import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/costant_widget/basic_wigdet.dart';
import 'package:money_managment/costant_widget/constant_widgets.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/model/category/category_model.dart';
import 'package:money_managment/model/transaction/transaction_model.dart';
import 'package:money_managment/screens/pages/newhome/widget.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);
  
 
  @override
  Widget build(BuildContext context) {  
   TransactionDB.instance.refreshUi();
   categoryDB.instance.refreshUI();
   total();
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Activity Data",
                style: TextStyle(color: HexColor("43A79B"), fontSize: 20),
              ),
             
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          //=================total====================//
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ValueListenableBuilder(
              valueListenable: totalAmountNotifier,
              builder: (ctx,double values,_){
                  return  Container(
                  // height: size.height * 0.3 / 2,
                  width: size.width * 0.6 / 4,
                  decoration: BoxDecoration(
                  color: HexColor("20202B"),
                  borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "Total Balance",
                        style: textStyle(18.0),
                        // TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(  
                        "\u{20B9}${totalAmountNotifier.value}".toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ));
              },
              
            ),
          ),
          const SizedBox(   
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              ValueListenableBuilder(
                valueListenable: incomeNotifier,
                builder: (ctx,double value,_){
                 return HomeWidgets(
                    icon: Icons.arrow_downward,
                    color: Colors.green,
                    text: "inm\n\u{20B9}${incomeNotifier.value}");
                    },
                   ),
              ValueListenableBuilder(
                valueListenable: expenseNotifier,
                builder: (ctx,double value,_){
                  return HomeWidgets(
                    icon: Icons.arrow_downward,
                    color: Colors.red,
                    text: "Exp- \u{20B9}${expenseNotifier.value}");
                },
              ),
              ],
          ),
          const SizedBox(
            height: 15,
          ),

            
          const SizedBox(
            height:30,
          ),
          SizedBox(
            height: 500,
            child:ValueListenableBuilder(
              valueListenable: TransactionDB.instance.TransactionNotifier,
               builder: (ctx,List<TransactionModel>newList,_){
                 return  ListView.separated(
                physics: const ScrollPhysics(),
                itemBuilder: (cnt, index) {
                  final value=newList[index];
                  return Slidable(
                    key: Key(value.id!),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(), 
                      children: [
                        SlidableAction(
                          onPressed: (ctx){
                            TransactionDB.instance.deleteTransaction(value.id!);
                            },
                          icon: Icons.delete,
                          backgroundColor: Colors.black,
                          label: "Delete",
                          foregroundColor: Colors.redAccent,
                          )
                      ]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: HexColor("20202B"),
                      elevation: 0,
                      child: ListTile(
                          leading: Text(
                         value.category.name,
                            style:const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          trailing: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children:  [
                                  Text(
                                    "\u{20B9}${value.amount}",
                                    style: TextStyle( 
                                      color: value.type==CategoryType.income
                                      ?Colors.green
                                      : Colors.red),
                                  ),
                                  Text( 
                                    parsedDate(value.date),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          )),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: newList.length);
               })
          )
        ],
      ),
    );
  }
  String parsedDate(DateTime date){
    return "${date.day}-${date.month}-${date.year}";

}
  
}


// =========dropdown=======//
             
            //       icon: const Icon(Icons.arrow_drop_down),
            //       onChanged: (String? newValue) {
            //         setState(() {
            //           dropdownValue = newValue!;
            //           print(dropdownValue);
            //         });
            //       },
            //       items: <String>[
            //         'All',
            //         'Today',
            //         'Yesterday',
            //         'Monthly',
            //         'Custom'
            //       ].map<DropdownMenuItem<String>>((String value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),
          // Switch(
              //   activeTrackColor: HexColor("43A79B"),
              //   inactiveTrackColor: HexColor("43A79B"),
              //   value:light,
              //   onChanged: (newValue) {
              //     setState(() {
              //       light = newValue;
              //     });
              //   },
              // ),