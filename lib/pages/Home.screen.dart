import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pybus_wallet/data/values.dart';
import 'package:pybus_wallet/database/dbconn.dart';
import 'package:pybus_wallet/models/trans.dart';
import 'package:pybus_wallet/pages/generateP.dart';
import 'package:pybus_wallet/pages/translist.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'adddatawidget.dart';
import 'dashboard.dart';
import 'dialogo_servicios_handler.dart';
import 'generate.dart';


//String mySaldo="4000 COP";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final PageStorageBucket bucket = PageStorageBucket();
  int currentTab = 0;

  MyHomePage_nav one;
  DashboardPage two;
  MyListTransa  tree;
  List<Widget> pages;
  Widget currentPage;

  var time;


  @override
  Future<void> initState()  {

    one = new MyHomePage_nav();
    two = new DashboardPage();
    tree = new MyListTransa(title: "Contactos");
    pages = [one, two,tree];
    currentPage = one;
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF278FB4);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        fixedColor: Colors.grey,
        currentIndex: currentTab,
        onTap: (int index) {
          setState(() {
            currentTab = index;
            currentPage = pages[index];
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            title: Text("Historial"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cached),
            title: Text("Transferencias"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text("Pagos"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Configuración"),
          )
        ],

      ),


      body:
      PageStorage(
        child: currentPage,
        bucket: bucket,
      ),

    );
  }




  @override
  void dispose() {

   // print("Cancelando timer de updates");


    super.dispose();
  }


}


class MyHomePage_nav extends StatefulWidget {
  @override
  _MyHomePageState_nav createState() => _MyHomePageState_nav();
}
class _MyHomePageState_nav extends State<MyHomePage_nav> with ServiciosListener,SingleTickerProviderStateMixin{

  DialogoServiciosHandler dlgServicios;
  AnimationController _controller2;

  final PageStorageBucket bucket = PageStorageBucket();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

String mySaldo;

  var time;
  Future<void> getTransas()async {
    String uniqueId;
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    print(uniqueId);
    final response = await http.post(
        URL_Server + "android_connect/get_all_transa.php",
        body: {"id": "$uniqueId"});
    var jsonRespond = json.decode(response.body);

    setState(() {
      mySaldo = jsonRespond[1][0]['Points'].toString()+" COP";
    });

  }

  @override
  Future<void> initState()  {
    getTransas();
    time = startTimeout(15000);
    _controller2 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    dlgServicios = new DialogoServiciosHandler(this, _controller2);
    dlgServicios.init();

    super.initState();
  }



  void DialogoServicios(String qr){
    //   setState(() {
    dlgServicios.showDialog(context ,qr);
    // });


  }


  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF278FB4);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),




      appBar: new AppBar(
        title: new Text("Mi Billetera"),
        centerTitle: true,
        backgroundColor:Color( 0xFF678FB4),
        elevation: 0.0,
      ),
      body:

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 350.0,
                    decoration: BoxDecoration(color: primaryColor),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mySaldo!=null?mySaldo:'',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            'Balance Disponible',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14.0),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 120.0, right: 25.0, left: 25.0),
                  child: Container(
                    width: double.infinity,
                    height: 320.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0.0, 3.0),
                              blurRadius: 15.0)
                        ]),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0, vertical: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purple.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.send),
                                      color: Colors.purple,
                                      iconSize: 30.0,
                                      onPressed: () {

                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => MyListTransa(title: "Contactos")
                                        ));
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Transferir',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.blue.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.credit_card),
                                      color: Colors.blue,
                                      iconSize: 30.0,
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => GenerateScreen()
                                        ));

                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Pagar',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.pink.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.monetization_on),
                                      color: Colors.pink,
                                      iconSize: 30.0,
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => DashboardPage()
                                        ));

                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Historico',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Material(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: Colors.purpleAccent.withOpacity(0.1),
                                    child: IconButton(
                                      padding: EdgeInsets.all(15.0),
                                      icon: Icon(Icons.local_play),
                                      color: Colors.purpleAccent,
                                      iconSize: 30.0,
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) => GenerateScreenP()
                                        ));

                                      },
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Recibir',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),

                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),



                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 30.0),
              child: Text(
                'Bolsillos',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35.0, bottom: 25.0),
              child: Container(
                height: 80.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    UpcomingCard(
                      title: 'Principal',
                      value: 'E-Comerce',
                      color: Colors.purple,
                    ),
                    UpcomingCard(
                      title: 'Viajes',
                      value: 'E-Comerce',
                      color: Colors.blue,
                    ),
                    UpcomingCard(
                      title: 'Salud',
                      value: 'E-Comerce',
                      color: Colors.grey,
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future _scan() async {
    final String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      setState(() {
        DialogoServicios(barcode);
      });

    }
  }

  @override
  void dispose() {

    print("Cancelando timer de updates");
    time.cancel();
    _controller2.dispose();
    super.dispose();
  }


  static const timeout = const Duration(seconds: 15);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer.periodic(duration, handleTimeout);
  }


  void handleTimeout(Timer timef){

    getTransas();

    debugPrint(timef.tick.toString());
    print("Se inicia el getData Updates... ");
    //time.cancel();
  }


  @override
  userServicio(String objeto, String direccion) {
    getTransas();
    setState(() {
      _showDialog(objeto);
    });

    // TODO: implement userServicio

  }
  void _showDialog(String obj) {

    String textOK="OK";
    String textOK2="Transferencia realizada de manera correcta.";
    String textBAD="Error";
    String textBAD2="No fue posible procesar su transferencia, por favor verifique sus datos e intentelo nuevamente.";


    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(obj=="OK"?textOK:textBAD),
          content: new Text(obj=="OK"?textOK2:textBAD2),
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

}

