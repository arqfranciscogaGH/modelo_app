//  librerias internas de flutter
import 'package:flutter/material.dart';

import 'dart:convert';

//  librerias  proyecto

import 'EntidadBase.dart';

// import 'package:charts_flutter/flutter.dart' as charts;

class ElementoSerie extends EntidadBase {
  String? serie;
  String? titulo;
  int? valor;
  int? metrica;
  double? x;
  double? y;
  dynamic color;
  // charts.Color? colorG;
  dynamic colorG;
  int? activo;
  ElementoSerie(
      {id,
      nombre,
      clave,
      llave,
      descripcion,
      nombreTabla,
      campoLLave,
      this.titulo,
      this.serie,
      this.valor,
      /* @required  */ this.metrica,
      this.color,
      this.colorG,
      this.x,
      this.y,
      this.activo})
      : super(
          id: id,
          nombre: nombre,
          clave: clave,
          llave: llave,
          descripcion: descripcion,
          // nombreTabla: nombreTabla!,
          // campoLLave: campoLLave!,
        );

  ElementoSerie iniciar() {
    ElementoSerie e = ElementoSerie();
    e.nombreTabla = 'ElementoSerie';
    e.campoLLave = 'id';
    e.incrementar = false;
    e.clave = "";
    e.llave = " ";
    e.nombre = "";
    e.descripcion = "";
    return e;
  }

  factory ElementoSerie.fromMap(Map<String, dynamic> map) => ElementoSerie(
        titulo: map["titulo"],
        serie: map["serie"],
        metrica: map["metrica"],
        //metrica: double.parse(map["metrica"].toString()),
        valor: map["valor"],
        color: map["color"],
        // colorN: map["colorN"],
        x: map["x"],
        y: map["y"],
        activo: int.parse(map["activo"].toString()),
      );
  ElementoSerie fromMap(Map<String, dynamic> map) => ElementoSerie(
        titulo: map["titulo"],
        serie: map["serie"],
        metrica: map["metrica"],
        //metrica: double.parse(map["metrica"].toString()),
        valor: map["valor"],
        color: map["color"],
        colorG: map["colorG"],
        x: map["x"],
        y: map["y"],
        activo: int.parse(map["activo"].toString()),
      );
  Map<String, dynamic> toMap() => {
        "titulo": titulo,
        "serie": serie,
        "metrica": metrica,
        "valor": valor,
        "color": color,
        "colorG": colorG,
        "x": x,
        "y": y,
        "activo": activo,
      };

  String toJson() => json.encode(this.toMap());
  ElementoSerie fromJson(String cadenaJson) =>
      this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  List<ElementoSerie> mapTolista(List<dynamic> listaMapa) {
    List<ElementoSerie> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  List<ElementoSerie> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<ElementoSerie> lista = mapTolista(listaMap);
    return lista;
  }

  String sqlTabla() {
    String sql = "CREATE TABLE if not exists ";
    sql += super.nombreTabla!;
    sql += " ("
        "id INTEGER PRIMARY KEY autoincrement ,"
        "titulo  TEXT , "
        "serie  TEXT , "
        "metrica  REAL , "
        "valor INTEGER , "
        "color TEXT , "
        // "colorN TEXT , "
        "x REAL , "
        "y REAL , "
        "activo INTEGER )";

    return sql;
  }
}
