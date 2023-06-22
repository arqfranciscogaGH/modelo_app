//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

import 'package:intl/intl.dart';

//  librerias  proyecto

import '../../../../nucleo/negocio/modelo/endidad/EntidadBase.dart';

class CuentaUsuario extends EntidadBase {
  //    variables
  //    propiedades

  String? cuenta;
  String? contrasena;
  String? correo;
  String? telefono;
  String? fechaNacimiento;
  String? genero;
  String? rutaFoto;
  String? urlFoto;
  String? idEstacionTrabajo;
  int? idUsuarioSuperior;
  int? idIdioma;
  int? sesiones;
  int? intentos;
  String? perfiles;
  String? grupos;
  String? privilegios;
  int? expira;
  int? idSuscriptor;
  String? tema;
  int? idEstatusUsuario;
  int? activo;
  String? fechaRegistro;
  String? fechaVigencia;
  String? fechaCambioEstatus;
  // int estatus;
  CuentaUsuario({
    id,
    nombre,
    clave,
    llave,
    this.cuenta,
    this.contrasena,
    this.correo,
    this.telefono,
    this.fechaNacimiento,
    this.rutaFoto,
    this.urlFoto,
    this.idEstacionTrabajo,
    this.idUsuarioSuperior,
    this.idIdioma,
    this.sesiones,
    this.intentos,
    this.grupos,
    this.perfiles,
    this.privilegios,
    this.expira,
    this.idSuscriptor,
    this.tema,
    this.idEstatusUsuario,
    this.activo,
    this.fechaRegistro,
    this.fechaVigencia,
    this.fechaCambioEstatus,
    // this.estatus,
  }) : super(
          id: id,
          clave: clave,
          llave: llave,
          nombre: nombre,
          nombreTabla: 'CuentaUsuarios',
          campoLLave: 'IdUsuario',
          incrementar: false,
        );
  //    métodos

  factory CuentaUsuario.fromMap(Map<String, dynamic> map) => new CuentaUsuario(
        id: map["IdUsuario"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],
        cuenta: map["Cuenta"],
        contrasena: map["Contrasena"],
        correo: map["correo"],
        telefono: map["telefono"],
        fechaNacimiento: map["fechaNacimiento"],
        rutaFoto: map["rutaFoto"],
        urlFoto: map["urlFoto"],
        idEstacionTrabajo: map["IdEstacionTrabajo"],
        idUsuarioSuperior: map["IdUsuarioSuperior"],

        idIdioma: map["IdIdioma"],
        sesiones: map["Sesiones"],
        intentos: map["Intentos"],
        grupos: map["Grupos"],
        perfiles: map["Perfiles"],
        privilegios: map["Privilegios"],
        expira: map["Expira"],
        idSuscriptor: map["IdSuscriptor"],
        tema: map["Tema"],
        idEstatusUsuario: map["IdEstatusUsuario"],

        activo: map["Activo"] == true ? 1 : 0,

        fechaRegistro: map["FechaRegistro"],
        fechaVigencia: map["fechaVigencia"],
        fechaCambioEstatus: map["FechaCambioEstatus"],
        // estatus: int.parse(map["estatus"].toString()),
      );

