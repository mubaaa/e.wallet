import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/screens/Transaction_add/screen_transaction.dart';
import 'package:money_managment/screens/pages/categories/category_page.dart';
import 'package:money_managment/screens/pages/chart_pages/chartPage.dart';
import 'package:money_managment/screens/pages/newhome/newhome_screen.dart';
import 'package:money_managment/screens/pages/settings/setting.dart';
import 'bottom_navigation.dart';



class ScreenHome extends StatelessWidget {
  ScreenHome({ Key? key }) : super(key: key);

static  ValueNotifier<int> selectedIndexNotifier= ValueNotifier(0); 
  final _pages= [
      NewHomePage(),
    const ChartPage(), 
      CategoryPage(),
    const  SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar:const Bottom_navigation(),
          body:ValueListenableBuilder(
           valueListenable: selectedIndexNotifier,  
           builder:(BuildContext context, int updatedIndex, child) {
             return _pages[updatedIndex];
           },
          ),

        floatingActionButton:  FAB(
          icon: Icons.add,
          color:  Colors.white,
          color1:  HexColor("43A79B"),
          onPressed: (){
            // if (selectedIndexNotifier.value==0) {
                Navigator.of(context).pushNamed(TransactionScreen.routName);
            // } else {
             
              print("add categoris");
            //   final _sample =CategoryModel(
            //   id: DateTime.now().microsecondsSinceEpoch.toString(),
            //    name: 'travel', 
            //    type:CategoryType.income
            //    );
            //    categoryDB().insertCategory(_sample);
             }      
          //},
        ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
      )           
    );
  }

}

class FAB extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final void Function ()? onPressed;
  final Color? color1;
  const FAB({Key? key, this.icon, this.color, this.onPressed,this.color1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){},
       backgroundColor:color1 ,
      child: IconButton(
        icon: Icon(icon,color: color,),
        onPressed: onPressed,
      ),
    );
  }
}



            
