//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter
import '../../utilerias/Traductor.dart';
//  librerias  proyecto

class ContextoUI {
  //  declaracion  de variables
  static List<Pagina> _listaKeysFormulario = [];
  static GlobalKey<FormState>? _keyFormulario;
  static bool? _iniciarCaptura;

  static String obtenerTipo(Widget widget) {
    String tipo = widget == null ? "" : widget.runtimeType.toString();
    return tipo;
  }

  static String obtenerTitulo(Widget widget) {
    String pagina = obtenerTipo(widget);
    String titulo = "";
    titulo = Traductor.obtenerEtiquetaSeccion(pagina, 'titulo');
    return titulo;
  }

  static Pagina obtenerKey(String pagina) {
    Pagina? pagina;
    pagina = _listaKeysFormulario.firstWhere((s) => s.nombre == pagina);
    return pagina;
  }

  static guadarKey(String nombre, GlobalKey<FormState>? keyFormulario,
      [dynamic id, dynamic entidad]) {
    Pagina pagina = Pagina(
        nombre: nombre, keyFormulario: keyFormulario, id: id, entidad: entidad);
    Pagina paginaEncontrada =
        _listaKeysFormulario.firstWhere((s) => s.nombre == nombre);
    if (paginaEncontrada != null) {
      _listaKeysFormulario.remove(paginaEncontrada);
    }
    _listaKeysFormulario.add(pagina);
  }

  static GlobalKey<FormState> get keyFormulario {
    return _keyFormulario!;
  }

  static set keyFormulario(GlobalKey<FormState> keyFormulario) {
    _keyFormulario = keyFormulario;
  }

  static bool get iniciarCaptura {
    return _iniciarCaptura!;
  }

  static set iniciarCaptura(bool iniciarCaptura) {
    _iniciarCaptura = iniciarCaptura;
  }
}

class Pagina {
  String nombre;
  GlobalKey<FormState>? keyFormulario;
  dynamic id;
  dynamic entidad;
  Pagina({
    required this.nombre,
    required this.keyFormulario,
    required this.id,
    required this.entidad,
  });
}
