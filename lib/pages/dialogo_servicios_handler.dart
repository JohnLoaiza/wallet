import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pybus_wallet/pages/servicio_dialog.dart';





class DialogoServiciosHandler {
  ServicioDialog dialogServi;
  AnimationController _controller;
  ServiciosListener _listener;

  DialogoServiciosHandler(this._listener, this._controller);





  void init() {
    dialogServi = new ServicioDialog(this, _controller);
    dialogServi.initState();
  }

  Future cropImage(File image) async {
    String retornoHandler="";

    _listener.userServicio(retornoHandler,"");
  }


  Future ShowResult(String image,String direcc) async {
    String retornoHandler="";

    _listener.userServicio(image,direcc);
  }

  showDialog(BuildContext context,String qr) {
    dialogServi.getResponseService(context,qr);
  }

  showDialogs(BuildContext context,String mensaj) {
    dialogServi.getResponseService(context,mensaj);
  }

}

abstract class ServiciosListener {
  userServicio(String objeto,String direccion);
}
