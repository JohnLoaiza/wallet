import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
/*import 'package:path_provider/path_provider.dart';*/

import 'package:pybus_wallet/utils/screen_size.dart';

class GenerateScreenV extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => GenerateScreenVState();
}

class GenerateScreenVState extends State<GenerateScreenV> {

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  GlobalKey globalKey2 = new GlobalKey();
  GlobalKey globalKey3 = new GlobalKey();
  GlobalKey globalKey4 = new GlobalKey();
  GlobalKey globalKey5 = new GlobalKey();
  GlobalKey globalKey6 = new GlobalKey();
  GlobalKey globalKey7 = new GlobalKey();
  GlobalKey globalKey8 = new GlobalKey();
  GlobalKey globalKey9 = new GlobalKey();
  String _dataString = "novalido";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        appBar: AppBar(
          title: Text('Canjear Ticket'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _captureAndSharePng,
            )
          ],
        ),
        body: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(30),
              sliver: SliverGrid.count(
                crossAxisSpacing: 4,
                mainAxisSpacing: 3,
                crossAxisCount: 3,
                children: <Widget>[
                  _containerQR(bodyHeight,globalKey),
                  _containerQR(bodyHeight, globalKey2),
                  _containerQR(bodyHeight,globalKey3),
                  _containerQR(bodyHeight,globalKey4),
                  _containerQR(bodyHeight,globalKey5),
                  _containerQR(bodyHeight,globalKey6),
                  _containerQR(bodyHeight,globalKey7),
                  _containerQR(bodyHeight,globalKey8),
                  _containerQR(bodyHeight,globalKey9),

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

  _containerQR(bodyHeight,globalKeys){

    return Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[

          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKeys,
                child: QrImage(
                  data: _dataString,
                  size: 0.2 * bodyHeight,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
