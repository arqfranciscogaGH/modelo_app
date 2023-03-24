//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class Autenticacion extends EntidadBase {
  //    variables
  //    propiedades
  String? cuenta;
  String? operacion;
  String? estacionTrabajo;
  int? tiempo;
  var diasVigencia;

  Autenticacion({
    id,
    nombre,
    clave,
    llave,
    nombreTabla,
    campoLLave,
    this.cuenta,
    this.operacion,
    this.estacionTrabajo,
    this.tiempo,
    this.diasVigencia,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'Autenticacion',
          campoLLave: 'id',
        );

  //    métodos
  @override
  factory Autenticacion.fromMap(Map<String, dynamic> map) => new Autenticacion(
        id: map["id"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],
        cuenta: map["cuenta"],
        operacion: map["operacion"],
        estacionTrabajo: map["estacionTrabajo"],
        tiempo: int.parse(map["tiempo"].toString()),
        diasVigencia: int.parse(map["diasVigencia"].toString()),
        // estatus: int.parse(map["estatus"].toString()),
      );
  @override
  Autenticacion fromMap(Map<String, dynamic> map) {
    id = map["id"];
    llave = map["llave"];
    clave = map["clave"];
    nombre = map["nombre"];
    cuenta = map["cuenta"];
    operacion = map["operacion"];
    estacionTrabajo = map["estacionTrabajo"];
    tiempo = int.parse(map["tiempo"].toString());
    diasVigencia = int.parse(map["diasVigencia"].toString());
    // estatus = int.parse(map["estatus"].toString());
    return this;
  }

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "llave": llave,
        "clave": clave,
        "nombre": nombre,
        "cuenta": cuenta,
        "operacion": operacion,
        "estacionTrabajo": estacionTrabajo,
        "tiempo": tiempo,
        "diasVigencia": diasVigencia,
        // "estatus": estatus,
      };

  String sqlTabla() {
    String sql = "CREATE TABLE if not exists  " +
        nombreTabla! +
        " ("
            "id INTEGER PRIMARY KEY ,"
            "llave   TEXT , "
            "clave   TEXT , "
            "nombre   TEXT , "
            "cuenta   INTEGER , "
            "operacion   TEXT, "
            "estacionTrabajo   TEXT , "
            "estatus   INTEGER )";
    return sql;
  }

  @override
  Autenticacion iniciar() {
    Autenticacion entidad = Autenticacion();
    entidad.id = 0;
    entidad.llave = "";
    entidad.clave = "";
    entidad.nombre = "";
    entidad.cuenta = "";
    entidad.operacion = "";
    entidad.estacionTrabajo = "";

    // entidad.estatus = 1;
    return entidad;
  }

  String toJson() => json.encode(this.toMap());
  Autenticacion fromJson(String cadenaJson) =>
      this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  @override
  List<Autenticacion> mapTolista(List<dynamic> listaMapa) {
    List<Autenticacion> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  @override
  List<Autenticacion> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<Autenticacion> lista = mapTolista(listaMap);
    return lista;
  }
}
