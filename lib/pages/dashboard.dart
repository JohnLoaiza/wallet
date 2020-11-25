import 'dart:convert';
import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

import 'package:pybus_wallet/data/values.dart';


class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

List<Widget> lineas = <Widget>[];
class _DashboardPageState extends State<DashboardPage> {
  Color primaryColor = Color(0xFF278FB4);
  String miSaldo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  @override
  Future<void> initState() {
    getTransas();

  }


  @override
  Widget build(BuildContext context) {
    var data = [
     /* ClickPerMonth('Ene', 3000, Colors.purple),
      ClickPerMonth('Feb', 42000, Colors.blue),
      ClickPerMonth('Mar', 54000, Colors.purple),
      ClickPerMonth('Abr', 20000, Colors.blue),
      ClickPerMonth('May', 76000, Colors.purple),
      ClickPerMonth('Jun', 35000, Colors.blue),*/
    ];

    var series = [
   /*   new charts.Series(
          id: 'Clicks',

          domainFn: (ClickPerMonth clickData, _) => clickData.month,
          measureFn: (ClickPerMonth clickData, _) => clickData.clicks,
          colorFn: (ClickPerMonth clickData, _) => clickData.color,
          data: data)*/
    ];

/*    var chart = new charts.BarChart(series,
        animate: true, animationDuration: Duration(milliseconds: 1500));*/

/*    var chartWidget =Padding(
      padding: EdgeInsets.all(12.0),
      child: SizedBox(height: 170.0, child: chart),
    );*/

    return Scaffold(
      appBar:  new AppBar(
        title: new Text("Estadisticas"),
        centerTitle: true,
        backgroundColor:Color( 0xFF678FB4),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              /*  child: Text('Estadisticas',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0)),*/
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                width: double.infinity,
                height: 340.0,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.0, 0.3),
                          blurRadius: 15.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                miSaldo!=null?miSaldo:'',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Balance Disponible',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.show_chart),
                            onPressed: () {},
                            color: Colors.white,
                            iconSize: 30.0,
                          )
                        ],
                      ),
                    ),
                  //  chartWidget
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
              child: Text(
                'Actividad Reciente',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                  children:lineas!=null?
                  lineas:<Widget>[]

              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> getTransas()async{
    user=await _auth.currentUser();
String uniqueId;
    try {
      // platformImei = await ImeiPlugin.getImei( shouldShowRequestPermissionRationale: false );
      //uniqueId = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true);
      uniqueId=user.uid;
    } on PlatformException {
      // platformImei = 'Failed to get platform version.';
    }
    print(uniqueId);
    final response = await http.post(URL_Server +"android_connect/get_all_transa.php",body:{"id":"$uniqueId"});
    var jsonRespond=json.decode(response.body);
/*var medio_pago=jsonRespon[2]['medio_pago'].toString();
print(medio_pago);*/
    print(jsonRespond);
    setState(() {
      miSaldo=jsonRespond[1][0]['Points'].toString();
      var jsonRespon=jsonRespond[0];
      if(jsonRespon.length>0){
        lineas = <Widget>[];
      }
      for (var b = 0; b < jsonRespon.length; b++) {
        var avatar = "";
        var canal = jsonRespon[b]['medio_pago'];
        var tipot = "";
        var valor = jsonRespon[b]['valor'];
        if (jsonRespon[b]['observa'] == 'Viaje' ||
            jsonRespon[b]['tipo'] == 'Viaje') {
          avatar = "V";
          tipot = "" + jsonRespon[b]['viajes'] + " viaje";
        } else if (jsonRespon[b]['observa'] == 'Transferencia' ||
            jsonRespon[b]['tipo'] == 'Transferencia') {
          avatar = "T";
          tipot = "" + jsonRespon[b]['observa'] + " " + jsonRespon[b]['otrocampo'];
        }
        else if (jsonRespon[b]['observa'] == 'Recarga' ||
            jsonRespon[b]['tipo'] == 'Recarga') {
          avatar = "R";
          tipot = "" + jsonRespon[b]['observa'] + " " + jsonRespon[b]['otrocampo'];
        }
        lineas.add(_Transaccion(avatar, canal, tipot, valor));
      }
    });
  }

}



Widget _Transaccion(String avatar,String canal,String tipot,String valor){

  return  Padding(
    padding: EdgeInsets.only(top: 5,left: 5),
    child: Row(
      children: <Widget>[
        Material(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.blue.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              '$avatar',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  children:<Widget>[
                    Text(
                      'Canal:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 6.0),

                    ),
                    Text(
                      '$canal',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w300),
                    ),

                  ]
              ),
              Row(
                  children:<Widget>[
                    Text(
                      'Transacción:',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 2.0),

                    ),
                    AutoSizeText(
                      '$tipot',
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 10,
                          fontWeight: FontWeight.w300),
                    )
                  ]
              )
            ],
          ),
        ),
        Column(
          children: [
            Text(
              'Valor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              '$valor',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),

      ],
    ),
  );

}


/*class ClickPerMonth {
  final String month;
  final int clicks;
  final charts.Color color;

  ClickPerMonth(this.month, this.clicks, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}*/
