//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

import 'dart:io';

//  librerias importadas flutter
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../configuracion/configuracion.dart';
import '../../../contexto/contexto.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

import 'VentaProductoUI.dart';
import 'ventasRN.dart' as RN;
//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class Venta_producto_captura_pagina extends StatefulWidget {
  Venta_producto_captura_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Venta_producto_captura_pagina_state createState() =>
      _Venta_producto_captura_pagina_state();
}

class _Venta_producto_captura_pagina_state
    extends State<Venta_producto_captura_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  ControlEstadoUI? controlEstadoUI;

  //  Interfaz  comun
  VentaProductoUI<VentaProducto> ui =
      VentaProductoUI<VentaProducto>(tabla: ContextoApp.db.ventaProducto);

  // entidad
  VentaProducto entidadCaptura = VentaProducto();

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  controladores

  TextEditingController _controller_autProducto = new TextEditingController();
  TextEditingController _controller_txtCantidad = new TextEditingController();
  TextEditingController _controller_txtPrecio = TextEditingController();

  TextEditingController _controller_etiImporteVenta = TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
    // widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    controlEstadoUI = ControlEstadoUI();
    ui = VentaProductoUI(tabla: ContextoApp.db.ventaProducto!);

    entidadCaptura = ui.tabla!.entidad;

    print("initState");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);
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
    print("build captura ");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);
    ui.iniciar(context, scaffoldKey, widget);
    ui.keyFormulario = keyFormulario;

    // provider = Provider.of<ControlEstadoUI>(context, listen: false);

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
              Accion.mostrarPagina(this.context, widget, "anterior");
              // Accion.regresar(context);
            },
          ),
        ],
      ),
      drawer: Menulateral.crearMenu(
          context,
          OpcionesMenus.obtenerMenuPrincipal(),
          ContextoUI.obtenerTitulo(widget)),
      body: mostrarCaptura(context, keyFormulario, cambiarValor, validar,
          definicionControles, entidadCaptura),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Boton.botonFlotante(
        context,
        ElementoLista(
            icono: "save",
            accion: ui.guardar,
            ruta: widget.paginaAnterior,
            accion2: ui.insertar,
            accion3: ui.modificar,
            // callBackAccion: ui.respuestaGuardar,
            callBackAccion2: ui.respuestaInsertar,
            callBackAccion3: ui.respuestaModificar),
      ),
    );
  }

  //    metodos

  //  mostrar  captura
  Widget mostrarCaptura(
      BuildContext context,
      GlobalKey<FormState> keyFormulario,
      Function cambiarValor,
      Function validar,
      Function metodoDefinicionControles,
      dynamic entidadCaptura) {
    // return SingleChildScrollView(
    //   //   child:
    return Container(
      // padding: EdgeInsets.all(15.0),
      child: Captura.mostrarFormulario(context, keyFormulario, cambiarValor,
          validar, metodoDefinicionControles, entidadCaptura),
      // )
    );
  }

  //  definir  controles
  List<Widget> definicionControles(
      BuildContext context,
      GlobalKey<FormState> keyFormulario,
      Function cambiarValor,
      Function validar,
      dynamic entidadCaptura) {
    List<Control> controles = [];

    // List<ElementoLista> lista_Cliente = [];
    // for (Cliente tabla in ContextoApp.db.cliente!.lista)
    // // ContextoApp.db.venta!.lista.forEach((tabla)
    // {
    //   ElementoLista item = ElementoLista(
    //       id: tabla.id, valor: tabla.nombre, titulo: tabla.nombre);
    //   lista_Cliente.add(item);
    // };

    String pagina = ContextoUI.obtenerTipo(widget);

    // obtener nombre producto
    entidadCaptura = ui.obtenerNombre(entidadCaptura);

    Control autProducto = Control().crear('', pagina, "autProducto",
        entidadCaptura.nombre, 1, cambiarValor, validar);
    autProducto.controlEdicion = _controller_autProducto;
    // autCLiente.lista = lista_Cliente;
    autProducto.tabla = ContextoApp.db.producto;
    controles.add(autProducto);

    Control txtCantidad = Control().crear('', pagina, "txtCantidad",
        entidadCaptura.cantidad.toString(), 1, cambiarValor, validar);
    txtCantidad.controlEdicion = _controller_txtCantidad;
    controles.add(txtCantidad);

    Control txtPrecio = Control().crear('', pagina, "txtPrecio",
        entidadCaptura.precio.toString(), 1, cambiarValor, validar);
    txtPrecio.controlEdicion = _controller_txtPrecio;
    controles.add(txtPrecio);

    controles.add(Control().crear('', pagina, "etiImporteVenta",
        entidadCaptura.importe.toString(), 0, cambiarValor, validar));

    return cargarControlesCaptura(
        context, controles, '', pagina, cambiarValor, validar, []);
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {
    print("cambiarValor");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);

    print(control.idControl);
    print(valor);
  }

  dynamic cambiarValor(Control control, dynamic valor) {
    setState(() {
      // entidadCaptura = ContextoApp.db.venta!.entidad;
      print("cambiarValor");
      print(ui.tabla!.entidad.id);
      print(entidadCaptura.id);

      print(control.idControl);
      print(valor);

      switch (control.idControl) {
        case "autProducto":
          {
            entidadCaptura.nombre = valor;
            entidadCaptura.idProducto = control.id;
            entidadCaptura = ui.obtenerNombre(entidadCaptura);
            break;
          }
        case "txtCantidad":
          entidadCaptura.cantidad = int.tryParse(valor);
          break;
        case "txtPrecio":
          entidadCaptura.precio = double.tryParse(valor);
          break;
      }
      if (entidadCaptura.cantidad! != 0 && entidadCaptura.precio! != 0)
        entidadCaptura.importe =
            (entidadCaptura.precio! * entidadCaptura.cantidad!).toDouble();
      ui.tabla!.entidad = entidadCaptura;
    });

    return entidadCaptura;
  }
}
