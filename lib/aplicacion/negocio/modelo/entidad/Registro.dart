//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class Registro extends EntidadBase {
  //    variables
  //    propiedades

  int? estatus;
  Registro({
    id,
    nombre,
    clave,
    llave,
    nombreTabla,
    campoLLave,
    this.estatus,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'Registros',
          campoLLave: 'id',
        );

  //    métodos
  @override
  factory Registro.fromMap(Map<String, dynamic> map) => new Registro(
        id: map["id"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],

        // estatus: int.parse(map["estatus"].toString()),
      );
  @override
  Registro fromMap(Map<String, dynamic> map) {
    id = map["id"];
    llave = map["llave"];
    clave = map["clave"];
    nombre = map["nombre"];

    // estatus = int.parse(map["estatus"].toString());
    return this;
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "llave": llave,
        "clave": clave,
        "nombre": nombre,
        "estatus": estatus,
      };

  String sqlTabla() {
    String sql = "CREATE TABLE if not exists  " +
        nombreTabla! +
        " ("
            "id INTEGER PRIMARY KEY ,"
            "llave   TEXT , "
            "clave   TEXT , "
            "nombre   TEXT , "
            "idMesa   INTEGER , "
            "idVendedor   INTEGER, "
            "idCliente   INTEGER , "
            "cantidadRegistro   INTEGER, "
            "importeRegistro   REAL , "
            "fechaRegistro   TEXT, "
            "tipoRegistro   TEXT , "
            "referencia   TEXT, "
            "fechaEstatus   TEXT , "
            "estatus   INTEGER )";
    return sql;
  }

  @override
  Registro iniciar() {
    Registro entidad = Registro();
    entidad.id = 0;
    entidad.llave = "";
    entidad.clave = "";
    entidad.nombre = "";

    entidad.estatus = 1;
    return entidad;
  }

  String toJson() => json.encode(this.toMap());
  Registro fromJson(String cadenaJson) => this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  @override
  List<Registro> mapTolista(List<dynamic> listaMapa) {
    List<Registro> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  @override
  List<Registro> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<Registro> lista = mapTolista(listaMap);
    return lista;
  }
}
