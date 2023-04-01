//  librerias internas de flutter

import 'dart:async';
import 'dart:convert';

//  librerias importadas flutter
import '../../negocio/modelo/endidad/EntidadBase.dart';
//  librerias  proyecto

class Paginador<T extends EntidadBase> {
  int? paginaActual = 1;
  int? registrosPorPagina = 0;
  int? totalRegistros = 0;
  int? totalPaginas = 0;
  List<dynamic>? listaPagina = [];
  int? estatus;
  //  Cosntructor
  Paginador(
      {this.paginaActual,
      this.registrosPorPagina,
      this.totalRegistros,
      this.totalPaginas,
      this.listaPagina,
      this.estatus}) {
    paginaActual = paginaActual ?? 1;
    registrosPorPagina = registrosPorPagina ?? 10;
    totalRegistros = totalRegistros ?? 0;
    totalPaginas = totalPaginas ?? 0;
    estatus == estatus ?? 0;
    listaPagina = [];
  }

  Paginador<T> fromMap(Map<String, dynamic> map) {
    paginaActual = map["paginaActual"];
    registrosPorPagina = map["registrosPorPagina"];
    totalRegistros = map["totalRegistros"];
    totalPaginas = map["totalPaginas"];
    listaPagina = map["resultado"];
    estatus = map["estatus"];
    return this;
  }

  Map<String, dynamic> toMap() => {
        "paginaActual": paginaActual,
        "registrosPorPagina": registrosPorPagina,
        "totalRegistros": totalRegistros,
        "totalPaginas": totalPaginas,
        "resultado": listaPagina,
        "estatus": estatus,
      };
}
