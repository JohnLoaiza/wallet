import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
/*import 'package:path_provider/path_provider.dart';*/

import 'package:pybus_wallet/utils/screen_size.dart';

class GenerateScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  String uniqueId;
  Future<void> getTransas()async {
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;
      setState(() {

        _dataString = "valido,$uniqueId";
      });

    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
  }

  @override
  Future<void> initState() {
    getTransas();
  }

  GlobalKey globalKey = new GlobalKey();
  GlobalKey globalKey2 = new GlobalKey();
  GlobalKey globalKey3 = new GlobalKey();
  GlobalKey globalKey4 = new GlobalKey();
  String _dataString ;
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: Column(

          mainAxisAlignment:  MainAxisAlignment.center,
              children: <Widget>[
                Container(
                //  height: 300,
                //  width: 300,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xffd9d9d9),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                      Center(
                        child:  Center(
                          child: RepaintBoundary(
                            key: globalKey,
                            child: QrImage(
                              backgroundColor: Color(0xFFFFFFFF),
                              foregroundColor: Colors.black,
                              data: _dataString!=null?_dataString:'',
                              size: 0.3 * bodyHeight,

                              /* onError: (ex) {
                    print("[QR] ERROR - $ex");
                    setState((){
                      _inputErrorText = "Error! Maybe your input value is too long?";
                    });
                  },*/
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("Tiquete único", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25,),),
                SizedBox(
                  height: 20,
                ),
                Text("Cantidad: 1", style: TextStyle(color: Color(0xff6f6f6f),  fontSize: 20,),),
                SizedBox(
                  height: 30,
                ),
                Text("Por favor acerca este codigo al", style: TextStyle(color: Color(0xff6f6f6f),  fontSize: 20,),),
                Text("validador para disfrutar de su ", style: TextStyle(color: Color(0xff6f6f6f),  fontSize: 20,),),
                Text("beneficio", style: TextStyle(color: Color(0xff6f6f6f),  fontSize: 20,),),
                SizedBox(
                  height: 30,
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
                      width: 220,
                      height: 44,
                      child: Text(
                        "ALMACENAR",
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



      )
    );
  }

  Future<void> _captureAndSharePng() async {
/*    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }*/
  }



}
