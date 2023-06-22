//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias  proyecto

import '../../nucleo.dart';
import 'dart:math';
import 'dart:ui';
//  librerias externas  flutter

class Fondo {
  // fondos de pantalla
  static Widget gradiente(
      BuildContext context, String colorInicial, String colorFinal) {
    if (colorInicial == null || colorInicial == '')
      colorInicial = ParametrosSistema.colorPrimario;
    if (colorFinal == null || colorFinal == '')
      colorFinal = ParametrosSistema.colorSecundario;
    final fondoGradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: <Color>[
            Colores.obtener(colorInicial),
            Colores.obtener(colorFinal),
          ])),
    );
    return fondoGradiente;
  }

// otros adornos
  static Widget cajaGradienteRotacion(
      BuildContext context, String colorInicial, String colorFinal) {
    if (colorInicial == null || colorInicial == '')
      colorInicial = ParametrosSistema.colorPrimario;
    if (colorFinal == null || colorFinal == '')
      colorFinal = ParametrosSistema.colorSecundario;

    Widget caja = Transform.rotate(
        angle: -pi / 6.0,
        child: Container(
          height: 340.0,
          width: 340.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.4),
                end: FractionalOffset(0.0, 1.0),
                colors: <Color>[
                  Colores.obtener(colorInicial),
                  Colores.obtener(colorFinal),
                ]),
            borderRadius: BorderRadius.circular(80.0),
            // gradient: LinearGradient(

            // )
          ),
        ));
    return caja;
  }
}
