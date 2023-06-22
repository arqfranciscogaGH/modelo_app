//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class VentaProducto extends EntidadBase {
  //    variables
  //    propiedades

  int? idVenta;
  int? idProducto;
  String? nombreProducto;
  int? cantidad;
  double? importe;
  double? precio;
  double? costo;
  String? referencia;
  String? fechaEstatus;
  int? estatus;
  VentaProducto({
    id,
    nombre,
    clave,
    llave,
    nombreTabla,
    campoLLave,
    this.idVenta,
    this.idProducto,
    this.nombreProducto,
    this.cantidad,
    this.importe,
    this.precio,
    this.costo,
    this.referencia,
    this.fechaEstatus,
    this.estatus,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'VentaProductos',
          campoLLave: 'id',
          incrementar: false,
        );
  //    métodos

  factory VentaProducto.fromMap(Map<String, dynamic> map) => new VentaProducto(
        id: map["id"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],
        idVenta: map["idVenta"],
        idProducto: map["idProducto"],
        nombreProducto: map["nombreProducto"],
        cantidad: map["cantidad"],
        importe: map["importe"],
        precio: map["precio"],
        costo: map["costo"],
        referencia: map["referencia"],
        fechaEstatus: map["fechaEstatus"],
        estatus: int.parse(map["estatus"].toString()),
      );

  VentaProducto fromMap(Map<String, dynamic> map) {
    id = map["id"];
    llave = map["llave"];
    clave = map["clave"];
    nombre = map["nombre"];
    idVenta = map["idVenta"];
    idProducto = map["idProducto"];
    nombreProducto = map["nombreProducto"];
    cantidad = map["cantidad"];
    importe = map["importe"];
    precio = map["precio"];
    costo = map["costo"];
    referencia = map["referencia"];

    fechaEstatus = map["fechaEstatus"];
    estatus = int.parse(map["estatus"].toString());
    return this;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "llave": llave,
        "clave": clave,
        "nombre": nombre,
        "idVenta": idVenta,
        "idProducto": idProducto,
        // "nombreProducto": nombreProducto,
        "cantidad": cantidad,
        "importe": importe,
        "precio": precio,
        "costo": costo,
        "referencia": referencia,
        "fechaEstatus": fechaEstatus,
        "estatus": estatus,
      };

  String sqlTabla() {
    String sql = "CREATE TABLE if not exists  " +
        nombreTabla! +
        " ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "llave   TEXT , "
            "clave   TEXT , "
            "nombre   TEXT , "
            "idVenta   INTEGER , "
            "idProducto   INTEGER , "
            "cantidad   INTEGER, "
            "importe   REAL , "
            "precio   REAL , "
            "costo   REAL , "
            "referencia   TEXT, "
            "fechaEstatus   TEXT , "
            "estatus   INTEGER )";
    return sql;
  }

  VentaProducto iniciar() {
    VentaProducto e = VentaProducto();
    e.id = null;
    e.llave = "";
    e.clave = "";
    e.nombre = "";
    e.idVenta = 0;
    e.idProducto = 0;
    e.nombreProducto = "";
    e.cantidad = 0;
    e.importe = 0;

    e.precio = 0;
    e.costo = 0;
    e.referencia = "";

    e.fechaEstatus = DateTime.now().toString();
    e.estatus = 1;
    return e;
  }

  String toJson() => json.encode(this.toMap());
  VentaProducto fromJson(String cadenaJson) =>
      this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  List<VentaProducto> mapTolista(List<dynamic> listaMapa) {
    List<VentaProducto> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  List<VentaProducto> jsonToList(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<VentaProducto> lista = mapTolista(listaMap);
    return lista;
  }
}
