//  librerias internas de flutter
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

//  librerias  proyecto

import '../nucleo/negocio/controladorEstado/ControlEstadoUI.dart';
import '../nucleo/nucleo.dart';
import '../nucleo/administracion/administracion.dart';

import '../aplicacion/contexto/ContextoApp.dart';
export '../aplicacion/contexto/ContextoApp.dart';

//  librerias externas  flutter

import '../paquetesExternos/paquetesExternos.dart';

// Descripcion de funcionalidad
//
//  Inicializacion variables
//

class InicializacionVariables {
  static void iniciar() async {
    valoresSincronos();
    await valoresAsicronos();
  }

  static void valoresSincronos() {
    // iniciar  contexto de  negocio
    // ContextoAplicacion.iniciar();

    // guardar informacion  usando injecion de dependencias

    late ElementoLista elementoLista;
    elementoLista = ElementoLista();
    elementoLista.titulo = "fga";
    InjeccionDependencia.agregar<ElementoLista>(elementoLista);
  }

  static Future valoresAsicronos() async {
    // obtener idioma
    AdministradorIdioma.obtener();
    // Inicializar datos  formateo e  idioma ,  con esta linea  se  evita  error
    initializeDateFormatting(ParametrosSistema.idioma);
    Intl.defaultLocale = ParametrosSistema.idioma;

    // cargar  etiquetas y textos  de acuerdo al idioma
    await Traductor.cargar();

    // obtener información de tema
    AdministradorTema.obtenerTema();

    // obtener  información de sesion
    AdministradorSesion.obtener();
  }
}
