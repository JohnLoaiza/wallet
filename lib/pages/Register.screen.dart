import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pybus_wallet/data/shared_preferences_helper.dart';
import 'package:pybus_wallet/data/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'Login.screen.dart';


class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool estaLogeado=false;
  String codeCountry="+57";
  TextEditingController emai = new TextEditingController();
  TextEditingController passwor = new TextEditingController();
  //TextEditingController tele = new TextEditingController(text: "3015847496");

  TextEditingController userNam = new TextEditingController();
  TextEditingController Nombre = new TextEditingController();
  TextEditingController smsCntrl = new TextEditingController();
  bool yaFuturo = false;
  SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();
  Hash hasher;
  String uniqueId = "Unknown";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String _message = '';
  String miTelefo="";

  String _code;
  bool isValidating =false;


  Future getUserID() async{
   // initPlatformState();
    estaLogeado     = await shareHelper.isRegisterIN();
    String miTelefon=await shareHelper.MiTelefono();
    if(estaLogeado!=null){}else{estaLogeado=false;}
      if(estaLogeado){


        setState(() {

          Navigator.of(context).pushAndRemoveUntil(new CupertinoPageRoute(
              builder: (BuildContext context) =>
              new LoginScreen()),(Route<dynamic> route) => false);
          // Navigator.pop(context);
        });

      }else{

        setState(() {
          miTelefo=miTelefon;
        });
      }


  }
  String _identifier="";


  Future<void> initUniqueIdentifierState() async {
    String identifier="";


    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  Future Registrar() async{


    //String miTelefos=await shareHelper.MiTelefono();
    String miTokenF=await shareHelper.MiTokenFirebase();

    user=await _auth.currentUser();

    try {
        // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
        //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
        uniqueId=user.uid;


     // uniqueId = await ImeiPlugin.getId();
    } on PlatformException {
     // platformImei = 'Failed to get platform version.';
    }
    //_identifier = await UniqueIdentifier.serial;
    String email=emai.text;
    String pass=passwor.text;
    var bytes = utf8.encode(pass); // data being hashed

    var digest = sha1.convert(bytes);
var passSh=sha1.convert(utf8.encode(digest.toString()));
   // var passSha=await hasher.bind(pass).first;
    print("passSHa1"+passSh.toString());
    //String telefo=tele.text;
    String pss3=passSh.toString();
    String userNams=userNam.text;
    final response = await http.post(URI_BASE +"/registroP",body:{
      "username":"$userNams","name":"$email",
      "password":"$pss3","email":"$email",
      "telefono":"$miTelefo","imei":"$uniqueId",
      "miTelefo":"$miTelefo","miTokenF":"$miTokenF"});

    print(response.body);
    var jsonRespon=json.decode(response.body);
var success=jsonRespon['success'];
if(success){
  setState(() {
    shareHelper.setRegisterIn(true);
    shareHelper.setLoggedInValid(false);
    Navigator.pushNamed(context, '/home');
  });
  //Navigator.pushNamed(context, '/home');
}else{

  _showDialog(jsonRespon['msg']);

}


  }
  void _showDialog(String msgg) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("No ha sido posible realizar el registro. por favor verifique la información\n $msgg"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
void initState() {

   // initUniqueIdentifierState();
    getUserID();

hasher = sha1;

   // _scafol= Scaffold.of(context);
  super.initState();

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body:Container(
        child:

        Flex(
          direction: Axis.vertical,
          children: [
      Expanded(
      child:
          Column(

            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 36.0)),
                      Container(
                        padding: EdgeInsets.only(left: 70, right: 70),
                        child: Image.asset('assets/images/paybus.png', ),),
                      Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                      
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff011c74),
                ),
                
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                        'REGISTRARSE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'
                        ),
                      ),
                   /*   Text(
                        '$miTelefo',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.0,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                */
                    TextField(
                      controller: Nombre,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)
                            ),
                            borderSide: BorderSide(
                              color: Colors.red,
                              // style: BorderStyle.solid
                            )
                        ),
                        hintText: 'Nombres completo',
                        hintStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontFamily: 'Montserrat'

                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    TextField(
                      controller: userNam,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0)
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                            // style: BorderStyle.solid 
                          )
                        ),
                        hintText: 'Usuario',
                        hintStyle: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          fontFamily: 'Montserrat'

                        ),
                        filled: true,
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    TextField(
                      controller: emai,
                      decoration: InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0)
                          )
                        ),
                        filled: true,
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          fontFamily: 'Montserrat'
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.mail_outline)
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    TextField(
                      controller: passwor,
                      decoration: InputDecoration(
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Montserrat'
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.lock_outline)
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                     Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    TextField(
                      controller: passwor,
                      decoration: InputDecoration(
                          hintText: 'Confirmar contraseña',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Montserrat'
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(Icons.lock_outline)
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                    height: 50,
                    width: 152,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xff2a408a),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          )),
                      child: DropdownButton(
                        
                        items: ['18', '19', '20', '21', '22', '23', '24', 'Item2', 'Item3'
                        , 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3'
                        , 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3'
                        , 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3', 'Item2', 'Item3']
                            .map((String a) {
                          return DropdownMenuItem(
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        onChanged: (_) {},
                        hint: Text(
                          "Edad",
                          style: TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 14),
                        ),
                      )),

                      Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                

                      Container(
                        width: 160,
                        child: TextField(
                      controller: passwor,
                      decoration: InputDecoration(
                          hintText: 'Telefono',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Montserrat'
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16.0),
                          
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                      )
                      
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),

                    Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                        ),
                        
                        child: SizedBox(
                          height: 20,
                          width: 20,
                        ),
                      ),
                     
                     Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),

                     Text(" Acepto terminos y condiciones", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat', ),)
                    ],
                    ),
                    

                    Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                    Container(
                      width: 290.0,
                      height: 43.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          stops: [0.1, 0.9],
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Color(0xffd40a54),
                            Color(0xffd90a35),
                          ],
                        ),
                      ),
                      child: FlatButton(
                        child: Text(
                          'REGISTRARME',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textColor: Colors.white,
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                        ),
                        onPressed: () {
                         // _verifyPhoneNumber(context);
                          Registrar();
                         // Navigator.pushNamed(context, '/home');
                        },
                      ),
                    ),
                   

Container(child: Text(_message),),
                    

                  ],
                ),
              )
            ],
          ),
      )
          ]
    )

      )

    );

  }


  void cargaCountry(CountryCode valor){
    codeCountry=valor.dialCode;

  }





}