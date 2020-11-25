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
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Bloqueo de Seguridad'),

      ),
      body: Container(
        padding: EdgeInsets.only(top: 36.0),
        /*  decoration: BoxDecoration(
             color: Colors.white
          ) ,*/
      child:
          GestureView(
            immediatelyClear: false,
            size: MediaQuery.of(context).size.width,
            onPanUp: (List<int> items) {
              setState(() {
                result = items;
              });
            },
          ),
      )



    );
  }




}
