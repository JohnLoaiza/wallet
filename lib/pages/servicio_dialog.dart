import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pybus_wallet/data/shared_preferences_helper.dart';
import 'package:pybus_wallet/data/values.dart';

import 'dialogo_servicios_handler.dart';

class ServicioDialog extends StatelessWidget {

  DialogoServiciosHandler _listener;
  AnimationController _controller;
  BuildContext contexto;

  String id="";
  String fechaIn="";
  String telefono="";
  String Direccion="";
  String NombreCli="";
  int estado=0;
  String tipo="";
  String success="";
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

String qrTransfe;

  ServicioDialog(this._listener, this._controller);

  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  TextEditingController cantid = new TextEditingController();

  void initState() {

    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  getResponseService(BuildContext context,String qr) {

    GetDetalleService(context,qr);


  }

  void dispose() {
    _controller.dispose();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 200);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(contexto);
  }

  dismissDialog() {
    _controller.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    this.contexto = context;
   /* Future.delayed(Duration(seconds: 40), () {
      dismissDialog();
     // Navigator.of(context).pop(true);
    });*/
    return new Material(
        type: MaterialType.transparency,
        child: new Opacity(
          opacity: 0.99,
          child: new Container(
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 13.0, 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 3.0),
            margin: EdgeInsets.only(bottom: 5),
            decoration:new BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: new BorderRadius.only(topRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: const Color(0xFF000000),
                  offset: Offset(1.0, 6.0),
                  blurRadius: 0.001,
                ),
              ],
            ),
                  child:
                new Text("* Transferir saldo *",style: TextStyle(fontSize: 24,color: Colors.black87,fontWeight: FontWeight.w400),)
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.65,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: <Color>[ //7928D1
                          const Color(0xFFFFFFFF), const Color(0xFFFFFFDD)],
                        stops: <double>[0.1,  0.6],
                        begin: Alignment.topRight, end: Alignment.bottomLeft
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60)
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        _appIcon(),
                        Container(

                          margin: EdgeInsets.only(bottom: 14,top: 20),
                            width:MediaQuery.of(context).size.width*0.98,

                            alignment: Alignment.center,
                            child: SizedBox(
                            width:MediaQuery.of(context).size.width*0.9,
                            height: 80.0,

                            child: AutoSizeText(
                              qrTransfe,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style:TextStyle(fontSize: 19,fontWeight: FontWeight.w300,color: Color(0xFF000000)),

                            ),
                          ),

                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 2,top: 2),
                            width:MediaQuery.of(context).size.width*0.98,

                            alignment: Alignment.center,
                            child: SizedBox(
                                width:MediaQuery.of(context).size.width*0.7,
                                height: 120.0,

                                child:TextField(
                                  controller: cantid,
                                    keyboardType: TextInputType.number,

                                  style: TextStyle(color: Colors.black,fontSize: 24),

                                  decoration: InputDecoration(

                                    border: OutlineInputBorder(

                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)
                                        ),

                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          style: (BorderStyle.none)
                                        )
                                    ),

                                    hintText: '0 COP',
                                    hintStyle: TextStyle(

                                        color: Colors.blue[900],
                                        fontFamily: 'Montserrat'

                                    ),
                                    filled: true,

                                    contentPadding: EdgeInsets.all(16.0),
                                    prefixIcon: Icon(Icons.monetization_on),
                                  ),
                                )


                            )
                        )

                      ]

                  ),
                ),
                new Container(
                 // alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 10.0),
                  child:Row(

                  children:<Widget>[


                new GestureDetector(
                  onTap: () => dismissDialog(),
                  child: roundedButton(
                      "Cancelar",
                      EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                       (Colors.grey),
                      const Color(0xFFFFFFFF)),
                ),

                    new GestureDetector(
                      onTap: () =>AceptarServicio(),
                      child: roundedButton(

                          "Aceptar",
                          EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                          (Colors.green),
                          const Color(0xFFFFFFFF)),
                    ),
                      ]
                )

                )
              ],
            ),
          ),
        ));
  }
  Widget _appIcon() {
    return new Container(
      width: 185,
      height: 178,
      margin: EdgeInsets.only(top: 2, left: 1),
      decoration: new BoxDecoration(

        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.only(topRight: Radius.circular(60),bottomLeft: Radius.circular(60)),
        image:DecorationImage(image: AssetImage("assets/images/onBoarding_2.png")),
          ),

      /*child: new Image(
        image: new AssetImage("images/Banner2.jpg"),
        height: 128.0,
        width: 155.0,

      ),*/

    );
  }
  Widget roundedButton(
      String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(

        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 2.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 18.0, fontWeight: FontWeight.w400),
      ),
    );
    return loginBtn;
  }

  void ConfirmaRecibe(String idServi) async {

    SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();
    String MyUserIDs = await shareHelper.myUserID();

    var pase=MyUserIDs;
    final response = await http.post(URL_Server+"script_2.jsp",body:
    {"placa":"$pase","respuest":"$idServi","tag":"confirma_recibe"});
    log("response ConfirmaRecibe desde navigation..:  ");
    log(response.body);
    // var productos=

    //Map<String,dynamic> jsonRespond=json.decode(response.body);

    //log(jsonRespond.toString());

    try {




    }catch(ersf){
      log("Error getTodoList..");
      log(ersf);
      throw Exception("Error on server");

    }

  }

  void GetDetalleService(BuildContext context,String qr) async {

//setState() {
  qrTransfe = qr;
//}
     this.contexto=context;
    final response = await http.post(URL_Server+"android_connect/DetalleServicio.jsp",body: {"user":"$qr"});


    SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();
    String MyUserIDs = await shareHelper.myUserID();




      if (_controller == null ||
          _drawerDetailsPosition == null ||
          _drawerContentsOpacity == null) {
        return;
      }
      _controller.forward();


      showDialog(
        context: context,
        builder: (BuildContext context) => new SlideTransition(
          position: _drawerDetailsPosition,
          child: new FadeTransition(
            opacity: new ReverseAnimation(_drawerContentsOpacity),
            child: this,
          ),
        ),
      );



  }


  void AceptarServicio() async {
    String uniqueId = "";
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;
      //uniqueId = await ImeiPlugin.getId();
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    String canti = cantid.text;

    if (canti == '') {

    } else{
      SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();

    dismissDialog();
    displayProgressDialog(this.contexto);
    var bodyes={"cantidad": "$canti", "miImei": "$uniqueId", "imei": "$qrTransfe"};
    final response = await http.post(URI_BASE + "/transferirP", body:bodyes
    );
    log("response Transfiere desde dialogo service..:  ");
    log("Bodies:  "+bodyes.toString());
    print(response.body);
    // var productos=
      closeProgressDialog(contexto);
    var jsonRespond = json.decode(response.body);

    //log(jsonRespond.toString());

    try {
     // bool logstatus = ;

      if (jsonRespond['success']) {
        print("Entro al successs...");
        _listener.ShowResult("OK", "");

        //  showSnackBarOK("Servicio aceptado de forma correcta.", scaffoldKey);
      } else {

        print("Entro al BAD...");
        _listener.ShowResult("BAD", "");
        //   showSnackBar("No fue posible aceptar el servicio.", scaffoldKey);
      }


    } catch (ersf) {
      log("Error getTodoList..");
      log(ersf);
      throw Exception("Error on server");
    }
  }
  }

}
