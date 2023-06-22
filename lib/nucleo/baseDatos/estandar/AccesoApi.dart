//  librerias internas de flutter

import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto

import '../admin/IAccesoBD.dart';
import '../../servicios/ServiciosRest.dart';

class AccesoApi implements IAccesoBD {
  ConfiguracionAccesoBD? _configuracion;

  //  constructor
  AccesoApi() {
    iniciar();
  }
  // metodos
  @override
  iniciar() async {}
  // propiedades
  //
  //  obtener configuracion
  @override
  ConfiguracionAccesoBD get configuracion {
    return _configuracion!;
  }

  //  asignar  configuracion
  @override
  set configuracion(ConfiguracionAccesoBD configuracion) {
    _configuracion = configuracion;
  }

  @override
  abrir() async {}

  @override
  void cerrar() {}

  @override
  Future<dynamic> ejecutar(
      String nombreTabla, Map<String, String> parametros) async {
    dynamic cuerpo;
    Uri uri = generarUriParametros(nombreTabla, parametros);
    dynamic respuesta = await ServicioRest.get(uri);

    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    print(cuerpo.runtimeType.toString());
    //listaMap = json.decode(respuesta.body).cast<Map<String, dynamic>>();
    return cuerpo;
  }

  @override
  Future<dynamic> consultarTabla(String nombreTabla) async {
    dynamic cuerpo = [];
    // String url = generarUrl(nombreTabla, null);
    Uri uri = generarUri(nombreTabla, null);
    dynamic respuesta = await ServicioRest.get(uri);
    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    print(cuerpo.runtimeType.toString());
    //listaMap = json.decode(respuesta.body).cast<Map<String, dynamic>>();
    return cuerpo!;
  }

  @override
  //Future<Map<String, dynamic>> consultarPaginacionTabla(
  Future<dynamic> consultarPaginacionTabla(
      String nombreTabla, Map<String, dynamic> paginacion) async {
    // Map<String, dynamic>? resultado;
    dynamic cuerpo;
    // String url = generarUrl(nombreTabla, null);
    Uri uri = generarUri(nombreTabla, null, paginacion);
    dynamic respuesta = await ServicioRest.get(uri);
    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    print(cuerpo.runtimeType.toString());
    //listaMap = json.decode(respuesta.body).cast<Map<String, dynamic>>();
    return cuerpo;
  }

  @override
  Future<dynamic> filtrarTabla(String nombreTabla, Map<String, dynamic> map,
      String campo, dynamic valor) async {
    dynamic cuerpo;
    // String url = generarUrl(nombreTabla, valor);
    Uri uri =
        generarUri(nombreTabla, null, null, campo + "|" + valor.toString());
    dynamic respuesta = await ServicioRest.get(uri);
    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    print(cuerpo.runtimeType.toString());
    return cuerpo;
  }

  @override
  Future<Map<String, dynamic>> obtener(String nombreTabla,
      Map<String, dynamic> map, String campo, dynamic valor) async {
    Map<String, dynamic>? cuerpo;
    // String url = generarUrl(nombreTabla, valor);
    Uri uri = generarUri(nombreTabla, valor);
    dynamic respuesta = await ServicioRest.get(uri);
    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    return cuerpo!;
  }

  @override
  Future<Map<String, dynamic>> insertar(String nombreTabla,
      Map<String, dynamic> map, String campo, dynamic valor) async {
    Map<String, dynamic>? cuerpo;
    // String url = generarUrl(nombreTabla, null);
    Uri uri = generarUri(nombreTabla, null);
    print(json.encode(map));
    dynamic respuesta = await ServicioRest.post(uri, json.encode(map));
    print(respuesta.statusCode);
    if (respuesta.statusCode == 200 ||
        respuesta.statusCode ==
            201) // cuando  se presenta error es  el codigo 400,404 409
      cuerpo = json.decode(respuesta.body);
    return cuerpo!;
  }

  @override
  Future<dynamic> actualizar(String nombreTabla, Map<String, dynamic> map,
      String campo, dynamic valor) async {
    Map<String, dynamic>? cuerpo;
    // String url = generarUrl(nombreTabla, valor);
    Uri uri = generarUri(nombreTabla, valor);
    print(json.encode(map));
    dynamic respuesta = await ServicioRest.put(uri, json.encode(map));
    print(respuesta.statusCode);
    if (respuesta.statusCode !=
        204) // cuando  se presenta error el codigo 400,404 409
      map = cuerpo!;
    return map;
  }

