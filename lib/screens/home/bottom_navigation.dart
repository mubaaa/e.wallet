import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/screens/home/screen_home.dart';


class Bottom_navigation extends StatelessWidget {
  const Bottom_navigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const newIndex=0;
  
     final items=[
          const Icon(Icons.home),
          const Icon(Icons.pie_chart),
          const Icon(Icons.format_list_bulleted_outlined),
          const Icon(Icons.settings),
     ];  
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
          index: newIndex,
          onTap: (newIndex){
        ScreenHome.selectedIndexNotifier.value=newIndex; },
            height: 55,
          backgroundColor: Colors.black,
          items: items,
          animationDuration: const Duration(milliseconds: 300),
          ); 
        }
    );
  }
}
       