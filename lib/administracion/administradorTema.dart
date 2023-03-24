//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias importadas flutter

//  librerias  proyecto

import '../nucleo/nucleo.dart';
// import '../nucleo/negocio/negocio.dart';
import '../paquetesExternos/paquetesExternos.dart';

import '../nucleo/negocio/controladorEstado/controladorEstado.dart';

//  librerias externas  flutter

// Descripcion de funcionalidad
//
// administrar de tema
//

const COLOR_PRIMARIO = "colorPrimario";
const COLOR_SECUNDARIO = "colorSecundario";
const ES_OBSCURO = "EsModoObscuro";

class AdministradorTema {
  //  Tema

  static void cambiarTema() {
    cambiarColores();
    Tema.crearTemaPersonalizado();
  }

  static void obtener() {
    // obtenerColorTema();
    obtenerColorPrimario();
    obtenerColorSecundario();
    obtenerEsModoObscuro();
    cambiarTema();
  }

  static void guardar() {
    // guardarColorTema(ParametrosSistema.colorTema);
    guardarColorPrimario(ParametrosSistema.colorPrimario);
    guardarColorSecundario(ParametrosSistema.colorSecundario);
    guardarEsModoObscuro(ParametrosSistema.esModoObscuro);
  }

  //   Color Primario

  static void asignarColorPrimario(String color) {
    ParametrosSistema.colorPrimario = color;
  }

  static void obtenerColorPrimario() {
    String color =
        Preferencias.obtener(COLOR_PRIMARIO, ParametrosSistema.colorPrimario);
    ParametrosSistema.colorPrimario = color;
  }

  static void guardarColorPrimario(String color) {
    Preferencias.guardar(COLOR_PRIMARIO, color);
  }

  //   Color Secundario

  static void asignarColorSecundario(String color) {
    ParametrosSistema.colorSecundario = color;
  }

  static void obtenerColorSecundario() {
    String color = Preferencias.obtener(
        COLOR_SECUNDARIO, ParametrosSistema.colorSecundario);
    ParametrosSistema.colorSecundario = color;
  }

  static void guardarColorSecundario(String color) {
    Preferencias.guardar(COLOR_SECUNDARIO, color);
  }

  //  modo obscuro

  static void asignarEsModoObscuro(bool esModoObscuro) {
    ParametrosSistema.esModoObscuro = esModoObscuro;
  }

  static void obtenerEsModoObscuro() {
    bool esModoObscuro =
        Preferencias.obtener(ES_OBSCURO, ParametrosSistema.esModoObscuro);
    ParametrosSistema.esModoObscuro = esModoObscuro;
  }

  static void guardarEsModoObscuro(bool esModoObscuro) {
    Preferencias.guardar(ES_OBSCURO, esModoObscuro);
  }

  //  cambiar Colores
  static void cambiarColores() {
    ParametrosSistema.colorTexto = ParametrosSistema.colorTexto;
    ParametrosSistema.colorIcono = ParametrosSistema.colorPrimario;
    ParametrosSistema.colorBorde = ParametrosSistema.colorPrimario;

    ParametrosSistema.colorBotonFondo = ParametrosSistema.colorPrimario;
    // ParametrosSistema.colorBotonIcono = 'negro';
    // ParametrosSistema.colorBotonBorde = 'azul';
    // ParametrosSistema.colorBotonTexto = 'blanco';

    ParametrosSistema.colorCapturaFondo = ParametrosSistema.colorPrimario;
    ParametrosSistema.colorCapturaIcono = ParametrosSistema.colorPrimario;

    ParametrosSistema.colorItemListaFondo = ParametrosSistema.colorPrimario;
    ParametrosSistema.colorItemListaIcono = ParametrosSistema.colorPrimario;

    ParametrosSistema.colorOpcionMenuFondo = ParametrosSistema.colorPrimario;
    ParametrosSistema.colorOpcionMenuIcono = ParametrosSistema.colorPrimario;
  }
}
