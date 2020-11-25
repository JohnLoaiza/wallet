import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main2.dart';



class Recargar extends StatelessWidget {
  Color _colorbase = Color(0xff0066FF);
  String _email;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff011c74),
          title: Text("Recargar", style: TextStyle(color: Colors.white,
            fontSize: 14,
          ),
          ),
          leading: Builder(
            builder: (BuildContext context){
              return IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {
                Navigator.of(context).push(
                    new CupertinoPageRoute(
                        builder: (BuildContext context) =>
                        new HomeApp()));
              },);
            },
          ),

        ),
        backgroundColor: Color(0xff011c74),
        key: new GlobalKey<ScaffoldState>(),
        body: Center(

          child: Form(
            key: new GlobalKey<FormState>(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35,
                    width: 250,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff2a408a),
                          border: Border.all(
                            color: Color(0xffB8D0FF),
                            width: 2,
                          )),
                      child: DropdownButton(
                        items: ['Item1', 'Item2', 'Item3']
                            .map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        hint: Text(
                          "Entidad",
                          style: TextStyle(fontSize: 17, color: Color(0xffaab3d0),),
                        ),
                      )),


                  Container(
                    margin: EdgeInsets.only(bottom: 100, top: 13),
                    height: 35,
                    width: 250,
                    alignment: AlignmentDirectional.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xff2a408a),

                    ),

                    child:
                    TextFormField(

                        textAlign: TextAlign.center,
                        validator: (valor) =>
                        valor.length < 0 ? 'El codigo no exite' : null,
                        onSaved: (valor) => _email = valor,
                        decoration: InputDecoration(

                          labelText: '   Cupon',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: Color(0xffaab3d0),


                          ),

                        )
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: EdgeInsets.all(5),
                    height: 35,
                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: RaisedButton(

                      onPressed: () {

                      },
                      color: Color(0xffd52f54),
                      child: Container(
                        padding: EdgeInsets.only(top: 9),
                        decoration: BoxDecoration(
                          color: Color(0xffd52f54),
                        ),
                        width: 204,
                        height: 44,
                        child: Text(
                          "RECARGAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xff011c74),
                        border: Border.all(
                          color: Color(0xffd52f54),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: RaisedButton(
                      color: Color(0xff011c74),

                      onPressed: () {

                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 9),
                        decoration: BoxDecoration(
                            color: Color(0xff011c74)
                        ),
                        width: 200,
                        height: 40,
                        child: Text(
                          "ESCANEAR QR",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xffd52f54), fontSize: 14, ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
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
