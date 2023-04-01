//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../inicializacion/inicializacion.dart';
import '../../../../configuracion/configuracion.dart';
import '../../../../administracion/administracion.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';
import '../../../contexto/contexto.dart';
import '../../../negocio/negocio.dart';

import 'ProductoUI.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class Producto_lista_pagina extends StatefulWidget {
  Producto_lista_pagina(
      {this.paginaSiguiente, this.paginaAnterior, this.activarAcciones});
  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Producto_lista_pagin_state createState() => _Producto_lista_pagin_state();
}

class _Producto_lista_pagin_state extends State<Producto_lista_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  //  controlador  de estado comun para  actulizar la UI
  ControlEstadoUI? controlEstadoUI;
  //  Interfaz  comun
  ProductoUI<Producto> ui =
      ProductoUI<Producto>(tabla: ContextoAplicacion.db.tablaProducto);

  // entidad

  Producto entidadCaptura = Producto();
  List<dynamic> listaEntidad = [];

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  Acciones
  ElementoLista? accionAgregar;
  ElementoLista? accionConsultar;
  ElementoLista? accionFiltrar;

  List<ElementoLista> opcionesPaginacion = [];

  //  controladores

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
    //  se obtiene pagina anterior (  pagina actual  )
    widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    // se crea  instncia de  control de estado comun  en clase provider  ControlEstadoUI
    controlEstadoUI = ControlEstadoUI();
    // se crea  instancia ui  y  se pasa contexto de tabla a usar
    ui = ProductoUI(tabla: ContextoAplicacion.db.tablaProducto!);

    // iniciar entidad
    ui.tabla!.entidad = ui.tabla!.iniciar();
    entidadCaptura = ui.tabla!.entidad;

    // ui.tabla!.controlEstadoUI = controlEstadoUI!;

    //  paginación
    // numero de  pagina  inicial
    ui.tabla!.paginador.paginaActual = 1;
    // registro por  pagina
    ui.tabla!.paginador.registrosPorPagina = 5;
    // indicador estatus  1 paginacion  en api 0 paginacion en lista obnenida
    // 1   la api hace la paginacion (solo regresa los registros se usaran en cada pagina, pero cada avance o regreso de pagina  e deben obtenr los registros )
    // se debe usar simpres el metodo consultarPaginacionTabla
    // 0   accesoTabla hace localmente la paginación  usando la lista , pero es necesaio obtener todos los registros en la primer llamada , ventaja : más rápido la pagicion  y menos  llamadas a la api  , desventaja  más datos en meomoria  y mas viajan por internet (viaja toda los registros)
    // se debe usar la primera vez consultarPaginacionTabla  y  en avanzar y regresar el metodo paginarTabla
    ui.tabla!.paginador.estatus = 1;

    // proporcionar  llave
    ContextoAplicacion.db.tablaProducto!.configuracion!.llaveApi =
        ContextoAplicacion.db.tablaAutenticacion!.entidad.llave!;

    controlEstadoUI!.iniciarProceso(eProceso.consultar, eEstatus.iniciado);
    ui.tabla!.consultarPaginacionTabla(entidadCaptura, actualizarEstadoLista);

    // ui.tabla!.filtrarLista(entidadCaptura, 'estatus', 1) ;

    print(ContextoAplicacion.db.tablaAutenticacion!.entidad.toMap());

    print("initState");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);

    // provider.addListener(() {
    //      print("  actualizo, numero ${provider.entidad.id} ");
    // }) ;

    // cuando es captura  parcial ,la ruta debe ser null    para qe  ejecute  la pagina siguiente

    //  accion para agregar un elemento a la lista
    accionAgregar = ElementoLista(
        id: 1,
        icono: "add_circle",
        ruta: widget.paginaSiguiente,
        accion: ui.agregarElemento,
        callBackAccion: ui.respuestaAgregar);

    //  accion para consultar  y modificar y eliminar un elemento de la lista consultada

    accionConsultar = ElementoLista(
      id: 2,
      operacion: eOperacion.consultar,
      icono: "edit",
      ruta: widget.paginaSiguiente,
      accion: ui.seleccionarElemento,
      callBackAccion: ui.respuestaSeleccionar,
      icono2: "documentos",
      ruta2: widget.paginaSiguiente,
      accion2: ui.eliminarElemento,
      callBackAccion2: ui.respuestaEliminar,
      icono3: "documentos",
      ruta3: widget.paginaSiguiente,
      accion3: ui.seleccionarElemento3,
      callBackAccion3: ui.respuestaSeleccionar3,
    );
    //  accion para filtrar y modificar y eliminar un elementos de la lista filtrada
    accionFiltrar = ElementoLista(
      id: 2,
      operacion: eOperacion.filtrar,
      icono: "edit",
      ruta: widget.paginaSiguiente,
      accion: ui.seleccionarElemento,
      callBackAccion: ui.respuestaSeleccionar,
      icono2: "documentos",
      ruta2: widget.paginaSiguiente,
      accion2: ui.eliminarElemento,
      callBackAccion2: ui.respuestaEliminar,
      icono3: "documentos",
      ruta3: widget.paginaSiguiente,
      accion3: ui.seleccionarElemento3,
      callBackAccion3: ui.respuestaSeleccionar3,
    );
    //  definir  acciones y  botones de pagina Float
    ElementoLista elemento =
        ElementoLista(id: 4, icono: "arrow_back", accion: regresarPagina);
    opcionesPaginacion.add(elemento);
    opcionesPaginacion.add(accionAgregar!);
    ElementoLista elemento3 =
        ElementoLista(id: 5, icono: "arrow_forward", accion: avanzarPagina);
    opcionesPaginacion.add(elemento3);
  }

  //  dispose widget
  @override
  void dispose() {
    super.dispose();
    controlEstadoUI!.dispose();
    ui.tabla!.dispose();
    ui.dispose();
  }

  //
  //   construir  interfaz widget
  //
  @override
  Widget build(BuildContext context) {
    print("build lista");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);

    ui.iniciar(context, scaffoldKey, widget);

    return ChangeNotifierProvider.value(
      value: controlEstadoUI,
      child: Scaffold(
        key: scaffoldKey,
        appBar: NewGradientAppBar(
          title: Text(ContextoUI.obtenerTitulo(widget)),
          gradient: LinearGradient(colors: [
            //Theme.of(context).primaryColor,
            Colores.obtener(ParametrosSistema.colorPrimario),
            Colores.obtener(ParametrosSistema.colorSecundario)
          ]),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Buscador buscador = Buscador();
                buscador.acccionConstruir = filtrarElementos;
                showSearch(
                  context: context,
                  delegate: buscador,
                );
              },
            ),
            //  IconButton(
            //       icon: Icon( Icons.arrow_back  ),  onPressed: ()
            //       {
            //               Accion.regresar(context);
            //       },
            // ),
          ],
        ),
        drawer: Menulateral.crearMenu(
            context,
            OpcionesMenus.obtenerMenuPrincipal(),
            ContextoUI.obtenerTitulo(widget)),
        body: mostrarContenido(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //floatingActionButton: Boton.crearBotonFlotante(context, accionAgregar!),
        floatingActionButton:
            Boton.renglonBotonesFlotantes(context, opcionesPaginacion),
      ),
    );
  }
  //    metodos
  //

  //  interface  comun
  //
  //
  // mostrar Contenido
  //

  Widget mostrarContenido() {
    print("mostrarContenido");
    listaEntidad = ui.tabla!.paginador.listaPagina as List<dynamic>;
    print(listaEntidad.length);
    return Consumer<ControlEstadoUI>(
        builder: (context, _controlEstadoUI, widgetPadre) {
      return Vista_lista(
          lista: ui.tabla!.paginador.listaPagina as List<dynamic>,
          //lista: ui.tabla!.lista,
          acciones: accionConsultar,
          metodoCrearElemento: ui.crearElementoEntidad,
          context: context,
          pagina: ContextoUI.obtenerTipo(widget),
          enProceso: controlEstadoUI!.enProceso);
    });
  }

  //
  //  filtar  informacion
  //
  Widget filtrarElementos(String query) {
    print("filtrarElementos");
    List<dynamic> lista = ui.tabla!.lista;
    if (lista != null && query != "")
      lista = lista
          .where((s) => s.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    return Vista_lista(
        lista: lista,
        acciones: accionFiltrar,
        metodoCrearElemento: ui.crearElementoEntidad,
        context: context,
        pagina: ContextoUI.obtenerTipo(widget),
        enProceso: controlEstadoUI!.enProceso);
  }

  void actualizarEstadoLista(List<dynamic> listaRespuesta) {
    print(listaRespuesta);
    listaEntidad = listaRespuesta;
    controlEstadoUI!.actualizarUI(eProceso.consultar, eEstatus.terminado);
  }

  regresarPagina(BuildContext context, ElementoLista elemento,
      [dynamic argumento]) {
    ui.tabla!.paginador.estatus = 1;
    if ((ui.tabla!.paginador.paginaActual as int) > 1) {
      ui.tabla!.paginador.paginaActual =
          (ui.tabla!.paginador.paginaActual as int) - 1;
      ui.tabla!.consultarPaginacionTabla(entidadCaptura, actualizarEstadoLista);
    }
  }

  avanzarPagina(BuildContext context, ElementoLista elemento,
      [dynamic argumento]) {
    ui.tabla!.paginador.estatus = 1;
    if ((ui.tabla!.paginador.paginaActual as int) <
        (ui.tabla!.paginador.totalPaginas as int)) {
      ui.tabla!.paginador.paginaActual =
          (ui.tabla!.paginador.paginaActual as int) + 1;
      ui.tabla!.consultarPaginacionTabla(entidadCaptura, actualizarEstadoLista);
    }
  }
}
//
// Termina widget
//
