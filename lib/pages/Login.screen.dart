import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:flutter/services.dart';
import 'package:pybus_wallet/data/shared_preferences_helper.dart';
import 'package:pybus_wallet/data/values.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _isAuthorized = 'No autorizado';
  bool estaLogeado=false;
  //AppMethods appMethod = new FirebaseMethods();
  bool yaFuturo = false;
  SharedPreferencesHelper shareHelper = new SharedPreferencesHelper();
  BuildContext conte;
  String uniqueId="";
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  Future getUserID() async{

    estaLogeado= await shareHelper.isLoggedIn();
    if(estaLogeado!=null)
      if(estaLogeado && !yaFuturo){
        yaFuturo=true;
        /*     Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new LoginAcopio()));*/
        setState(() {
          Navigator.pushNamed(context, '/home');
         // Navigator.of(context).pushReplacementNamed('/login');
          // Navigator.pop(context);
        });
        /*Navigator.of(context).push(new CupertinoPageRoute(
             builder: (BuildContext context) =>  new LoginAcopio()));*/
      }else{

      }

  }


  @override
  Future<void> initState() {
    getUserID();
    super.initState();

  }

  Future<void> _authorizedNow() async {
    bool isAuthorized = false;
    try {
      isAuthorized = await _localAuthentication.authenticateWithBiometrics(
        stickyAuth: true,
        useErrorDialogs: true,
        localizedReason: 'Escanee su dedo para iniciar sesión',
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: 'Registrarse'
        )
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;
    
    setState(() {
      if (isAuthorized) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
      } else {
        _isAuthorized = 'No autorizado';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    conte=context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 70, right: 70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 36.0)),
                      Image.asset('assets/images/paybus.png'),
                    ],
                  ),
                ),
              ),
              Container(

                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16.0),
                child: Card(
                  color: Color(0xff011c74),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0)
                    )
                  ),
                  elevation: 10.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 8.0)),
                      Center(
                        child: Text(
                          'Ingresar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0)
                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                              )
                            ),
                            hintText: 'Nombre de usuario',
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat', color: Colors.white
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(16.0),
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                            controller: email
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0)
                              )
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat', color: Colors.white
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(16.0),
                            prefixIcon: Icon(Icons.lock_outline)
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                            controller: password
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 28.0)),
                      Container(
                        width: 290.0,
                        height: 43.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.9],
                            colors: [
                              Color(0xffd40a54),
                              Color(0xffd90a35),
                            ],
                          ),
                        ),
                        child: FlatButton(
                          child: Text(
                            'Ingresar',
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

                            verifyLoggin();
                           // Navigator.pushNamed(context, '/home');
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Or',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.fingerprint),
                              onPressed: _authorizedNow,
                              iconSize: 50.0,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('¿No tienes una cuenta?'),
                                  FlatButton(
                                    child: Text('Regístrate ahora'),
                                    onPressed: () {
                                      // Navigator.popAndPushNamed(context, '/mainPage');
                                      Navigator.pushNamedAndRemoveUntil(context, '/mainPage', (Route<dynamic> route) => false);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              height: 45,
                              width: 3000,
                              
                              child:
                            Center(
                         child:     GestureDetector(
                           onTap: (){

                           },
                           child: Text("Terminos y condiciones", style: TextStyle(fontFamily: 'Montserrat', color: Color(0xffd90a35), fontWeight: FontWeight.bold),),
                         )
                            ),
                            )
                          ],

                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ],
      )
    );
  }

  void verifyLoggin() async {


    displayProgressDialog(conte);
    // closeProgressDialog(context);
    // Navigator.of(context).push(new CupertinoPageRoute(
    //   builder: (BuildContext context) =>  new ServicesWidget()));

    // Navigator.of(context).pop(new MaterialPageRoute(builder: (context)=>MyHomePage()));
    //
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;

    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }

    var emai=email.text;
    var pase=password.text;
    var bytes = utf8.encode(pase); // data being hashed

    var digest = sha1.convert(bytes);
    var passSh=sha1.convert(utf8.encode(digest.toString()));

    final response = await http.post(URI_BASE +"/logonP",body:{"user":"$emai","pass":"$passSh","imei":"$uniqueId"});

    print("response login:  ");
    print(response.body);
    var jsonRespon=json.decode(response.body);
    try {

      var prefs = SharedPreferencesHelper();

      closeProgressDialog(context);

      if (jsonRespon['success']) {
        //SharedPreferencesHelper helpe= new SharedPreferencesHelper();
        shareHelper.setLoggedIn(true);
        shareHelper.setUserID(emai);
        shareHelper.setPassW(pase);

        Navigator.pushNamed(context, '/home');
        // Navigator.of(context).push(new CupertinoPageRoute(
        //    builder: (BuildContext context) => new UserList()));
      } else {
        //SharedPreferencesHelper helpe= new SharedPreferencesHelper();
        //helpe.setRegisterIn(false);
     //   showSnackBar(response.body, scaffoldKey);
        // Navigator.of(context).push(new CupertinoPageRoute(
        //    builder: (BuildContext context) =>
        //    new OrdenesList()));
        //log("userID  $userID");
      }

    }catch(ersf){
      print("Error login..");
      //closeProgressDialog(context);
      //showSnackBar(response.body, scaffoldKey);
    }
    /*logginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    if (response == successful) {
      closeProgressDialog(context);
      Navigator.of(context).pop(true);
    } else {
      closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    }*/
  }
}