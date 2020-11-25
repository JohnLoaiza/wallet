import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pybus_wallet/data/values.dart';
import 'package:pybus_wallet/database/dbconn.dart';
import 'package:pybus_wallet/models/trans.dart';
import 'package:pybus_wallet/pages/adddatawidget.dart';
import 'package:pybus_wallet/pages/detailwidget.dart';
import 'package:pybus_wallet/pages/dialogo_servicios_handler.dart';
import 'package:pybus_wallet/pages/generateP.dart';

import 'package:qrscan/qrscan.dart' as scanner;

 List<Trans> transa;
class ContactosPage extends StatefulWidget {
  @override
  _ContactosPageState createState() => new _ContactosPageState();
}
DialogoServiciosHandler dlgServicios;
final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseUser user;

class _ContactosPageState extends State<ContactosPage> with ServiciosListener,SingleTickerProviderStateMixin{
  DbConn dbconn = DbConn();
  List<Trans> transList;
  int totalCount = 0;
  AnimationController _controller2;
  String mySaldo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController editingController = TextEditingController();


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
        title: Text("Mis Amigos"),
      ),
      body: new Container(
        padding: EdgeInsets.only(left: 20.0),
        child:
        Column(
            children: <Widget>[
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
        ),
      ),
      Expanded(
            child: new FutureBuilder(
              future: loadList(),
              builder: (context, snapshot) {
                return transa.length > 0? new TransList():
                new Center(child:
                new Text('Aun no has registrado ningun contacto,  Por favor haga Click en el boton + para comenzar!',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300)));
              },
            )
        ),
      ]
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


  void filterSearchResults(String query) {
    List<Trans> dummySearchList = List<Trans>();
    print("Query** $query");
    dummySearchList.addAll(transa);
    if(query.isNotEmpty) {
      print("isNotEmpty");
      List<Trans> dummyListData = List<Trans>();
      dummySearchList.forEach((item) {
        if(item.nombreCli.contains(query)||item.telefonoCli.contains(query)) {
          print(item.toString());
          dummyListData.add(item);
        }
      });
      setState(() {
        transa.clear();
        //transa.clear();
        transa.addAll(dummyListData);
      });
     // return;
    } else {
      setState(() {
        transa.clear();
        transa.addAll(transList);
      });
    }

  }
  @override
  Future<void> initState()  {

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
      futureTrans.then((transListe) {
        setState(() {
          //this.transList = transListe;
          transa=transListe;
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
      _showDialogo(objeto);
    });
  }



  void _showDialogo(String obj) {

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
      mySaldo = jsonRespond[1][0]['Points'].toString()+" COP";
    });

  }




}


void verifyLogginAmi(String barcode,BuildContext context,FirebaseAuth _auth,FirebaseUser user) async {

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
      /*    final initDB = dbconn.initDB();
        var now = new DateTime.now();
        var dateF=now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString();
        initDB.then((db) async {
          await dbconn.insertTrans(Trans(transDate: dateF, transName: jsonRespon['data']["Fax"], transType: jsonRespon['data']["UserName"],nombreCli: jsonRespon['data']['Email'],telefonoCli: jsonRespon['data']['Phone'], amount: 0));
        });*/

      dlgServicios.showDialog(context ,jsonRespon['data']["UserName"]);

    } else {


    }

  }catch(ersf){
    print("Error login..");

  }

}


class TransList extends StatefulWidget{


  @override
  _TransListState createState() => new _TransListState();
}

class _TransListState extends State<TransList> {



  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          itemCount: transa == null ? 0 : transa.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: InkWell(
                    onTap: () {
                      verifyLogginAmi(transa[index].transName,context,_auth,user);
                    /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailWidget(trans[index])),
                      );*/
                    },
                    onLongPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailWidget(transa[index])),
                      );
                    },
                    child: ListTile(
                      leading: transa[index].nombreCli == 'earning'? Icon(Icons.attach_money): Icon(Icons.perm_identity),
                      title: Text(transa[index].nombreCli),
                      subtitle: Text(transa[index].telefonoCli.toString()),
                    ),
                  )
              );
          });
  }


}
