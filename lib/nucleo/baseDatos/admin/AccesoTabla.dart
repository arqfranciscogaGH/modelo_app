//  librerias internas de flutter

import 'dart:async';
import 'dart:convert';

//  librerias importadas flutter

//  librerias  proyecto
import '../../negocio/modelo/endidad/EntidadBase.dart';
import 'IAccesoBD.dart';
import 'ConfiguracionAccesoBD.dart';
import 'AdministradorAcceso.dart';
import '../../negocio/controladorEstado/ControlEstadoUI.dart';
import 'Paginador.dart';

class AccesoTabla<T extends EntidadBase> {
  // variables

  ConfiguracionAccesoBD? configuracion;
  Paginador<T>? _paginador = Paginador<T>();
  T? _entidad;
  List<T> _lista = [];
  int consecutivo = 0;
  String parametros = "";
  IAccesoBD? _abd;
  EntidadResultado? _resultado;
  EntidadRegistro? _registro;
  ControlEstadoUI? controlEstadoUI;

  // Map<String, dynamic>? _registro ={};
  // List<dynamic>? _tabla= [];

  /*   ControlLista<T> elementos; */

  //  Cosntructor
  // AccesoTabla({required this.claseEntidad, this.configuracion}) {
  //   _abd = AdministradorAcceso.obtener(this.configuracion!);
  //   _resultado = EntidadResultado();
  //   _registro = EntidadRegistro();
  //   _resultado!.campoLLave = claseEntidad.campoLLave;
  //   entidad = claseEntidad;
  //   _paginador = Paginador<T>();

  //   if (configuracion!.persitenciaPorDefecto != true) _abd!.iniciar();
  // }

  iniciar(T entidad, ConfiguracionAccesoBD configuracion) {
    this.configuracion = configuracion;
    // agregar  tabla  a lista  de tablas  en c onfiguración
    if (configuracion.tablas == null) configuracion.tablas = [];
    configuracion.tablas!.add(entidad);
    _abd = AdministradorAcceso.obtener(this.configuracion!);
    _resultado = EntidadResultado();
    _registro = EntidadRegistro();
    _resultado!.campoLLave = entidad.campoLLave;
    this.entidad = entidad;
    _paginador = Paginador<T>();

    if (configuracion!.persitenciaPorDefecto != true) _abd!.iniciar();
  }

  //  propiedades

//  obtener paginador
  Paginador<T> get paginador {
    return _paginador!;
  }

//  obtener lista tabla  map texto, se obtiene  resultado  de api o db
  EntidadResultado get resultado {
    return _resultado!;
  }

  //  asignar  lista tabla  map de texto, se obtiene  resultado  de api o db

  set resultado(EntidadResultado resultado) {
    _resultado = resultado;
    // if (tabla.datos != null) _lista = mapTolista(tabla.datos);
  }

  //  obtener  map de entidad registro texto

  EntidadRegistro get registro {
    return _registro!;
  }

  //  asignar map a entidad  registro texto
  set registro(EntidadRegistro r) {
    registro = r;
    _entidad!.fromMap(registro.datos);
  }

  //  obtener entidad

  T get entidad {
    return _entidad!;
  }

  //  asignar entidad
  set entidad(T e) {
    _entidad = e;
    registro.datos = e.toMap();
  }

//  obtener lista  map texto, se obtiene  resultado  de api o db
  List<T> get lista {
    List<T>? listaT;
    if (resultado.datos != null) listaT = mapTolista(resultado.datos);
    return listaT!;
  }

  //  asignar  lista  map de texto, se obtiene  resultado  de api o db
  set lista(List<dynamic> lista) {
    // _lista = lista as List<T>;
    resultado.datos = lista.map((c) => c.toMap()).toList();
  }

  @override
  void dispose() {}

  dynamic iniciarEntidad() {
    return _entidad!.iniciar();
  }

  //  metodos conversion  lista de MAp  a   lista  de entidades

  List<T> mapTolista(List<dynamic> listaMapa) {
    List<T> listaT = listaMapa != null && listaMapa.isNotEmpty
        ? this.entidad.mapTolista(listaMapa) as List<T>
        : [];
    return listaT;
  }

  //  metodos conversion  lista  de entidades  a  lista  MAP
  List<dynamic> listaToMap() {
    return lista.map((c) => c.toMap()).toList();
  }

  //  metodos conversion  lista  de entidades  a  cadena json

  String listaToJson() {
    return json.encode(this.listaToMap());
  }

  // metodos conversion cadena Json a   lista  de entidades

