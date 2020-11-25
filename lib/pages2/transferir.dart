

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main2.dart';


class Transferir extends StatelessWidget {
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
          title: Text("Transferir", style: TextStyle(color: Colors.white,
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
                    margin: EdgeInsets.only(bottom: 20),
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
                          labelText: '   Contacto',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: Color(0xffaab3d0),
                          ),

                          suffixIcon: Icon(Icons.search, color: Colors.white,),

                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 35,
                    width: 250,
                    alignment: AlignmentDirectional.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xff2a408a),

                    ),

                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '   Cantidad',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xffaab3d0),
                        ),



                      ),
                        textAlign: TextAlign.center,
                        validator: (valor) =>
                        valor.length < 0 ? 'El codigo no exite' : null,
                        onSaved: (valor) => _email = valor,


                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 60),
                    height: 120,
                    width: 250,
                    alignment: AlignmentDirectional.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xff2a408a),

                    ),

                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '   Mensaje',
                        alignLabelWithHint: true,
                        labelStyle: TextStyle(
                          color: Color(0xffaab3d0),

                        ),



                      ),
                      textAlign: TextAlign.center,
                      validator: (valor) =>
                      valor.length < 0 ? 'El codigo no exite' : null,
                      onSaved: (valor) => _email = valor,


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
                          "TRANSFERIR",
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
            ),
          ),
        ),
      ),
    );
  }
}
