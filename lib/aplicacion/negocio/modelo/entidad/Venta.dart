//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class Venta extends EntidadBase {
  //    variables
  //    propiedades

  int? idMesa;
  int? idVendedor;
  int? idCliente;
  String? nombreCliente;
  String? fechaVenta;
  String? tipoVenta;
  String? formaPago;
  String? referencia;
  int? cantidadVenta;
  double? importeVenta;
  double? importePagado;
  double? importeCambio;
  double? saldo;
  String? fechaEstatus;
  int? estatus;
  Venta({
    id,
    nombre,
    clave,
    llave,
    nombreTabla,
    campoLLave,
    this.idMesa,
    this.idVendedor,
    this.idCliente,
    this.nombreCliente,
    this.fechaVenta,
    this.tipoVenta,
    this.formaPago,
    this.referencia,
    this.cantidadVenta,
    this.importeVenta,
    this.importePagado,
    this.importeCambio,
    this.saldo,
    this.fechaEstatus,
    this.estatus,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'Ventas',
          campoLLave: 'id',
          incrementar: false,
        );

  //    métodos
  @override
  factory Venta.fromMap(Map<String, dynamic> map) => new Venta(
        id: map["id"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],
        idMesa: map["idMesa"],
        idVendedor: map["idVendedor"],
        idCliente: map["idCliente"],
        // nombreCliente: map["nombreCliente"],
        fechaVenta: map["fechaVenta"],
        tipoVenta: map["tipoVenta"],
        formaPago: map["formaPago"],
        referencia: map["referencia"],
        cantidadVenta: map["cantidadVenta"],
        importeVenta: map["importeVenta"],
        importePagado: map["importePagado"],
        importeCambio: map["importeCambio"],
        saldo: map["saldo"],
        fechaEstatus: map["fechaEstatus"],
        estatus: int.parse(map["estatus"].toString()),
      );

  @override
  Venta fromMap(Map<String, dynamic> map) {
    id = map["id"];
    llave = map["llave"];
    clave = map["clave"];
    nombre = map["nombre"];

    idMesa = map["idMesa"];
    idVendedor = map["idVendedor"];
    idCliente = map["idCliente"];
    // nombreCliente = map["nombreCliente"];
    fechaVenta = map["fechaVenta"];
    tipoVenta = map["tipoVenta"];
    formaPago = map["formaPago"];
    referencia = map["referencia"];

    cantidadVenta = map["cantidadVenta"];
    importeVenta = map["importeVenta"];
    importePagado = map["importePagado"];
    importeCambio = map["importeCambio"];
    saldo = map["saldo"];
    fechaEstatus = map["fechaEstatus"];
    estatus = int.parse(map["estatus"].toString());
    return this;
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "llave": llave,
        "clave": clave,
        "nombre": nombre,
        "idMesa": idMesa,
        "idVendedor": idVendedor,
        "idCliente": idCliente,
        // "nombreCliente": nombreCliente,
        "fechaVenta": fechaVenta,
        "tipoVenta": tipoVenta,
        "formaPago": formaPago,
        "referencia": referencia,
        "cantidadVenta": cantidadVenta,
        "importeVenta": importeVenta,
        "importePagado": importePagado,
        "importeCambio": importeCambio,
        "saldo": saldo,
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
            "idMesa   INTEGER , "
            "idVendedor   INTEGER, "
            "idCliente   INTEGER , "
            "fechaVenta   TEXT, "
            "tipoVenta   TEXT , "
            "formaPago   TEXT , "
            "referencia   TEXT, "
            "cantidadVenta   INTEGER, "
            "importeVenta   REAL , "
            "importePagado   REAL, "
            "importeCambio   REAL , "
            "saldo   REAL, "
            "fechaEstatus   TEXT , "
            "estatus   INTEGER )";
    return sql;
  }

  @override
  Venta iniciar() {
    Venta e = Venta();
    e.id = null;
    e.llave = "";
    e.clave = "";
    e.nombre = "";
    e.idMesa = 0;
    e.idVendedor = 0;
    e.idCliente = 0;
    e.nombreCliente = "";
    e.fechaVenta = "";
    e.tipoVenta = "";
    e.formaPago = "";
    e.referencia = "";
    e.cantidadVenta = 0;
    e.importeVenta = 0;
    e.importePagado = 0;
    e.importeCambio = 0;
    e.saldo = 0;

    e.fechaEstatus = DateTime.now().toString();
    e.estatus = 1;
    return e;
  }

  String toJson() => json.encode(this.toMap());
  Venta fromJson(String cadenaJson) => this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  @override
  List<Venta> mapTolista(List<dynamic> listaMapa) {
    List<Venta> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  @override
  List<Venta> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<Venta> lista = mapTolista(listaMap);
    return lista;
  }
}
