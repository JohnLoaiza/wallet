import 'package:flutter/material.dart';
import 'package:pybus_wallet/pages/generateInvalid.dart';
import 'package:pybus_wallet/utils/screen_size.dart';


import 'package:pybus_wallet/widgets/percent_indicator.dart';
import 'package:pybus_wallet/widgets/wave_progress.dart';

import 'generate.dart';
import 'unlockPagar.dart';



var series = [
/*  new charts.Series(
    domainFn: (DataPerItem clickData, _) => clickData.name,
    measureFn: (DataPerItem clickData, _) => clickData.percent,
    colorFn: (DataPerItem clickData, _) => clickData.color,
    id: 'Item',
    data: data,
  ),*/
];

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: new AppBar(
          title: GestureDetector(
           // onLongPress: openAdmin,
            child: new Text("S_Pub - Wallet"),
          ),
          centerTitle: true,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {

                }),

          ],
        ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: 20,
          top: 70,
        ),
        children: <Widget>[

          SizedBox(
            height: 45,
          ),

          Row(
            children: <Widget>[
              GestureDetector(

                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UnlockScreen()));
                },

                child:
              colorCard("Pagar", 35.170, 1, context, Color(0xFF20cc76))),
              colorCard("Comprar", 4320, -1, context, Color(0xFFcc1485)),
              //CardImag()
            ],
          ),

          SizedBox(
            height: 60,
          ),
          Row(
            children: <Widget>[
              GestureDetector(

                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateScreenV()));

                  },

                  child:
              colorCard("Canjear", 35.170, 1, context, Color(0xFFff4055))
              ),
              colorCard("Transferir", 4320, -1, context, Color(0xFF14c0cc)),
              //CardImag()
            ],
          ),
          SizedBox(
            height: 30,
          ),

          Text(
            "Flujo de efectivo",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              inherit: true,
              letterSpacing: 0.4,
            ),
          ),
          vaweCard(
            context,
            "Ingresos",
            200,
            1,
            Colors.grey.shade100,
            Color(0xFF716cff),
          ),
          vaweCard(
            context,
            "Gastos",
            3210,
            -1,
            Colors.grey.shade100,
            Color(0xFFff596b),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new Column(
            children: <Widget>[
        new UserAccountsDrawerHeader(
        accountName: new Text(""),
        accountEmail: new Text(""),
        currentAccountPicture: new CircleAvatar(
          backgroundColor: Colors.white,
          child: new Icon(Icons.person),
        ),
      ),
      new ListTile(
        leading: new CircleAvatar(
          child: new Icon(
            Icons.account_box,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        title: new Text("Perfil"),
        onTap: () {

        },
      ),
      new ListTile(
        leading: new CircleAvatar(
          child: new Icon(
            Icons.settings_applications,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        title: new Text("Configuraciones"),
        onTap: () {

        },
      ),
              SizedBox(
                width: 30,
              ),
      new ListTile(
        leading: new CircleAvatar(
          child: new Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 20.0,
          ),
        ),
        title: new Text("Cerrar Sessión"),
        onTap: () {

        },
      ),
      ]
    )
    )
    );
  }

  Widget vaweCard(BuildContext context, String name, double amount, int type,
      Color fillColor, Color bgColor) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        right: 20,
      ),
      padding: EdgeInsets.only(left: 15),
      height: screenAwareSize(80, context),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 6,
            spreadRadius: 10,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              WaveProgress(
                screenAwareSize(45, context),
                fillColor,
                bgColor,
                67,
              ),
              Text(
                "80%",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${type > 0 ? "" : "-"} \$ ${amount.toString()}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget donutCard(Color color, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: 0,
            top: 18,
            right: 10,
          ),
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            inherit: true,
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
        )
      ],
    );
  }


Widget CardImag() {
  return new Card(
    child: Container(


      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/wallet_card.png"),
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Text("YOUR TEXT"),
    ),
  );

}
  Widget colorCard(
      String text, double amount, int type, BuildContext context, Color color) {
    final _media = MediaQuery.of(context).size;
    return new Container(




      margin: EdgeInsets.only(top: 15, right: 15),
      padding: EdgeInsets.all(15),
      height: screenAwareSize(90, context),
      width: _media.width / 2 - 25,

      decoration: BoxDecoration(
          color: color,
          /*image: DecorationImage(
            image: AssetImage("assets/images/card.png"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),*/
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 0.2,
                offset: Offset(0, 8)),
          ]),
      child:
        Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          Text(
            text,
            style: TextStyle(

              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
         /* Text(
            "${type > 0 ? "" : "-"} \$ ${amount.toString()}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )*/
        ],
      ),
    );
  }
}
