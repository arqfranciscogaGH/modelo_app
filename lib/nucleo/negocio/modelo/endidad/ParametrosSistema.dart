//  librerias internas de flutter
import 'package:flutter/material.dart';
import '../../../ui/comun/Enumerados.dart';

//  librerias importadas flutter

//  librerias  proyecto

//  librerias externas  flutter

// Descripcion de funcionalidad
//
//  ParametrosSistema
//

class ParametrosSistema {
  static String paginaAccesso = 'acceso_pagina';
  static String idioma = 'es';

  //  colores
  //static String formatoFecha='MM-dd-yyyy';
  static String formatoFecha = 'dd-MM-yyyy';
  static String formatoHora = 'hh:mm';
  static String formatoImporte = '';
  static eTipoBorde tipoBorde = eTipoBorde.ninguno;
  static String colorTema = 'azul';
  static String colorPrimario = 'azul';
  static String colorSecundario = 'azul';
  static String colorTitulo = 'azul';
  static String colorSubTitulo = 'moradoclaro';

  static String colorFondo = 'blanco';
  static String colorTexto = 'gris';
  static String colorIcono = 'moradoclaro';
  static String colorBorde = 'moradoclaro';
  static String colorSombra = 'negro';

  static String colorCapturaFondo = 'gris';
  static String colorCapturaEtiqueta = 'gris';
  static String colorCapturaTexto = 'gris';
  static String colorCapturaBorde = 'gris';
  static String colorCapturaIcono = 'gris';
  static String colorCapturaMensaje = 'gris';

  static eBotonTipo tipoBoton = eBotonTipo.RectaguloOvalo;
  static String colorBotonTexto = 'negro';
  static String colorBotonFondo = 'amarillo';
  static String colorBotonBorde = 'negro';
  static String colorBotonIcono = 'negro';

  static String colorOpcionMenuTexto = 'blanco';
  static String colorOpcionMenuFondo = 'negro';
  static String colorOpcionMenuBorde = 'negro';
  static String colorOpcionMenuIcono = 'negro';

  static String colorItemListaTexto = 'gris';
  static String colorItemListaFondo = 'azul';
  static String colorItemListaBorde = 'negro';
  static String colorItemListaIcono = 'negro';
  static String colorError = 'rojo';
  static bool esModoObscuro = false;

  static double tamanoFuente = 15;
  static double tamanoIcono = 18;
  static double ancho = 50;
  static double minAncho = 50;
  static double alto = 30;
  static double minalto = 30;

  // static String get colorSecundario {
  //   if (_colorSecundario == null || _colorSecundario == '')
  //     _colorSecundario =
  //         Preferencias.obtener("colorSecundario", _colorSecundario);
  //   return _colorSecundario == null || _colorSecundario == ''
  //       ? "gris"
  //       : _colorSecundario;
  // }

  // static void set colorSecundario(String valor) {
  //   _colorSecundario = valor;
  //   Preferencias.guardar("colorSecundario", valor);
  // }

  // static String get tema {
  //   return obtenerTema();
  // }

  // static String obtenerTema() {
  //   if (_tema == null || _tema == '')
  //     _tema = Preferencias.obtener("tema", _tema);
  //   return _tema == null || _tema == '' ? "azul" : _tema;
  // }

  // static void set tema(String valor) {
  //   _tema = valor;
  // }

  // static guardarTema(String valor) {
  //   _tema = valor;
  //   Preferencias.guardar("tema", valor);
  // }

  // static int get brillo {
  //   return obtenerrBrillo();
  // }

  // static int obtenerrBrillo() {
  //   if (_brillo == null) _brillo = Preferencias.obtener("brillo", _brillo);
  //   return _brillo == null || _brillo == 0 ? 0 : _brillo;
  // }

  // static void set brillo(int valor) {
  //   _brillo = valor;
  // }

  // static void guardarBrillo(int valor) {
  //   _brillo = valor;
  //   Preferencias.guardar("brillo", valor);
  // }

  // static Variables _variables;
  // Variables obtenerVariables() {
  //   return _variables;
  // }

}
