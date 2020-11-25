import 'package:flutter/material.dart';
import 'package:pybus_wallet/widgets/progressdialog.dart';


String appName = "Acopio la 25";
//String URL_Server="http://181.206.51.46:8080/Acopio_25/";
String URL_Server="http://184.107.226.250/vendedores/";

  String IP_BASE="52.1.222.18";
  String PUERTO_BASE="3539";
  String URI_BASE="http://"+IP_BASE+":"+PUERTO_BASE;

Color colorGradientTop = Color(0xFF000000 );
//Color colorGradientTop = Color(0xFF558B2F );
Color colorGradientBottom = Color(0xFF000000 );

final Color _colorbases =  Color(0xFF011C74);


Gradient appGradient =
    LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
    colors: [colorGradientTop, colorGradientBottom,], stops: [0,0.7]);


displayProgressDialog(BuildContext context) {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
            return new ProgressDialog();
        }));
}

closeProgressDialog(BuildContext context) {
    Navigator.of(context).pop();
}