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

import 'VentaUI.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class venta_lista_pagina extends StatefulWidget {
  venta_lista_pagina(
      {this.paginaSiguiente, this.paginaAnterior, this.activarAcciones});
  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _venta_lista_pagina_state createState() => _venta_lista_pagina_state();
}

class _venta_lista_pagina_state extends State<venta_lista_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  //ComunCE? provider;
  //  controlador  de estado comun para  actulizar la UI
  ControlEstadoUI? controlEstadoUI;
  //  Interfaz  comun
  VentaUI<Venta> ui = VentaUI<Venta>(tabla: ContextoAplicacion.db.tablaVenta);

  // entidad

  Venta entidadCaptura = Venta();
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

  //  controladores

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();

    entidadCaptura = Venta().iniciar();
    ContextoAplicacion.db.tablaVenta!.entidad = entidadCaptura;

    controlEstadoUI = ControlEstadoUI();
    ui = VentaUI(tabla: ContextoAplicacion.db.tablaVenta!);

    // provider.limpiar();

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

    ContextoAplicacion.db.tablaVenta!.controlEstadoUI = controlEstadoUI!;

    ContextoAplicacion.db.tablaVenta!
        .consultarTabla(ContextoAplicacion.db.tablaVenta!.entidad);

    // ContextoAplicacion.db.tablaVenta!.consultarTabla(
    //     ContextoAplicacion.db.tablaVenta!.entidad, actualizarEstadoLista);

    // ContextoAplicacion.db.tablaVenta!
    //     .consultarTabla(ContextoAplicacion.db.tablaVenta!.entidad)
    //     .then((respuesta) {
    //   print(respuesta);
    // });
    // provider.addListener(() {
    //      print("  actualizo, numero ${provider.entidad.id} ");
    // }) ;
  }

  //  dispose widget
  @override
  void dispose() {
    super.dispose();
    controlEstadoUI!.dispose();
    ui.dispose();
  }

  //
  //   construir  interfaz widget
  //
  @override
  Widget build(BuildContext context) {
    ui.iniciar(context, scaffoldKey, widget);
    print("build lista");
    print(ContextoAplicacion.db.tablaVenta!.entidad.id);
    print(entidadCaptura.id);
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
        floatingActionButton: Boton.crearBotonFlotante(context, accionAgregar!),
      ),
    );
  }
  //    metodos
  //

  void actualizarEstadoLista(List<dynamic> listaRespuesta) {
    print(listaRespuesta);
    listaEntidad = listaRespuesta;
  }

  //  interface  comun
  //
  //
  // mostrar Contenido
  //

  Widget mostrarContenido() {
    print("mostrarContenido");
    return Consumer<ControlEstadoUI>(
        builder: (context, _provider, widgetPadre) {
      return Vista_lista(
          //lista: provider!.lista,
          //lista: listaEntidad,
          lista: ContextoAplicacion.db.tablaVenta!.lista,
          acciones: accionConsultar,
          metodoCrearElemento: ui.crearElementoEntidad,
          context: context,
          pagina: ContextoUI.obtenerTipo(widget),
          enProceso: _provider.enProceso);
    });
  }

  //
  //  filtar  informacion
  //
  Widget filtrarElementos(String query) {
    print("filtrarElementos");
    List<dynamic> lista = ContextoAplicacion.db.tablaVenta!.lista;
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
}
//
// Termina widget
//
