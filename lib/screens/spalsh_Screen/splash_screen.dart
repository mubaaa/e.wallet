import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/screens/home/screen_home.dart';

class SplashScreenhome extends StatefulWidget {
  const SplashScreenhome({ Key? key }) : super(key: key);

  @override
  State<SplashScreenhome> createState() => _SplashScreenhomeState();
}

class _SplashScreenhomeState extends State<SplashScreenhome> {
  @override
  void initState() {
    gotoSplash();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container( 
            decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, HexColor('000000')],
              begin: const FractionalOffset(0.5, 0.8),
              end: const FractionalOffset(0.5, 0.0),
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp
                  ),
                   ),
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            child: Center(child: Text("E.Wallet".toUpperCase(), style: const TextStyle(color:  Colors.white,fontSize: 25),),)
          ),
    );
  }
  Future gotoSplash()async{
  await Future.delayed(const Duration(seconds: 3));
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> ScreenHome()));
  }
}

