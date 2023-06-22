import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../ui/comun/Enumerados.dart';
export '../../ui/comun/Enumerados.dart';
//
//  provider  para  controlar  el estado general  de todas  las entidades
//

//  procesos de  entidades

class ControlEstadoUI extends ChangeNotifier {
  //
  //  propiedade
  //
  dynamic tabla;
  eProceso proceso = eProceso.ninguno;
  eEstatus estatus = eEstatus.ninguno;
  // esta  variable se utiliza para  identificar  cuando esta un proceso se esta  realizando y  cuando termina es falso
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
    this.proceso = proceso;
    this.estatus = estatus;
    enProceso = false;

    // if (enProceso == false)
    notifyListeners();
  }

  //
  //  metodos de negocio y actualizar  el estado de  entidades
  //
  // dynamic iniciarEntidad<T extends EntidadBase>(AccesoTabla<T> tabla) {
  //   tabla.entidad = tabla.iniciarEntidad();
  //   return tabla.entidad;
  // }

  // dynamic entidad<T extends EntidadBase>(AccesoTabla<T> tabla) {
  //   return tabla.entidad;
  // }

  // List<dynamic> lista<T extends EntidadBase>(AccesoTabla<T> tabla) {
  //   return tabla.lista;
  // }
}