  CuentaUsuario fromMap(Map<String, dynamic> map) => new CuentaUsuario(
        id: map["IdUsuario"],
        llave: map["llave"],
        clave: map["clave"],
        nombre: map["nombre"],

        cuenta: map["Cuenta"],
        contrasena: map["Contrasena"],
        correo: map["correo"],
        telefono: map["telefono"],
        fechaNacimiento: map["fechaNacimiento"],
        rutaFoto: map["rutaFoto"],
        urlFoto: map["urlFoto"],
        idEstacionTrabajo: map["IdEstacionTrabajo"],
        idUsuarioSuperior: map["IdUsuarioSuperior"],

        idIdioma: map["IdIdioma"],
        sesiones: map["Sesiones"],
        intentos: map["Intentos"],
        grupos: map["Grupos"],
        perfiles: map["Perfiles"],
        privilegios: map["Privilegios"],
        expira: map["Expira"],
        idSuscriptor: map["IdSuscriptor"],
        tema: map["Tema"],
        idEstatusUsuario: map["IdEstatusUsuario"],
        activo: map["Activo"] == true ? 1 : 0,

        fechaRegistro: map["FechaRegistro"],
        fechaVigencia: map["fechaVigencia"],
        fechaCambioEstatus: map["FechaCambioEstatus"],
        // estatus: int.parse(map["estatus"].toString()),
      );
  Map<String, dynamic> toMap() => {
        "IdUsuario": id,
        "llave": llave,
        "clave": clave,
        "nombre": nombre,
        "Cuenta": cuenta,
        "Contrasena": contrasena,
        "correo": correo,
        "telefono": telefono,
        "fechaNacimiento": fechaNacimiento,
        "rutaFoto": rutaFoto,
        "urlFoto": urlFoto,
        "IdEstacionTrabajo": idEstacionTrabajo,
        "IdUsuarioSuperior": idUsuarioSuperior,
        "IdIdioma": idIdioma,
        "Sesiones": sesiones,
        "Intentos": intentos,
        "Grupos": grupos,
        "Perfiles": perfiles,
        "Privilegios": privilegios,
        "Expira": expira,
        "IdSuscriptor": idSuscriptor,
        "Tema": tema,
        "IdEstatusUsuario": idEstatusUsuario,
        "Activo": activo,
        "fechaRegistro": fechaRegistro,
        "fechaVigencia": fechaVigencia,
        "fechaCambioEstatus": fechaCambioEstatus,
      };
  String sqlTabla() {
    String sql = "CREATE TABLE if not exists  " +
        nombreTabla! +
        " ("
            "IdUsuario INTEGER PRIMARY KEY AUTOINCREMENT,"
            "llave   TEXT , "
            "clave   TEXT , "
            "nombre   TEXT , "
            "cuenta    TEXT , "
            "contrasena   TEXT, "
            "correo   TEXT, "
            "telefono   TEXT, "
            "fechaNacimiento   TEXT, "
            "rutaFoto  TEXT , "
            "urlFoto  TEXT , "
            "idEstacionTrabajo   TEXT , "
            "idUsuarioSuperior   INTEGER , "
            "idIdioma   INTEGER , "
            "sesiones   INTEGER , "
            "intentos   INTEGER , "
            "grupos   TEXT , "
            "perfiles   TEXT , "
            "privilegios   TEXT , "
            "expira   INTEGER , "
            "idSuscriptor   INTEGER, "
            "tema   TEXT , "
            "idEstatusUsuario   INTEGER , "
            "fechaRegistro   TEXT , "
            "fechaVigencia   TEXT , "
            "fechaCambioEstatus   TEXT , "
            "Activo   INTEGER , ) ";

    return sql;
  }

  CuentaUsuario iniciar() {
    CuentaUsuario entidad = CuentaUsuario();
    entidad.id = 0;
    entidad.llave = "";
    entidad.clave = "";
    entidad.nombre = "";
    entidad.cuenta = "";
    entidad.contrasena = "";
    entidad.correo = "";
    entidad.telefono = "";
    entidad.fechaNacimiento = "";
    entidad.rutaFoto = "";
    entidad.urlFoto = "";
    entidad.idEstacionTrabajo = "";
    entidad.idUsuarioSuperior = 0;
    entidad.idEstatusUsuario = 0;
    entidad.idIdioma = 0;
    entidad.intentos = 3;
    entidad.sesiones = 0;
    entidad.grupos = "";
    entidad.perfiles = "";
    entidad.privilegios = "0";
    entidad.expira = 0;
    entidad.idSuscriptor = 0;
    entidad.tema = "";
    entidad.fechaRegistro = "";
    entidad.fechaVigencia = "";
    entidad.fechaCambioEstatus = "";
    entidad.activo = 1;
    return entidad;
  }

  String toJson() => json.encode(this.toMap());
  CuentaUsuario fromJson(String cadenaJson) =>
      this.fromMap(json.decode(cadenaJson));

  Map<String, dynamic> fromJsonToMap(String cadenaJson) =>
      json.decode(cadenaJson);

  List<CuentaUsuario> mapTolista(List<dynamic> listaMapa) {
    List<CuentaUsuario> lista = listaMapa.isNotEmpty
        ? listaMapa.map((c) => this.iniciar().fromMap(c)).toList()
        : [];
    return lista;
  }

  List<CuentaUsuario> jsonToList(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<CuentaUsuario> lista = mapTolista(listaMap);
    return lista;
  }
}
