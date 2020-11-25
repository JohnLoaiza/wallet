import 'package:flutter/material.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';

final onBoardingList = [
  PageModel(
    color: Color(0xFF678FB4),
    heroImagePath: 'assets/images/onBoarding_1.png',
    iconImagePath: 'assets/images/onBoarding_1.png',
    title: Text(
      'Bienvenido '

          'PAYBUS ',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: 'Montserrat'
      )
    ),
    body: Text(
      'Ya tienes medios de validación  ',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: 'Montserrat'
      ),
    )
  ),
  PageModel(
    color: Color(0xFF65B0B4),
    heroImagePath: 'assets/images/onBoarding_2.png',
    iconImagePath: 'assets/images/onBoarding_2.png',
    title: Text(
      'Pagos Rapidos y seguros',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: 'Montserrat'
      )
    ),
    body: Text(
      'Envie y transfiera tokens para un medio de validación y organize sus bolsillos mas facilmente.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontFamily: 'Montserrat'
      ),
    )
  ),
  PageModel(
    color: Color(0xFF9B90BC),
    heroImagePath: 'assets/images/onBoarding_3.png',
    iconImagePath: 'assets/images/onBoarding_3.png',
    title: Text(
      'Indicadores Financieros',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: 30.0,
        fontFamily: 'Montserrat'
      )
    ),
    body: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Organice sus gastos e ingresos, ademas de asegurar su cuenta por código PIN cada vez que use la aplicación.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontFamily: 'Montserrat'
        ),
      ),
    )
  )
];