  @override
  Future<Map<String, dynamic>> eliminar(String nombreTabla,
      Map<String, dynamic> map, String campo, dynamic valor) async {
    Map<String, dynamic>? cuerpo;
    // String url = generarUrl(nombreTabla, valor);
    Uri uri = generarUri(nombreTabla, valor);
    dynamic respuesta = await ServicioRest.delete(uri, json.encode(map));
    print(respuesta.statusCode);
    if (respuesta.statusCode ==
        200) // cuando  se presenta error el codigo 400,404 409
      //listaMap = json.decode(respuesta.body);
      return map;
    else
      return cuerpo!;
  }

  Uri generarUriParametros(
      String nombreTabla, Map<String, dynamic> parametros) {
    String complUrl = '';
    complUrl = configuracion.sitioApi!;
    complUrl += nombreTabla.toLowerCase();

    // if (parametros != "") complUrl += parametros;
    if (configuracion.llaveApi != null && configuracion.llaveApi != "")
      complUrl += "/" + configuracion.llaveApi! + "/";
    Uri uri;
    if (configuracion.protocolo == null ||
        configuracion.protocolo == '' ||
        configuracion.protocolo == 'http')
      uri = Uri.http(configuracion.dominioApi!, complUrl, parametros);
    else
      uri = Uri.https(configuracion.dominioApi!, complUrl, parametros);
    return uri;
  }

  Uri generarUri(String nombreTabla,
      [dynamic valor, dynamic paginacion, String filtro = ""]) {
    String complUrl = '';
    complUrl = configuracion.sitioApi!;
    complUrl += nombreTabla.toLowerCase();
    if (configuracion.parmetros != null && configuracion.parmetros != "") {
      complUrl += configuracion.parmetros;
      if (configuracion.filtro != null && configuracion.filtro != "")
        complUrl += "/" + configuracion.filtro;
    } else {
      if (valor != null && valor != 0)
        complUrl += "/" + valor.toString();
      else {
        if (paginacion != null &&
            paginacion.isNotEmpty &&
            paginacion["estatus"] == 1) {
          complUrl += "/" + paginacion["paginaActual"].toString();
          complUrl += "/" + paginacion["registrosPorPagina"].toString();
        }
        if (filtro != null && filtro != '') {
          if (paginacion != null &&
              paginacion.isNotEmpty &&
              paginacion["estatus"] == 1)
            complUrl += "/" + filtro;
          else
            complUrl += "//0/" + filtro;
        }
      }
    }
    if (configuracion.llaveApi != null && configuracion.llaveApi != "")
      complUrl += "/" + configuracion.llaveApi! + "/";
    Uri uri;
    if (configuracion.protocolo == null ||
        configuracion.protocolo == '' ||
        configuracion.protocolo == 'http')
      uri = Uri.http(
        configuracion.dominioApi!,
        complUrl,
      );
    else
      uri = Uri.https(configuracion.dominioApi!, complUrl);

    return uri;
  }

  //  obseleta
  String generarUrl(String nombreTabla, int? id) {
    String url = "";
    url = configuracion.dominioApi! + configuracion.sitioApi!;
    if (configuracion.parmetros != null && configuracion.parmetros != "") {
      url += configuracion.parmetros;
      if (configuracion.filtro != null && configuracion.filtro != "")
        url += "/" + configuracion.filtro;
    } else {
      url += nombreTabla.toLowerCase();
      if (id != null && id != 0)
        url += "/" + id.toString();
      else {
        if (configuracion.filtro != null && configuracion.filtro != '')
          url += "/0/" + configuracion.filtro;
      }
    }
    if (configuracion.llaveApi != null && configuracion.llaveApi != "")
      url += "/" + configuracion.llaveApi! + "/";
    return url;
  }

  @override
  Future<dynamic> sqlConsultar(String sql) async {
    List<dynamic> listaMap = [];
    return listaMap;
  }

  @override
  Future<dynamic> sqlInsertar(String sql) async {
    List<dynamic> listaMap = [];
    return listaMap;
  }

  @override
  Future<dynamic> sqlActualizar(String sql) async {
    List<dynamic> listaMap = [];
    return listaMap;
  }

  @override
  Future<dynamic> sqlEliminar(String sql) async {
    List<dynamic> listaMap = [];
    return listaMap;
  }
}
