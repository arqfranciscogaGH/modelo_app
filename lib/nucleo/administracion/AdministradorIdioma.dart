//  librerias internas de flutter

//  librerias importadas flutter

//  librerias  proyecto

import '../negocio/negocio.dart';
import '../../paquetesExternos/paquetesExternos.dart';

//  librerias externas  flutter

// Descripcion de funcionalidad
//
// administrar la sesion de usuarios

const IDIOMA = "idioma";

class AdministradorIdioma {
  static void obtener() {
    String idioma = Preferencias.obtener(IDIOMA, ParametrosSistema.idioma);
    ParametrosSistema.idioma = idioma;
  }

  static void cambiar(String idioma) {
    ParametrosSistema.idioma = idioma;
  }

  static void guardar() {
    Preferencias.guardar(IDIOMA, ParametrosSistema.idioma);
  }
}
