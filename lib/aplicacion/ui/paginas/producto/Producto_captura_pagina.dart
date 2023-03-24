//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

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

class Producto_captura_pagina extends StatefulWidget {
  Producto_captura_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Producto_captura_pagina_state createState() =>
      _Producto_captura_pagina_state();
}

class _Producto_captura_pagina_state extends State<Producto_captura_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  ControlEstadoUI? controlEstadoUI;

  //  Interfaz  comun
  ProductoUI<Producto> ui =
      ProductoUI<Producto>(tabla: ContextoAplicacion.db.tablaProducto);

  // entidad
  Producto entidadCaptura = Producto();

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  controladores

  TextEditingController _controllerListaColor = new TextEditingController();
  TextEditingController _controllerColorSecundario = TextEditingController();
  TextEditingController _controller_txtHoraCU = TextEditingController();
  TextEditingController _controller_txtfechaCU = TextEditingController();
  TextEditingController _controller_txtfechaCalendario =
      TextEditingController();
  TextEditingController _controller_txtfechaSelector = TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
    // widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    controlEstadoUI = ControlEstadoUI();
    ui = ProductoUI(tabla: ContextoAplicacion.db.tablaProducto!);

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
          ])),
      drawer: Menulateral.crearMenu(
          context,
          OpcionesMenus.obtenerMenuPrincipal(),
          ContextoUI.obtenerTitulo(widget)),
      body: mostrarCaptura(context, keyFormulario, cambiarValor, validar,
          definicionControles, entidadCaptura),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Boton.crearBotonFlotante(
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
    return /* SingleChildScrollView(
                    child:  */
        Container(
      padding: EdgeInsets.all(15.0),
      child: Captura.mostrarFormulario(context, keyFormulario, cambiarValor,
          validar, metodoDefinicionControles, entidadCaptura),
      //)
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

    String pagina = ContextoUI.obtenerTitulo(widget);

    String nombrePagina = ContextoUI.obtenerTipo(widget);
    // controles.add(Control().crear('', widget.pagina!, "txtimporte",
    //     entidadCaptura.id, cambiarValor, validar));

    controles.add(Control().crear('', ContextoUI.obtenerTipo(widget),
        "txtnombre", entidadCaptura.nombre, cambiarValor, validar));

    controles.add(Control().crear('', ContextoUI.obtenerTipo(widget),
        "txtprecio", entidadCaptura.precio.toString(), cambiarValor, validar));
    // controles.add(Control().crear('', nombrePagina, "txtexistencia",
    //     entidadCaptura.existencia, cambiarValor, validar));

    // controles.add(Control().crear('', pagina, "apaactivo",
    //     entidadCaptura.estatus, cambiarValor, validar));

    return cargarControlesCaptura(context, controles, '',
        ContextoUI.obtenerTipo(widget), cambiarValor, validar, []);
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {}
  dynamic cambiarValor(Control control, dynamic valor) {
    // setState(() {
    // entidadCaptura = ContextoAplicacion.db.tablaproducto!.entidad;
    print("cambiarValor");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);

    print(control.idControl);
    print(valor);

    switch (control.idControl) {
      case "txtnombre":
        entidadCaptura.nombre = valor;
        break;
      case "txtprecio":
        entidadCaptura.precio = double.parse(valor);
        break;
      case "txtexistencia":
        entidadCaptura.existencia = valor;
        break;
      case "apaactivo":
        entidadCaptura.estatus = valor == true ? 1 : 0;
        break;
    }
    ui.tabla!.entidad = entidadCaptura;

    // });

    return entidadCaptura;
  }
}
