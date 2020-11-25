
import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pybus_wallet/data/values.dart';
import 'package:pybus_wallet/pages2/promptpay.dart';
import 'package:pybus_wallet/pages2/recargar.dart';
import 'package:pybus_wallet/pages2/tucuenta.dart';
import 'home.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;



class MainApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeApp()

    );
  }
}



class HomeApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<HomeApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Color _colorbase =  Color(0xFF011C74);
  int _currentIndex = 0;
  //var _saldo = 10;
  final List<Widget> _children = [
    Home1(),
    Home1(),
    Home1(),
    Home1(),

  ];


  String mySaldo='0';

  var time;


  Future<void> getTransas()async {
    String uniqueId;


    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      if(user!=null) {
        uniqueId = user.uid;
      }else{
        user=await _auth.currentUser();
        uniqueId = user.uid;
      }
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    print(uniqueId);
    final response = await http.post(
        URL_Server + "android_connect/get_all_transa.php",
        body: {"id": "$uniqueId"});
    var jsonRespond = json.decode(response.body);

    setState(() {
      mySaldo = jsonRespond[1][0]['Points'].toString()+" COP";
    });

  }
  static const timeout = const Duration(seconds: 15);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer.periodic(duration, handleTimeout);
  }


  void handleTimeout(Timer timef){

    getTransas();

    debugPrint(timef.tick.toString());
    print("Se inicia el getData Updates... "+user.uid);
    //time.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
             
            backgroundColor: Color(0xffd52f54),
            onPressed: () {
              Navigator.of(context).push(
                  new CupertinoPageRoute(
                      builder: (BuildContext context) =>
                      new Recargar()));
            },
            child: Icon(Icons.monetization_on),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(icon: Icon(Icons.menu, color: _colorbase,), onPressed: () {
                  Navigator.of(context).push(
                      new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                          new MenuDrawler()));
                },);
              },
            ),
            actions: <Widget>[
              RaisedButton(

                onPressed: () {
                  Navigator.of(context).push(
                      new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                          new GenerateScreenPromp()));

                },
                color: Colors.white,
                child: Icon(Icons.notifications, color: _colorbase,),
              )
            ],
          ),
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            fixedColor: _colorbase,
            items: <BottomNavigationBarItem>[

              BottomNavigationBarItem(

                backgroundColor: _colorbase,
                icon: Icon(Icons.attach_money, color: Colors.white, size: 10,),
                title: Text('$mySaldo', style: TextStyle(color: Colors.white, fontSize: 20),),

              ),
              BottomNavigationBarItem(
                backgroundColor: _colorbase,
                icon: Icon(Icons.add_shopping_cart, color: _colorbase, size: 30,),
                title: Text('', style: TextStyle(color: _colorbase, fontSize: 1)),
              ),
              BottomNavigationBarItem(
                backgroundColor: _colorbase,
                icon: Icon(Icons.add_shopping_cart, color: _colorbase, size: 30,),
                title: Text('', style: TextStyle(color: _colorbase, fontSize: 1)),
              ),
              BottomNavigationBarItem(
                backgroundColor: _colorbase,
                icon: Icon(Icons.add_shopping_cart, color: Colors.white, size: 25,),
                title: Text('', style: TextStyle(color: Colors.white, fontSize: 0.1)),
              ),

            ],
          ),
        )
    );
  }
  void onTabTapped(int index) {
    setState(()  {
      _currentIndex = index;
    });
  }


  @override
  Future<void> initState()  {
    time = startTimeout(15000);
    cargarUID();
    getTransas();

  }

  Future<void> cargarUID() async{
    user=await _auth.currentUser();
  }

  @override
  void dispose(){
    try {
      time.cancel();
    }catch(erfd){print("Error Dispose***  ");}
    super.dispose();
  }
}

class MenuDrawler extends StatefulWidget {

  _MenuDrawlerState createState() => new _MenuDrawlerState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;

class _MenuDrawlerState extends State<MenuDrawler> {

  String myUsernam="";
  @override
  void initState(){
    getMy();
    getTransas();
    super.initState();
  }

  Future<void> getTransas()async {
    String uniqueId;
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    print(uniqueId);
    final response = await http.post(URI_BASE +"/getQRContactoP",body:{"imei":"$uniqueId"});
/*  final response = await http.post(
      URL_Server + "android_connect/get_all_transa.php",
      body: {"id": "$uniqueId"});*/
    print(response.body);
    var jsonRespond = json.decode(response.body);
    print(jsonRespond['data']["Fax"]);

    setState(() {
      myUsernam = jsonRespond['data']['Fullnames']+" ";
    });

  }
  Future <void> getMy()async{
    user=await _auth.currentUser();
  }
  @override
  Widget build(BuildContext context) {
    Color _colorbase =  Color(0xFF011C74);

    return Drawer(



      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: _colorbase,
            ),

            accountName: Text("Usuario:  $myUsernam"),

            accountEmail: Text("E-mail"),
            currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle, color: _colorbase, size: 70,)

            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Tu Cuenta"),
            onTap: () {
              Navigator.of(context).push(
                  new CupertinoPageRoute(
                      builder: (BuildContext context) =>
                      new Tucuenta()));
            } ,
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text("Amigos"),
            onTap: () {

            } ,
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text("Mis cupones y fiados"),
            onTap: () {

            } ,
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Historial"),
            onTap: () {

            } ,
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}