  List<dynamic> jsonToLista(String cadenaJson) {
    List<dynamic> listaMap = json.decode(cadenaJson);
    List<dynamic> listaT = mapTolista(listaMap);
    return listaT;
  }

  //  metodos  ABC  tablas

  Future<dynamic> ejecutar(T e, Map<String, String> parametros,
      [Function? metodoRespuesta = null]) async {
    dynamic respuesta;
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.consultar, eEstatus.iniciado);
    _abd!.configuracion = this.configuracion!;
    respuesta = await _abd!.ejecutar(e.nombreTabla!, parametros);
    if (metodoRespuesta != null)
      metodoRespuesta(lista);
    else if (controlEstadoUI != null)
      controlEstadoUI!.actualizarUI(eProceso.consultar, eEstatus.consultado);

    return respuesta;
  }

  Future<dynamic> consultarTabla(T e,
      [Function? metodoRespuesta = null]) async {
    dynamic respuesta;
    dynamic lista;
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.consultar, eEstatus.iniciado);
    _abd!.configuracion = this.configuracion!;

    respuesta = await _abd!.consultarTabla(e.nombreTabla!);
    // Timer(Duration(seconds: 30), () {
    //   print("Yeah, this line is printed after 3 seconds");
    // });
    if (respuesta != null) {
      print(respuesta.runtimeType.toString());
      resultado.datos = respuesta;
      lista = respuesta != null && respuesta.isNotEmpty
          ? respuesta.map((c) => e.iniciar().fromMap(c)).toList()
          : [];
      if (metodoRespuesta != null)
        metodoRespuesta(lista);
      else if (controlEstadoUI != null)
        controlEstadoUI!.actualizarUI(eProceso.consultar, eEstatus.consultado);
    }
    return lista;
  }

  // indicador estatus  1 paginacion  en api 0 paginacion en lista obnenida
  // 1   la api hace la paginacion (solo regresa los registros se usaran en cada pagina, pero cada avance o regreso de pagina  e deben obtenr los registros )
  // se debe usar simpres el metodo consultarPaginacionTabla
  // 0   accesoTabla hace localmente la paginación  usando la lista , pero es necesaio obtener todos los registros en la primer llamada , ventaja : más rápido la pagicion  y menos  llamadas a la api  , desventaja  más datos en meomoria  y mas viajan por internet (viaja toda los registros)
  // se debe usar la primera vez consultarPaginacionTabla  y  en avanzar y regresar el metodo paginarTabla
  Future<dynamic> consultarPaginacionTabla(T e,
      [Function? metodoRespuesta = null]) async {
    dynamic respuesta;
    dynamic lista;
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.consultar, eEstatus.iniciado);
    _abd!.configuracion = this.configuracion!;
    respuesta = await _abd!
        .consultarPaginacionTabla(e.nombreTabla!, _paginador!.toMap());
    // Timer(Duration(seconds: 30), () {
    //   print("Yeah, this line is printed after 3 seconds");
    // });
    lista = paginar(e, respuesta);

    if (metodoRespuesta != null)
      metodoRespuesta(lista);
    else if (controlEstadoUI != null)
      controlEstadoUI!.actualizarUI(eProceso.consultar, eEstatus.consultado);

    return lista;
  }

  Future<List<dynamic>> filtrarTabla(T e, String campo, dynamic valor,
      [Function? metodoRespuesta = null]) async {
    dynamic respuesta;
    List<dynamic> lista = [];
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.filtrar, eEstatus.iniciado);
    _abd!.configuracion = this.configuracion!;
    respuesta =
        await _abd!.filtrarTabla(e.nombreTabla!, e.toMap(), campo, valor);
    lista = paginar(e, respuesta);

    if (metodoRespuesta != null)
      metodoRespuesta(lista);
    else if (controlEstadoUI != null)
      controlEstadoUI!.actualizarUI(eProceso.filtrar, eEstatus.filtrado);
    // }
    return lista;
  }

  Future<dynamic> paginarTabla(T e, [Function? metodoRespuesta = null]) async {
    dynamic respuesta;
    dynamic lista;
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.consultar, eEstatus.iniciado);

    respuesta = resultado.datos;
    lista = paginar(e, respuesta);

    if (metodoRespuesta != null)
      metodoRespuesta(lista);
    else if (controlEstadoUI != null)
      controlEstadoUI!.actualizarUI(eProceso.consultar, eEstatus.consultado);

    return lista;
  }

  dynamic paginar(T e, dynamic respuesta) {
    dynamic lista;

    if (respuesta != null) {
      print(respuesta.runtimeType.toString());
      //  regresa  registro en tiene  paginador desde la api
      if (respuesta.runtimeType.toString().contains("Map")) {
        // asigna datos  de paginador
        paginador.fromMap(respuesta);
        if (paginador.listaPagina != null) {
          // asigna  datos de registros en MAP
          // resultado.datos = respuesta["listaPagina"];
          resultado.datos = paginador.listaPagina as List<dynamic>;
          // asigna datos  a lista  de pagina  en MAP
          lista = paginador.listaPagina;
        }
      }
      // solo regresa la lista  para  paginar
      else {
        // total  registros en lista
        paginador.totalRegistros = respuesta.length;
        // registros  por pagina  si es cero
        if (paginador.registrosPorPagina == 0)
          paginador.registrosPorPagina = paginador.totalRegistros;
        //  total de paginas
        paginador.totalPaginas =
            (paginador.totalRegistros! / paginador.registrosPorPagina!).ceil();

        // determina la pagina  donde  inciará
        if (paginador.paginaActual == 0)
          paginador.paginaActual = paginador.totalPaginas;

        // determina el numero de registros que se  saltará  considerando la  pagina  actual
        int salto = ((paginador.paginaActual as int) - 1) *
            (paginador.registrosPorPagina as int);
        // asigna  datos de registros en MAP
        resultado.datos = respuesta;
        // asigna datos  a lista  de pagina  en MAP
        lista =
            respuesta.skip(salto).take(paginador.registrosPorPagina).toList();
      }
      // convierte  en lista MAP a lista  de entidades
      lista = lista != null && lista.isNotEmpty
          ? lista.map((c) => e.iniciar().fromMap(c)).toList()
          : [];
      // asigna  resultado  de  paginador lista de entidades
      paginador.listaPagina = lista;
    }
    return lista;
  }

  Future<List<dynamic>> filtrarLista(T e, String campo, dynamic valor,
      [Function? metodoRespuesta = null]) async {
    List<dynamic> lista = resultado.datos;
    List<dynamic>? respuesta;
    if (lista != null && campo != '' && valor != '')
      respuesta = lista.where((s) => s[campo] == valor).toList();

    if (metodoRespuesta != null) metodoRespuesta(respuesta!);
    return respuesta!;
  }

  Future<T> obtener(T e, [Function? metodoRespuesta = null]) async {
    if (controlEstadoUI != null)
      controlEstadoUI!.iniciarProceso(eProceso.obtener, eEstatus.iniciado);
    _abd!.configuracion = this.configuracion!;
    dynamic respuesta = await _abd!.obtener(
        e.nombreTabla!, e.toMap(), e.campoLLave!, e.toMap()[e.campoLLave!]);
    if (respuesta != null) {
      this.entidad = e.fromMap(respuesta) as T;
      registro.datos = e.toMap();
      if (metodoRespuesta != null)
        metodoRespuesta(this.entidad);
      else if (controlEstadoUI != null)
        controlEstadoUI!.actualizarUI(eProceso.obtener, eEstatus.obtenido);
    }
    return this.entidad;
  }

  T seleccionar(T e, [Function? metodoRespuesta = null]) {
    T? entidad;
    if (e.id != null && e.id != 0)
      entidad = lista.firstWhere((s) => s.id == e.id);

    if (entidad == null) entidad = e;

    this.entidad = entidad;
    if (metodoRespuesta != null) metodoRespuesta(this.entidad);
    return this.entidad;
  }

  Future<Map<String, dynamic>> incrementarConsecutivo(T e) async {
    if (e.incrementar != null && e.incrementar == true)
      // && configuracion!.persitencia != ePersitencia.Memoria
      await consultarTabla(e);

    Map<String, dynamic> mapRegistro = e.toMap();

    // if (configuracion!.contadorRegistros == true) {
    //   registros = tabla.datos == null || tabla.datos.length == 0 ? 0 : lista.last.id??0;
    //   e.id = registros! + 1;
    // }
    // print ( 'incrementarConsecutivo' );
    // print ( e.campoLLave );
    if (configuracion!.contadorRegistros == true) {
      consecutivo = resultado.datos == null || resultado.datos.length == 0
          ? 0
          : resultado.datos.last[e.campoLLave!] ?? 0;
      consecutivo++;
      mapRegistro[e.campoLLave!] = consecutivo;
      e.id == consecutivo;
    }
    return mapRegistro;
  }

  Future<dynamic> insertar(T e, [Function? metodoRespuesta = null]) async {
    Map<String, dynamic> map = e.toMap();
    if (e.incrementar != null && e.incrementar == true) {
      map = await incrementarConsecutivo(e);
    }
    dynamic respuesta = await _abd!
        .insertar(e.nombreTabla!, map, e.campoLLave!, e.toMap()[e.campoLLave!]);
    if (respuesta != null) {
      this.entidad = e.fromMap(respuesta) as T;
      registro.datos = e.toMap();
      if (metodoRespuesta != null)
        metodoRespuesta(this.entidad);
      else if (controlEstadoUI != null)
        controlEstadoUI!.actualizarUI(eProceso.insertar, eEstatus.insertado);
    }
    return this.entidad;
  }

  Future<T> modificar(T e, [Function? metodoRespuesta = null]) async {
    dynamic respuesta = await _abd!.actualizar(
        e.nombreTabla!, e.toMap(), e.campoLLave!, e.toMap()[e.campoLLave!]);
    if (respuesta != null) {
      this.entidad = e.fromMap(respuesta) as T;
      registro.datos = e.toMap();
      if (metodoRespuesta != null)
        metodoRespuesta(this.entidad);
      else if (controlEstadoUI != null)
        controlEstadoUI!.actualizarUI(eProceso.modificar, eEstatus.modificado);
    }
    return this.entidad;
  }

  Future<dynamic> eliminar(T e, [Function? metodoRespuesta = null]) async {
    dynamic respuesta = await _abd!.eliminar(
        e.nombreTabla!, e.toMap(), e.campoLLave!, e.toMap()[e.campoLLave!]);
    if (respuesta != null) {
      this.entidad = e.fromMap(respuesta) as T;
      registro.datos = e.toMap();
      if (metodoRespuesta != null)
        metodoRespuesta(this.entidad);
      else if (controlEstadoUI != null)
        controlEstadoUI!.actualizarUI(eProceso.eliminar, eEstatus.eliminado);
    }
    return this.entidad;
  }

  /*  Future<List<dynamic>> obtenerListaCentral(T aEntidad) async {
      List<dynamic> lista;
      String url=generarUrl(aEntidad,"CL" );
      dynamic respuesta =await ServicioRest.get(url );
      if (respuesta.statusCode==200) 
          lista=jsonToList(respuesta.body);
      return  lista;
  } */

  // Future<T> insertarCentral(T aEntidad) async {
  //   String url = generarUrl(aEntidad, "I");
  //   print(aEntidad.toJson());
  //   dynamic respuesta = await ServicioRest.post(url, aEntidad.toJson());
  //   print(respuesta.statusCode);
  //   //    entidad=entidad.fromJson(respuesta.body);
  //   if (respuesta.statusCode != 201) //404 409
  //     aEntidad = aEntidad.fromJson(respuesta.body);
  //   else
  //     return null;

  //   return aEntidad;
  // }
