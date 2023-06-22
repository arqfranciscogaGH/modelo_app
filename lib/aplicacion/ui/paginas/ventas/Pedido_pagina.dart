//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//  librerias  proyecto

import '../../../../configuracion/configuracion.dart';
import '../../../contexto/contexto.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

import 'VentaProductoUI.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class Pedido_pagina extends StatefulWidget {
  Pedido_pagina(
      {this.paginaSiguiente, this.paginaAnterior, this.activarAcciones});
  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Pedido_pagina createState() => _Pedido_pagina();
}

class _Pedido_pagina extends State<Pedido_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  //  controlador  de estado comun para  actulizar la UI
  ControlEstadoUI? controlEstadoUI;
  //  Interfaz  comun
  VentaProductoUI<VentaProducto> ui =
      VentaProductoUI<VentaProducto>(tabla: ContextoApp.db.ventaProducto);

  // entidad

  VentaProducto entidadCaptura = VentaProducto();
  List<dynamic> listaEntidad = [];

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey _bottomNavigationKey = GlobalKey();
  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  Acciones
  ElementoLista? accionAgregar;
  ElementoLista? accionConsultar;
  ElementoLista? accionFiltrar;

  List<ElementoLista> opcionesPaginacion = [];

  //  controladores

  //  otros
  int? indexPagina = 0;
  List<Widget>? paginas = [];

  //  inicializar  variables
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // provider.dispose();
  }

  //
  //   construir  interfaz de usuario
  //
  @override
  Widget build(BuildContext context) {
    paginas = [
      vistaInformacion3(),
      Venta_producto_lista_pagina(
          paginaAnterior: 'venta_producto_lista_pagina',
          paginaSiguiente: 'venta_producto_captura_pagina'),
      Venta_producto_captura_pagina(
          paginaAnterior: 'venta_producto_lista_pagina',
          paginaSiguiente: 'venta_producto_captura_pagina'),
    ];

    return Scaffold(
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Accion.regresar(context);
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: indexPagina!,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.lime,
        buttonBackgroundColor: Colors.grey,
        height: 55.0,
        //animationCurve: Curves.easeInOut,
        // animationCurve: Curves.bounceIn,
        //animationCurve: Curves.bounceOut,
        animationCurve: Curves.easeIn,
        items: <Widget>[
          Icono.crear('articulo', 'negro', 30),
          Icono.crear('captura', 'negro', 30),
          Icono.crear('book', 'negro', 30),
        ],
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            indexPagina = index;
          });
        },
      ),

      body: mostrarPagina(indexPagina!),
      drawer: Menulateral.crearMenu(
          context,
          OpcionesMenus.obtenerMenuPrincipal(),
          ContextoUI.obtenerTitulo(widget)),
      // )
    );
  }

  //
  //  interface de usuario   comun de la vista
  //

  //
  // mostrar Contenido
  //

  Widget mostrarPagina(int indexPaginaSeleccionado) {
    return paginas![indexPaginaSeleccionado];
  }

  Widget vistaInformacion1() {
    return Container(color: Colors.red);
  }

  Widget vistaInformacion2() {
    return Container(color: Colors.black);
  }

  Widget vistaInformacion3() {
    return Container(color: Colors.amber);
  }
}
//
// Termina widget
//
