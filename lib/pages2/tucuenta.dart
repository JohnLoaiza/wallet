import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'main2.dart';


class Tucuenta extends StatelessWidget {
  String _nombre = "José Meza";
  String _edad = "22 años";
  String _email = "Diseño@dobleplues.com";
  String _celular = "323 1234567";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Tu cuenta", style: TextStyle(color: Color(0xff011c74),
            fontSize: 14,
          ),
          ),
          leading: Builder(
            builder: (BuildContext context){
              return IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xff011c74),), onPressed: () {
                Navigator.of(context).push(
                    new CupertinoPageRoute(
                        builder: (BuildContext context) =>
                        new HomeApp()));
              },);
            },
          ),

        ),
        backgroundColor: Colors.white,
        key: new GlobalKey<ScaffoldState>(),
        body: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 20,
          ),
          child: Form(
            key: new GlobalKey<FormState>(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[



                  Row(

                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: 110,
                             padding: EdgeInsets.only(right: 90),
                             child: Icon(Icons.account_circle, color: Colors.black26, size: 90,),
                            decoration: BoxDecoration(
                                color: Colors.white,

                            ),

                          ),

                        ],
                      ),
                      SizedBox(
                        width: 1,
                      ),
                     Column(
                       children: <Widget>[
                      Row(
                         children: <Widget>[
                          Text("$_nombre", style: TextStyle(fontSize: 24, color: Color(0xff011C74)),),
                     SizedBox(
                       width: 20,
                     ),
                     Container(

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(6)
                           ),

                         width: 40,
                           child: RaisedButton(
                             shape: new RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15),),
                             child: Container(
                               padding: EdgeInsets.only(right: 20),
                               child: Icon(Icons.edit, color: Colors.white, ),
                             ),
                             onPressed: () {

                             },
                             color: Color(0xffD40A54),
                           ),
                         ),

                        ]
                      ),
                         Text("$_edad", style: TextStyle(color: Color(0xff666666),),
                         ),
                         SizedBox(
                           height: 4,
                         ),
                         Text("$_email", style: TextStyle(color: Color(0xff666666),),
                         ),
                         SizedBox(
                           height: 4,
                         ),
                         Text("$_celular", style: TextStyle(color: Color(0xff666666),),
                         ),
                         ]
                     )
                    ],
                  ),
                  Row(
                      children: <Widget> [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text("."),
                              height: 1,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Color(0xff999999),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 25),
                              child:   Text("Información bancaria", style: TextStyle(color: Color(0xff011c74,), fontSize: 24),),),
                            Container(
                              padding: EdgeInsets.only(right: 110),
                              margin: EdgeInsets.only(top: 20),
                              height: 38,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: RaisedButton(

                                onPressed: () {

                                },
                                color: Color(0xffd52f54),
                                child: Container(
                                  padding: EdgeInsets.only(top: 13),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd52f54),
                                  ),
                                  width: 116,
                                  height: 44,
                                  child: Text(
                                    "Añadir tarjeta",
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
                      ]
                  ),
                  Row(
                      children: <Widget> [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text("."),
                              height: 1,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Color(0xff999999),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 150),
                              child:   Text("Seguridad", style: TextStyle(color: Color(0xff011c74,), fontSize: 24),),),
                            Container(
                              padding: EdgeInsets.only(right: 110),
                              margin: EdgeInsets.only(top: 20),
                              height: 38,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: RaisedButton(

                                onPressed: () {

                                },
                                color: Color(0xffd52f54),
                                child: Container(
                                  padding: EdgeInsets.only(top: 13),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd52f54),
                                  ),
                                  width: 116,
                                  height: 44,
                                  child: Text(
                                    "Cambiar Clave",
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
                      ]
                  ),
                  Row(
                      children: <Widget> [
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text("."),
                              height: 1,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Color(0xff999999),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                             padding: EdgeInsets.only(right: 150),
                              child:   Text("Identidad", style: TextStyle(color: Color(0xff011c74,), fontSize: 24),),),
                            Container(
                              padding: EdgeInsets.only(right: 110),
                              margin: EdgeInsets.only(top: 20),
                              height: 38,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(7)
                              ),
                              child: RaisedButton(

                                onPressed: () {

                                },
                                color: Color(0xffd52f54),
                                child: Container(
                                  padding: EdgeInsets.only(top: 13),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd52f54),
                                  ),
                                  width: 116,
                                  height: 44,
                                  child: Text(
                                    "Perfil QR",
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
                      ]
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