/*   Future<T> obtenerCentral(T aEntidad) async {
        String url=generarUrl(aEntidad,"O");
        dynamic respuesta =await ServicioRest.get(url );
        if (respuesta.statusCode==200) 
           aEntidad.fromJson(respuesta.body);
        return  aEntidad;
  } */

  // Future<T> actualizarCentral(T aEntidad) async {
  //   String url = generarUrl(aEntidad, "A");
  //   dynamic respuesta = await ServicioRest.put(url, aEntidad.toJson());
  //   return aEntidad;
  // }

  // Future<T> eliminarCentral(T aEntidad) async {
  //   String url = generarUrl(aEntidad, "E");
  //   dynamic respuesta = await ServicioRest.delete(url, aEntidad.toJson());
  //   return aEntidad;
  // }

  // bool sincronizar(T entidad, String accion) {
  //   bool sincronizacion = false;
  //   if (configuracion.sincronizarServidor) {
  //     String url = generarUrl(entidad, accion);
  //     if (accion == "I") {
  //       ServicioRest.post(url, entidad.toJson()).then((respuesta) {
  //         print(respuesta.body);
  //         Map<String, dynamic> mapa = entidad.fromJsonToMap(respuesta.body);
  //         print(mapa);
  //         _actualizar(entidad);
  //       });
  //     } else if (accion == "U") {
  //       ServicioRest.put(url, entidad.toJson()).then((respuesta) {
  //         print(respuesta.body);
  //         Map<String, dynamic> mapa = entidad.fromJsonToMap(respuesta.body);
  //         print(mapa);
  //         _actualizar(entidad);
  //       });
  //     } else if (accion == "D") {
  //       ServicioRest.delete(url, entidad.toJson()).then((respuesta) {
  //         print(respuesta.body);
  //         Map<String, dynamic> mapa = entidad.fromJsonToMap(respuesta.body);
  //         print(mapa);
  //         _actualizar(entidad);
  //       });
  //     }
  //   }
  //   return sincronizacion;
  // }

}
