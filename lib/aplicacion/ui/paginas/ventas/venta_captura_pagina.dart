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

import 'VentaUI.dart';
import 'VentasRN.dart' as RN;

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class Venta_captura_pagina extends StatefulWidget {
  Venta_captura_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Venta_captura_pagina_state createState() => _Venta_captura_pagina_state();
}

class _Venta_captura_pagina_state extends State<Venta_captura_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  ControlEstadoUI? controlEstadoUI;

  //  Interfaz  comun
  VentaUI<Venta> ui = VentaUI<Venta>(tabla: ContextoApp.db.venta);

  // entidad
  Venta entidadCaptura = Venta();

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  controladores

  TextEditingController _controller_txtFechaVenta = TextEditingController();
  TextEditingController _controller_autCliente = new TextEditingController();
  TextEditingController _controller_lisTipoVenta = new TextEditingController();
  TextEditingController _controller_lisFormaPago = TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
    // widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    controlEstadoUI = ControlEstadoUI();
    ui = VentaUI(tabla: ContextoApp.db.venta!);

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
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Accion.hacer(context,
                  OpcionesMenus.obtener("Venta_producto_lista_pagina"));
              // Accion.regresar(context);
            },
          ),
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

    List<ElementoLista> lista_TipoVenta = [];
    lista_TipoVenta.add(ElementoLista(valor: "Contado", titulo: "Contado"));
    lista_TipoVenta.add(ElementoLista(valor: "Credito", titulo: "Credito"));
    lista_TipoVenta.add(ElementoLista(valor: "Apartado", titulo: "Apartado"));

    List<ElementoLista> lista_FormaPago = [];
    lista_FormaPago.add(ElementoLista(valor: "Efectivo", titulo: "Efectivo"));
    lista_FormaPago
        .add(ElementoLista(valor: "Trasferencia", titulo: "Trasferencia"));
    lista_FormaPago
        .add(ElementoLista(valor: "Tarjeta Debito", titulo: "Tarjeta Debito"));
    lista_FormaPago.add(
        ElementoLista(valor: "Tarjeta Credito", titulo: "Tarjeta Credito"));

    // List<ElementoLista> lista_Cliente = [];
    // for (Cliente tabla in ContextoApp.db.cliente!.lista)
    // // ContextoApp.db.venta!.lista.forEach((tabla)
    // {
    //   ElementoLista item = ElementoLista(
    //       id: tabla.id, valor: tabla.nombre, titulo: tabla.nombre);
    //   lista_Cliente.add(item);
    // };

    String pagina = ContextoUI.obtenerTipo(widget);

    // fecha venta
    if (entidadCaptura.fechaVenta == null || entidadCaptura.fechaVenta == "") {
      DateTime fechaSeleccionada = DateTime.now();
      entidadCaptura.fechaVenta =
          DateFormat(ParametrosSistema.formatoFecha).format(fechaSeleccionada);
      // entidadCaptura.fechaVenta = DateFormat(ParametrosSistema.formatoFecha).parse(control.valor);
    }

    Control txtFechaVenta = Control().crear('', pagina, "txtFechaVenta",
        entidadCaptura.fechaVenta, 1, cambiarValor, validar);
    txtFechaVenta.controlEdicion = _controller_txtFechaVenta;
    controles.add(txtFechaVenta);

    // obtener nombre cliente
    entidadCaptura = ui.obtenerNombre(entidadCaptura);

    Control autCLiente = Control().crear('', pagina, "autCliente",
        entidadCaptura.nombre, 1, cambiarValor, validar);
    autCLiente.controlEdicion = _controller_autCliente;
    // autCLiente.lista = lista_Cliente;
    autCLiente.tabla = ContextoApp.db.cliente;
    controles.add(autCLiente);

    // tipo venta
    entidadCaptura.tipoVenta =
        entidadCaptura.tipoVenta == null || entidadCaptura.tipoVenta == ""
            ? "Contado"
            : entidadCaptura.tipoVenta;
    Control lisTipoVenta = new Control(idControl: "lisTipoVenta");

    lisTipoVenta = lisTipoVenta.asignar(
        '', pagina, entidadCaptura.tipoVenta, 1, cambiarValor, validar);
    lisTipoVenta.controlEdicion = _controller_lisTipoVenta;
    lisTipoVenta.lista = lista_TipoVenta;
    controles.add(lisTipoVenta);

    // forma de pago
    entidadCaptura.formaPago =
        entidadCaptura.formaPago == null || entidadCaptura.formaPago == ""
            ? "Efectivo"
            : entidadCaptura.formaPago;

    Control lisFormaPago = new Control(idControl: "lisFormaPago");

    lisFormaPago = lisFormaPago.asignar(
        '', pagina, entidadCaptura.formaPago, 1, cambiarValor, validar);
    lisFormaPago.controlEdicion = _controller_lisFormaPago;
    lisFormaPago.lista = lista_FormaPago;
    controles.add(lisFormaPago);

    controles.add(Control().crear('', pagina, "etiImportePagado",
        entidadCaptura.importePagado.toString(), 1, cambiarValor, validar));

    controles.add(Control().crear('', pagina, "etiImporteVenta",
        entidadCaptura.importeVenta.toString(), 0, cambiarValor, validar));

    controles.add(Control().crear('', pagina, "etiCantidadVenta",
        entidadCaptura.cantidadVenta.toString(), 0, cambiarValor, validar));

    controles.add(Control().crear('', pagina, "etiImporteCambio",
        entidadCaptura.importeCambio.toString(), 0, cambiarValor, validar));

    controles.add(Control().crear('', pagina, "etiSaldo",
        entidadCaptura.saldo.toString(), 0, cambiarValor, validar));

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
        case "txtFechaVenta":
          entidadCaptura.fechaVenta = valor;
          break;
        case "autCliente":
          {
            entidadCaptura.nombre = valor;
            entidadCaptura.idCliente = control.id;
            break;
          }
        case "lisTipoVenta":
          entidadCaptura.tipoVenta = valor;
          break;
        case "lisFormaPago":
          entidadCaptura.formaPago = valor;
          break;
        case "etiImportePagado":
          {
            entidadCaptura.importePagado = double.parse(valor);
            entidadCaptura = RN.calcularImportesTotales(entidadCaptura);
            break;
          }
      }
      ui.tabla!.entidad = entidadCaptura;
    });
    return entidadCaptura;
  }
}
