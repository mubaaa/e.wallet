import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyColor {
  
  Color primaryDark = Colors.black;
  Color primaryWhite = Colors.white;

  Color containerDark = HexColor("20202B");
  Color containerLight = Colors.red;

  Color BgColorLight=Colors.black;
  Color BgColorDark=Colors.white;

}
MyColor myColor=MyColor();
textStyle(var size){
  return TextStyle(
    color:Colors.white,
    fontSize: size,
  );
}


































// class DarkLightTheme extends StatefulWidget {
//   const DarkLightTheme({ Key? key }) : super(key: key);

//   @override
//   _DarkLightThemeState createState() => _DarkLightThemeState();
// }
// ThemeData darkTheme=ThemeData(
//   brightness: Brightness.dark,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//   ),

//   bottomNavigationBarTheme:const BottomNavigationBarThemeData(
//     backgroundColor: Colors.black
//   ),

//   textTheme:const TextTheme()

// );


// ThemeData lightTheme=ThemeData(
//   brightness: Brightness.light,
//   floatingActionButtonTheme: const FloatingActionButtonThemeData(
//   ),


//   bottomNavigationBarTheme:const BottomNavigationBarThemeData(
//     backgroundColor: Colors.green
//   ),

//   textTheme:const TextTheme(

//   )
// );

// bool light=true;

// class _DarkLightThemeState extends State<DarkLightTheme> {
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: light,
//       onChanged: (state){
//         setState(() { 
//           light=state;
//         });   
//       },
//     );
//   }
// }
