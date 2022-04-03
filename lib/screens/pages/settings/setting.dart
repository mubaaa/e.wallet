import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:money_managment/costant_widget/basic_wigdet.dart';
import 'package:money_managment/screens/pages/settings/showabout.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(title:const Text("Settings"),
      centerTitle: true,
      backgroundColor: Colors.black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                Container(
                    width: 400,
                    color: HexColor("20202B"),
                    child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Notification",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Switch(
                              value: _isSwitched,
                              onChanged: (newValue) {
                                setState(() {
                                  _isSwitched = newValue;
                                });
                              },
                              inactiveThumbColor: Colors.blue,
                            ),
                          ],
                        ))),
    
                // SizedBox(height: 15,),
                //   Containe1r(
                //   width: 400,
                //   color: HexColor("20202B"),
                //   child: TextButton(
                //   onPressed: (){},
                //   child:Text("about",style: TextStyle(fontSize: 18,color:Colors.white),))),
                //     SizedBox(height: 15,),
                //   Container(
                //   width: 400,
                //  color: HexColor("20202B"),
                //   child: TextButton(
                //   onPressed: (){},
                //   child:Text("version :1.0.2",style: TextStyle(fontSize: 18,color:Colors.white),))),
                // ContainerBox(
                //   title: "Notification",
                //   onpressed: () {},
                // ),
                sized15,
                ContainerBox(
                  title: "About",
                  onpressed: () {
                    showAboutPopup(context);
                  },
                ),
                sized15,
                const ContainerBox(
                  title: "version :1.0.2",
                  onpressed: null,
                )
              ],
            ),
          )),
    );
  }
}