class NavigationItem {
  final Icon icon;
  final Text title;
  final Color color;

  NavigationItem(this.icon, this.title, this.color);
}
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class UpcomingCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  UpcomingCard({this.title, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.0),
      child: Container(
        width: 120.0,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300)),
           /*   SizedBox(height: 15.0),*/
             /* Text('$value',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300))*/
            ],
          ),
        ),
      ),
    );
  }
}



class MyListTransa extends StatefulWidget  {
  MyListTransa({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyListTransaState createState() => _MyListTransaState();
}

class _MyListTransaState extends State<MyListTransa> with ServiciosListener,SingleTickerProviderStateMixin{
  DbConn dbconn = DbConn();
  List<Trans> transList;
  int totalCount = 0;
  DialogoServiciosHandler dlgServicios;
  AnimationController _controller2;
  String mySaldo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;


  @override
  Widget build(BuildContext context) {

    if(transList == null) {
      transList = List<Trans>();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
backgroundColor:         Color(0xFF278FB4),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 20.0),
        child: new Center(
            child: new FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return transList.length > 0? new TransList(trans: transList):
                new Center(child:
                new Text('Aun no has registrado ningun contacto,  Por favor haga Click en el boton + para comenzar!',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)));
              },
            )
        ),
      ),
      floatingActionButton:
      Stack(
        children: <Widget>[
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'Agregar',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => GenerateScreenP()
                ));
               // _navigateToAddScreen(context);
                // What you want to do
              },
              child: Icon(Icons.add),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton(
              heroTag: 'Escanear',
              onPressed: () {
                _scan();
              },
              child: Icon(Icons.settings_overscan),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ],
      ),
   /*   FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Agregar',
        child: Icon(Icons.add),
      ),*/
    /*  bottomNavigationBar: BottomAppBar(
        child:  new FutureBuilder(
          future: loadTotal(),
          builder: (context, snapshot)  {
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Total: $totalCount', style: Theme.of(context).textTheme.title),
            );
          },
        ),
        color: Colors.cyanAccent,
      ),*/// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  Future<void> initState()  {
    time = startTimeout(15000);
    _controller2 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    dlgServicios = new DialogoServiciosHandler(this, _controller2);
    dlgServicios.init();
    super.initState();
  }

  Future _scan() async {
    final String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
     // setState(() {
        //DialogoServicios(barcode);
        verifyLoggin(barcode);
     // });

    }
  }
  void verifyLoggin(barcode) async {

String uniqueId;
    displayProgressDialog(context);

user=await _auth.currentUser();

try {
  // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
  //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
  uniqueId=user.uid;

    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }


    final response = await http.post(URI_BASE +"/getQRContactoP",body:{"imei":"$barcode"});

    print("response login:  $barcode");
    print(response.body);
    var jsonRespon=json.decode(response.body);
    try {



      closeProgressDialog(context);

      if (jsonRespon['success']) {
        //SharedPreferencesHelper helpe= new SharedPreferencesHelper();
        final initDB = dbconn.initDB();
        var now = new DateTime.now();
        var dateF=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString();
        initDB.then((db) async {
          await dbconn.insertTrans(Trans(transDate: dateF, transName: jsonRespon['data']["Fax"], transType: jsonRespon['data']["UserName"],nombreCli: jsonRespon['data']['Email'],telefonoCli: jsonRespon['data']['Phone'], amount: 0));
        });

        dlgServicios.showDialog(context ,jsonRespon['data']["UserName"]);

      } else {


      }

    }catch(ersf){
      print("Error login..");

    }

  }
  void DialogoServicios(String qr){
    //   setState(() {
    dlgServicios.showDialog(context ,qr);
    // });


  }

  Future loadList() {
    final Future futureDB = dbconn.initDB();
    return futureDB.then((db) {
      Future<List<Trans>> futureTrans = dbconn.trans();
      futureTrans.then((transList) {
        setState(() {
          this.transList = transList;
        });
      });
    });
  }

  Future loadTotal() {
    final Future futureDB = dbconn.initDB();
    return futureDB.then((db) {
      Future<int> futureTotal = dbconn.countTotal();
      futureTotal.then((ft) {
        setState(() {
          this.totalCount = ft;
        });
      });
    });
  }

  _navigateToAddScreen (BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }

  @override
  userServicio(String objeto, String direccion) {
    // TODO: implement userServicio
    getTransas();
    setState(() {
      _showDialog(objeto);
    });
  }



  void _showDialog(String obj) {

    String textOK="OK";
    String textOK2="Transferencia realizada de manera correcta.";
    String textBAD="Error";
    String textBAD2="No fue posible procesar su transferencia, por favor verifique sus datos e intentelo nuevamente.";


    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(obj=="OK"?textOK:textBAD),
          content: new Text(obj=="OK"?textOK2:textBAD2),
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

  var time;
  Future<void> getTransas()async {
    String uniqueId;
    user=await _auth.currentUser();

    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);//uniqueId=user.uid;
      uniqueId=user.uid;
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    print("uniqueId*****  "+uniqueId);

    final response = await http.post(
        URL_Server + "android_connect/get_all_transa.php",
        body: {"id": "$uniqueId"});
    var jsonRespond = json.decode(response.body);
print("jsonRespond    "+jsonRespond.toString());
    setState(() {
      mySaldo = jsonRespond[1][0]['Points'].toString()+" COP "+uniqueId;
    });

  }



  static const timeout = const Duration(seconds: 15);
  static const ms = const Duration(milliseconds: 1);

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer.periodic(duration, handleTimeout);
  }


  void handleTimeout(Timer timef){

    getTransas();

    debugPrint(timef.tick.toString());
    print("Se inicia el getData Updates... "+user.uid+"");
    //time.cancel();
  }
}
