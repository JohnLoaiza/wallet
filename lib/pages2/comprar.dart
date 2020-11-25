import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pybus_wallet/pages2/activar.dart';
import 'package:pybus_wallet/pages2/recargar.dart';

import 'package:flutter/cupertino.dart';

import 'main2.dart';

class Comprar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Comprar> {
  Color _colorbase = Color(0xFF011C74);

  int _saldo = 10;

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
                      Text("   Tiquete con unico viaje", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),

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
                     child: Column(
                       children: <Widget>[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Icon(Icons.attach_money, color: Color(0xff25AA0D),),
                             Text("$_valor", style: TextStyle(color: Color(0xff25AA0D)),)
                           ],
                         ),
                         SizedBox(
                           height: 35,
                         ),
                         Container(

                         margin: EdgeInsets.only(left: 25),
                           width: 50,


                             child: RaisedButton(
                               color: Color(0xff25AA0D),
                               child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                               onPressed: () {

                               },
                             ),
                         )
                       ],
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
                      Text("  Tiquete con viaje doble", style: TextStyle(fontSize: 12,color: Color(0xff878787)),),

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
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.attach_money, color: Color(0xff25AA0D),),
                              Text("$_valorpar", style: TextStyle(color: Color(0xff25AA0D)),)
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Container(
                          
                            margin: EdgeInsets.only(left: 25),
                            width: 50,


                            child: RaisedButton(
                              color: Color(0xff25AA0D),
                              child: Icon(Icons.add_shopping_cart, color: Colors.white,),
                              onPressed: () {

                              },
                            ),
                          )
                        ],
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
                            new Activar()));
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
                      "Activar",
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



