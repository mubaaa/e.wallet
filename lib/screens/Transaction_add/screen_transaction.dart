import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/category_db/category_db.dart';
import 'package:money_managment/screens/Transaction_add/expence_Transaction.dart';
import 'package:money_managment/screens/Transaction_add/income_Transaction.dart';


class TransactionScreen extends StatefulWidget {
  static const routName = "Add-Transaction";
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // bool _selection = false;
  // bool income = true;
  // bool expense = false;

  @override
  Widget build(BuildContext context) {
    categoryDB.instance.refreshUI();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Transactions"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TabBar(
            unselectedLabelColor: HexColor("43A79B"),
            indicator: BoxDecoration(
              color: HexColor("43A79B"),
            ),
            labelColor: Colors.white,
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Income",
              ),
              Tab(
                text: "Expense",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [
                  IncomeTransaction(),
                  ExpenseTransaction(),
            ]),
          )
        ],
      ),
    );
  }
}



























// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:money_managment/screens/floating/transaction_expence_add.dart';
// import 'package:money_managment/screens/floating/Transaction_income_add.dart';

// class ScreenFloating extends StatefulWidget {
//   const ScreenFloating({Key? key}) : super(key: key);

//   @override
//   State<ScreenFloating> createState() => _ScreenFloatingState();
// }

// class _ScreenFloatingState extends State<ScreenFloating>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabcontroller;

//   @override
//   void initState() {
//     // TODO: implement initState
//     _tabcontroller = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//            const Center(
//                 child: Text(
//               "Income",
//               style: TextStyle(color: Colors.white, fontSize: 23),
//             )),
//             const SizedBox(
//               height: 10,
//             ),
//             TabBar(
//                 controller: _tabcontroller,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: HexColor("43A79B"),
//                 tabs: const[
//                   Tab(
//                     text: "Income",
//                   ),
//                   Tab(
//                     text: "Expense",
//                   )
//                 ]),
//             Expanded(
//               child: TabBarView(
//                   controller: _tabcontroller,
//                   children: const[
//                      AddIncome(),
//                      AddExpence(),
//                   ]),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
