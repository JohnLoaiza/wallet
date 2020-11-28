import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
/*import 'package:path_provider/path_provider.dart';*/

import 'package:pybus_wallet/utils/screen_size.dart';

class UnlockScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => UnlockScreenState();
}

class UnlockScreenState extends State<UnlockScreen> {



 // GlobalKey globalKey = new GlobalKey();

  String _dataString = "valido";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();
  List<int> result = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xff7d7d7d),
      body: Center(


        /*  decoration: BoxDecoration(
             color: Colors.white
          ) ,*/
      child: Container(
        margin: EdgeInsets.only(top: 70, bottom: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff011c74),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("PAYBUS", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat', ),),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff011c74),

              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
              Text("Ingrese su patrón de seguridad", style: TextStyle(color: Color(0xff707070), fontFamily: 'Montserrat',),),
              GestureView(

                lineWidth: 17,
                ringWidth: 3,
                circleRadius: 0,
              selectColor: Color(0xffd52f54),
              unSelectColor: Color(0xff011c74),
              immediatelyClear: false,
              size: MediaQuery.of(context).size.width,
              onPanUp: (List<int> items) {
                setState(() {
                  result = items;
                });
              },
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
                          "CANCELAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
  ]
            )
            )
          ],
        )
      )



    )
    );
  }




}
