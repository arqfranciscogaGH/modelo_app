//  librerias internas de flutter

//  librerias importadas flutter

//  librerias  proyecto

import '../nucleo/negocio/negocio.dart';
import '../paquetesExternos/paquetesExternos.dart';

//  librerias externas  flutter

// Descripcion de funcionalidad
//
// administrar la sesion de usuarios

const IDIOMA = "idioma";

class AdministradorIdioma {
  static void asignar(String idioma) {
    ParametrosSistema.idioma = idioma;
  }

  static void obtener() {
    ParametrosSistema.idioma =
        Preferencias.obtener(IDIOMA, ParametrosSistema.idioma);
  }

  static void guardar() {
    Preferencias.guardar(IDIOMA, ParametrosSistema.idioma);
  }
}
