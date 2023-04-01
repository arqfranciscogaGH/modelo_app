//  librerias internas de flutter

import 'dart:convert';
import 'dart:ffi';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class Producto extends EntidadBase {
  //    variables
  //    propiedades

  int? precio;
  int? existencia;
  String? descripcion;
  String? clase;
  String? subclase;
  String? fechaEstatus;
  int? estatus;
  Producto({
    id,
    nombre,
    clave,
    llave,
    nombreTabla,
    campoLLave,
    this.precio,
    this.existencia,
    this.descripcion,
    this.clase,
    this.subclase,
    this.fechaEstatus,
    this.estatus,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'Productos',
          campoLLave: 'id',
          incrementar: false,
        );

  //    métodos
  @override
  factory Producto.fromMap(Map<String, dynamic> map) => new Producto(
        id: map["id"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],
        precio: int.parse(map["precio"].toString()),
        existencia: map["existencia"],
        descripcion: map["descripcion"],
        clase: map["clase"],
        subclase: map["subclase"],
        fechaEstatus: map["fechaEstatus"],
        estatus: int.parse(map["estatus"].toString()),
      );
  @override
  Producto fromMap(Map<String, dynamic> map) {
    id = map["id"];
    llave = map["llave"];
    clave = map["clave"];
    nombre = map["nombre"];

    precio = int.parse(map["precio"].toString());
    existencia = map["existencia"];
    descripcion = map["descripcion"];
    clase = map["clase"];
    subclase = map["subclase"];
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
        "precio": precio,
        "existencia": existencia,
        "descripcion": descripcion,
        "clase": clase,
        "subclase": subclase,
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
            "precio   INTEGER , "
            "existencia   INTEGER, "
            "descripcion   TEXT, "
            "clase   TEXT , "
            "subclase   TEXT , "
            "fechaEstatus   TEXT , "
            "estatus   INTEGER )";
    return sql;
  }

  @override
  Producto iniciar() {
    Producto entidad = Producto();
    entidad.id = null;
    entidad.llave = "";
    entidad.clave = "";
    entidad.nombre = "";
    entidad.clase = "";
    entidad.subclase = "";

    entidad.precio = 0;
    entidad.existencia = 0;
    entidad.descripcion = "";

    entidad.fechaEstatus = DateTime.now().toString();
    entidad.estatus = 1;
    return entidad;
  }

  String toJson() => json.encode(this.toMap());
  Producto fromJson(String cadenaJson) => this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  @override
  List<Producto> mapTolista(List<dynamic> listaMapa) {
    List<Producto> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  @override
  List<Producto> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<Producto> lista = mapTolista(listaMap);
    return lista;
  }
}
