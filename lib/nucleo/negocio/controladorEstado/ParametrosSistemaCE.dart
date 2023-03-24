//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../nucleo.dart';
import '../../../administracion/administracion.dart';
import '../../../paquetesExternos/paquetesExternos.dart';

//  librerias externas  flutter

class ParametrosSistemaCE extends ChangeNotifier {
  // temma

  void obtenerTema() {
    AdministradorTema.obtener();
    notifyListeners();
  }

  void cambiarTema() {
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void guardarTema() {
    AdministradorTema.guardar();
    notifyListeners();
  }

  void cambiarColorPrimario(String color) {
    AdministradorTema.asignarColorPrimario(color);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void cambiarColorSecundario(String color) {
    AdministradorTema.asignarColorSecundario(color);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void cambiarEsModoObscuro(bool esModoObscuro) {
    AdministradorTema.asignarEsModoObscuro(esModoObscuro);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  // Idioma

  String obtenerIdioma() {
    AdministradorIdioma.obtener();
    return ParametrosSistema.idioma;
  }

  void cambiarIdioma(String idioma) {
    AdministradorIdioma.asignar(idioma);
    Traductor.cargar();
    OpcionesMenus.limpiar();
    notifyListeners();
  }

  void guardarIdioma() {
    AdministradorIdioma.guardar();
    notifyListeners();
  }
}
