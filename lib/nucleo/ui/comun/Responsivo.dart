//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

class Responsivo {
  static String _dispositivo = '';
  static String _orientation = '';
  static double _height = 0;
  static double _width = 0;

  static String get orientation {
    return _orientation;
  }

  static String get dispositivo {
    return _dispositivo;
  }

  static double get width {
    return _width;
  }

  static double get height {
    return _height;
  }

  // tablet
  //  Orientation.landscape  height 752.0   width  1280.0
  //  Orientation.portrait height 1232.0   width  800.0

  // telefono
  //  Orientation.landscape  height 360.0   width  707.0
  //  Orientation.portrait   height 740.0   width  360.0
  //
  static String identifciarDispositivo(BuildContext context) {
    _dispositivo = "tel";
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _orientation = MediaQuery.of(context).orientation.toString();

    if (height >= 1240 && width >= 1280)
      _dispositivo = "pc";
    else if ((height > 750 && height < 1240) && (width >= 800 && width <= 1280))
      _dispositivo = "tablet";
    else if ((height > 360 && height < 740) && (width >= 360 && width <= 710))
      _dispositivo = "tel";
    return _dispositivo;
  }
}
