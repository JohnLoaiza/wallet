import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pybus_wallet/pages/generate.dart';
import 'package:pybus_wallet/pages/unlockPagar.dart';
import 'package:pybus_wallet/pages2/comprar.dart';
import 'package:pybus_wallet/pages2/recargar.dart';

import 'package:flutter/cupertino.dart';

import 'main2.dart';

class Activar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Activar> {
  Color _colorbase = Color(0xFF011C74);

  int _saldo = 10;
  int _dia = 27;
  int _mes = 11;
  int _a = 2020;
  int _tiquetes = 1;
  int _valor = 600;
  int _valorpar = 1200;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(0xffffffff),
            leading: Builder(
              builder: (BuildContext context){
                return IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xFF011C74),), onPressed: () {
                  Navigator.of(context).push(
                      new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                          new HomeApp()));
                },);
              },
            ),
            actions: <Widget>[
              Container(
                width: 40,

                child: RaisedButton(
                  child: Icon(Icons.notifications_active, size: 20,),
                  color: Colors.white,
                  onPressed: () {

                  },

                ),
              ),
              Container(
                width: 40,

                child: RaisedButton(
                  child: Icon(Icons.add_shopping_cart, size: 20, ),
                  color: Colors.white,
                  onPressed: () {

                  },

                ),
              ),
              Container(
                width: 80,

                child: RaisedButton.icon(
                  icon: Icon(Icons.attach_money, size: 15, color: Color(0xff25AA0D),),
                color: Colors.white,
                onPressed: () {

                },
                  label: Text("$_saldo", style: TextStyle(color: Color(0xff25AA0D),),),
              ),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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

          body: Column(
          children: <Widget>[

            Row(
              children: <Widget>[
              Container(
                color: Colors.white,
                width: 93,
                height: 140,
                child: Image.asset('assets/images/ticket.png', ),
              ),
                Column(
                  children: <Widget>[
                    Text("Tiquete único",  style: TextStyle(fontSize: 18,color: Colors.black),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$_a/$_mes/$_dia", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),
                    Text("   Tiquete con unico viaje.", style: TextStyle(fontSize: 12,color: Color(0xff878787)), ),
                    Text("Cantidad: $_tiquetes", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money, color: Color(0xff25AA0D), size: 18,),
                        Text("$_valor", style: TextStyle(color:  Color(0xff25AA0D)),)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Container(
                    height: 20,
                  width: 68,
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                   //   Navigator.of(context).push(MaterialPageRoute(
                    //      builder: (BuildContext context) => GenerateScreen()));

                      Navigator.of(context).push(MaterialPageRoute(
                               builder: (BuildContext context) => UnlockScreen()));
                    },
                    child: Text("USAR", style: TextStyle(color: Color(0xffD40A54)),),
                  ),
                ),
                )
              ],
            ),
            Container(
              height: 2,
              color: Color(0xffE3E3E3),
            ),
            Row(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: 93,
                  height: 140,
                  child: Image.asset('assets/images/tickets.png', ),
                ),
                Column(
                  children: <Widget>[
                    Text("Tiquete par",  style: TextStyle(fontSize: 18,color: Colors.black),),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$_a/$_mes/$_dia", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),
                    Text("   Tiquete con viaje par.", style: TextStyle(fontSize: 12,color: Color(0xff878787)), ),
                    Text("Cantidad: $_tiquetes", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),
                    Row(
                      children: <Widget>[
                        Icon(Icons.attach_money, color: Color(0xff25AA0D), size: 18,),
                        Text("$_valorpar", style: TextStyle(color:  Color(0xff25AA0D)),)
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Center(
                  child: Container(
                    height: 20,
                    width: 68,
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {

                      },
                      child: Text("USAR", style: TextStyle(color: Color(0xffD40A54)),),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              height: 35,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(7)
              ),
              child: RaisedButton(


                onPressed: () {
                  Navigator.of(context).push(
                      new CupertinoPageRoute(
                          builder: (BuildContext context) =>
                          new Comprar()));
                },
                color: Color(0xff011C74),
                child: Container(
                  padding: EdgeInsets.only(top: 9),
                  decoration: BoxDecoration(
                    color: Color(0xff011C74),
                  ),
                  width: 204,
                  height: 44,
                  child: Text(
                    "Comprar",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
          ),

        )
    );
  }
}



