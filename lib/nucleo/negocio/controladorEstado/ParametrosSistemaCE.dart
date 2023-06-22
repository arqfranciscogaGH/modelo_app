//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../ui/ui.dart';
import '../../utilerias/utilerias.dart';
import '../../administracion/administracion.dart';

//  librerias externas  flutter

class ParametrosSistemaCE extends ChangeNotifier {
  // temma

  void obtenerTema() {
    AdministradorTema.obtenerTema();
    notifyListeners();
  }

  void cambiarTema() {
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void guardarTema() {
    AdministradorTema.guardarTema();
    notifyListeners();
  }

  void cambiarColorPrimario(String color) {
    AdministradorTema.cambiarColorTema(color);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void cambiarColorSecundario(String color) {
    AdministradorTema.cambiarColorSecundario(color);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  void cambiarEsModoObscuro(bool esModoObscuro) {
    AdministradorTema.cambiarEsModoObscuro(esModoObscuro);
    AdministradorTema.cambiarTema();
    notifyListeners();
  }

  // Idioma

  dynamic obtenerIdioma() {
    return AdministradorIdioma.obtener();
  }

  void cambiarIdioma(String idioma) {
    AdministradorIdioma.cambiar(idioma);
    Traductor.cargar();
    OpcionesMenus.limpiar();
    notifyListeners();
  }

  void guardarIdioma() {
    AdministradorIdioma.guardar();
    notifyListeners();
  }
}
