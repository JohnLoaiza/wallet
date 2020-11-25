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

class GenerateScreenP extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreenP> {

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
     // uniqueId = await ImeiPlugin.getId();
      setState(() {

        _dataString = ""+uniqueId;
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
      appBar: AppBar(
        title: Text('Recibir transferencia'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: Stack(

         // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  color:  Colors.grey,
                  child:  Column(
                    children: <Widget>[
                    /*  Container(
                        color: Colors.black,
                        height: 60,

                        child: Text(""+_dataString,style:TextStyle(fontSize: 22),),
                      ),*/
                      Expanded(
                        child:  Center(
                          child: Container(
                            key: globalKey,
                            child: QrImage(
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

              ],



      )
    );
  }

  Future<void> _captureAndSharePng() async {
  /*  try {
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
