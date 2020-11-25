import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pybus_wallet/data/values.dart';
import 'package:pybus_wallet/pages/generate.dart';
import 'package:pybus_wallet/pages2/activar.dart';
import 'package:pybus_wallet/pages2/contactos.dart';
import 'package:pybus_wallet/pages2/redimir.dart';
import 'package:pybus_wallet/pages2/transferir.dart';
import 'comprar.dart';
class Home1 extends StatefulWidget {
  @override
  _Home1State_nav createState() => _Home1State_nav();
}
class _Home1State_nav extends State<Home1>  {



  @override
  Widget build(BuildContext context) {
    Color _colorbase =  Color(0xFF011C74);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.white,


          body: Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/paybus.png',
                  width: 200,

                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                        margin: EdgeInsets.all(10),
                        width: 95,
                        height: 80,
                        child: Center(
                          child:  RaisedButton(
                            color: Color(0xff65cc78),
                            onPressed: () {

                          /*    Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => GenerateScreen()
                              )); */
                                Navigator.of(context).push(
                              new CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                  new Activar()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.credit_card, size: 40, color: Colors.white,),
                                Text("Activar", style: TextStyle(color: Colors.white,fontSize: 12),)
                              ],
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        )
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        width: 95,
                        height: 80,
                        child: Center(
                          child:  RaisedButton(
                            color: Color(0xffcd3585),
                            onPressed: () {
                              Navigator.of(context).push(
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                      new Comprar()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.directions_bus, size: 40, color: Colors.white,),
                                Text("Comprar", style: TextStyle(color: Colors.white,fontSize: 12),)
                              ],
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        )
                    ),


                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Container(
                        margin: EdgeInsets.all(10),
                        width: 95,
                        height: 80,
                        child: Center(
                          child:  RaisedButton(
                            color: Color(0xffe93c54),
                            onPressed: () {
                              Navigator.of(context).push(
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                      new Redimir()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.loyalty, size: 40, color: Colors.white,),
                                Text("Redimir", style: TextStyle(color: Colors.white,fontSize: 12),)
                              ],
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        )
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        width: 95,
                        height: 80,
                        child: Center(
                          child:  RaisedButton(
                            color: Color(0xff59c0cd),
                            onPressed: () {
                              Navigator.of(context).push(
                                  new CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                      new ContactosPage()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.swap_horiz, size: 40, color: Colors.white,),
                                Text("Transferir", style: TextStyle(color: Colors.white, fontSize: 12),)
                              ],
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        )
                    ),


                  ],
                ),
              ],

            ),
          ),
        )
    );
  }





}


