import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/db/transaction_db/transaction_db.dart';
import 'package:money_managment/screens/pages/chart_pages/expence_chart.dart';
import 'package:money_managment/screens/pages/chart_pages/income_chart.dart';
import 'overview.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;

  @override
  void initState() {
    _tabcontroller = TabController(length: 3, vsync: this);
    //  categoryDB().refreshUI();
    TransactionDB.instance.refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 30,
            child: Center(
              child: Text(
                "Transactions",
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: TabBar(
              indicator: BoxDecoration(color: HexColor("43A79B")),
              controller: _tabcontroller,
              labelColor: Colors.white,
              unselectedLabelColor: HexColor("43A79B"),
              tabs: const [
                
                Tab(
                  text: "Income",
                ),
                Tab(
                  text: "Expense",
                ),
                Tab(
                  text: "Overall",
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
            controller: _tabcontroller,
            children: [
                IncomeShowChart(),
                ExpenceChart(),
                OverviewChart(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
