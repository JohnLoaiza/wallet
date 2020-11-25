import 'package:flutter/material.dart';
import 'package:pybus_wallet/Home_page.dart';
import 'package:pybus_wallet/OnBoarding_page.dart';
import 'package:pybus_wallet/pages/validaPhone.dart';

import 'package:pybus_wallet/pages2/main2.dart';
import 'data/shared_preferences_helper.dart';
import 'pages/Register.screen.dart';
import 'pages/Login.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyApp> {

  bool isRegisterIN=false;
  SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();
  @override
  Future<void> initState(){

    GetDataPrev();
    super.initState();
  }

  Future GetDataPrev() async{
    isRegisterIN=await shareHelper.isRegisterIN();
    setState(() {

      if(isRegisterIN!=null){}else{isRegisterIN=false;}
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Wallet',
      theme: ThemeData(
        primaryColor: Colors.white,
        bottomAppBarColor: Colors.black,
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
        brightness: Brightness.dark,
        hintColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: isRegisterIN?HomeApp():OnBoardingScreen(),
      routes: {
       '/mainPage': (context) => validaPhone(),
        '/registro': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeApp()
      },
    );
  }


}
