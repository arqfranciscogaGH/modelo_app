//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../db/DBAplicacion.dart';

export '../db/DBAplicacion.dart';

class ContextoApp {
  static ContextoApp? _ContextoApp;

  static DBAplicacion? _db;

  static DBAplicacion get db {
    if (_db == null) iniciar();
    return _db!;
  }

  ContextoApp() {}

  static iniciar() async {
    // _accesoDB = AccesoBD();
    // _accesoDB!.definirPersistencia(_configuracionPersitencia);
    _db = DBAplicacion();
    await _db!.abrir();
    // _accesoDB!.abrir();
    // _BD.sqlConsultar( 'select Persona.nombre, sum(Mov.importe) from Persona left join Mov ON Persona.id=Mov.idPersona group by Persona.nombre').then( ( listaRespuesta)
    // {
    //     List<Map> datos = listaRespuesta;
    //     print (datos);
    // });
  }

  static ContextoApp obtener() {
    if (_ContextoApp == null)
      _ContextoApp = new ContextoApp();
    return _ContextoApp!;
  }
}
