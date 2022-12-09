import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../aplicacion/contexto/ContextoAplicacion.dart';

enum eProceso {
  ninguno,
  iniciar,
  terminar,
  insertar,
  modificar,
  eliminar,
  consultar,
  obtener,
  filtrar,
}

enum eEstatus {
  ninguno,
  iniciado,
  enProceso,
  terminado,
  insertado,
  modificado,
  eliminado,
  consultado,
  obtenido,
  filtrado,
}

class ControlEstadoUI extends ChangeNotifier {
  //
  //  propiedade
  //
  dynamic tabla;
  eProceso proceso = eProceso.ninguno;
  eEstatus estatus = eEstatus.ninguno;
  bool? enProceso;
  //
  //  metodos
  //
  //
  //  metodos para  actualizar Interface de  Usuario  con  Provider
  //
  void iniciarProceso(
      [eProceso proceso = eProceso.iniciar,
      eEstatus estatus = eEstatus.enProceso]) {
    enProceso = true;
    this.proceso = proceso;
    this.estatus = estatus;
  }

  //
  //  metodos para  actualizar Interface de  Usuario  con  Provider
  //
  void actualizarUI(
      [eProceso proceso = eProceso.iniciar,
      eEstatus estatus = eEstatus.enProceso]) {
    enProceso = false;
    this.proceso = proceso;
    this.estatus = estatus;
    notifyListeners();
  }

  //
  //  metodos de negocio y actualizar  el estado de  entidades
  //
  dynamic iniciarEntidad<T extends EntidadBase>(AccesoTabla<T> tabla) {
    tabla.entidad = tabla.iniciar();
    return tabla.entidad;
  }

  dynamic entidad<T extends EntidadBase>(AccesoTabla<T> tabla) {
    return tabla.entidad;
  }

  List<dynamic> lista<T extends EntidadBase>(AccesoTabla<T> tabla) {
    return tabla.lista;
  }

  // no usar
  // List<dynamic> consultarTabla<T extends EntidadBase>(AccesoTabla<T> tabla,
  //     [Function? metodoRespuesta = null, bool regresar = false]) {
  //   List<dynamic>? lista = [];
  //   tabla.consultarTabla(tabla.entidad, metodoRespuesta).then((respuesta) {
  //     print(respuesta);
  //     if (respuesta != null) {
  //       lista = respuesta;
  //       if (metodoRespuesta != null)
  //         metodoRespuesta(respuesta);
  //       else if (!regresar) actualizar();
  //     }
  //   });
  //   return lista!;
  // }

  filtrarTabla<T extends EntidadBase>(
      AccesoTabla<T> tabla, String campo, dynamic valor,
      [Function? metodoRespuesta = null]) {
    tabla.filtrarTabla(tabla.entidad, campo, valor).then((respuesta) {
      if (metodoRespuesta != null)
        metodoRespuesta(respuesta);
      else
        this.actualizarUI();
    });
  }

  filtrarLista<T extends EntidadBase>(AccesoTabla<T> tabla,
      BuildContext context, ElementoLista elemento, String campo, dynamic valor,
      [Function? metodorRespuestaObtener = null]) {
    dynamic respuesta;
    tabla.entidad == tabla.iniciar();
    tabla.entidad.id = elemento.id;
    List<dynamic> lista = tabla.resultado.datos;
    if (lista != null) respuesta = lista.where((s) => s[campo] == valor).first;
    tabla.entidad =
        respuesta != null ? tabla.entidad.fromMap(respuesta) : tabla.iniciar();
    if (metodorRespuestaObtener != null)
      metodorRespuestaObtener(context, elemento, tabla.entidad);
  }
}
