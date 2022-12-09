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

import 'VentaUI.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class venta_captura_pagina extends StatefulWidget {
  venta_captura_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _venta_captura_pagina_state createState() => _venta_captura_pagina_state();
}

class _venta_captura_pagina_state extends State<venta_captura_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  ControlEstadoUI? controlEstadoUI;

  //  Interfaz  comun
  VentaUI<Venta> ui = VentaUI<Venta>(tabla: ContextoAplicacion.db.tablaVenta);

  // entidad
  Venta entidadCaptura = Venta();

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

    entidadCaptura = ContextoAplicacion.db.tablaVenta!.entidad;
    controlEstadoUI = ControlEstadoUI();

    ui = VentaUI<Venta>(tabla: ContextoAplicacion.db.tablaVenta);
    print("initState");
    print(ContextoAplicacion.db.tablaVenta!.entidad.id);
    print(entidadCaptura.id);
    ui = VentaUI(tabla: ContextoAplicacion.db.tablaVenta!);
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
    ui.keyFormulario = keyFormulario;
    print("build");
    print(ContextoAplicacion.db.tablaVenta!.entidad.id);
    print(entidadCaptura.id);

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

    List<ElementoLista> _lista = [];
    _lista.add(ElementoLista(valor: "si", titulo: "si"));
    _lista.add(ElementoLista(valor: "no", titulo: "no"));

    print(ParametrosSistema.colorTema);
    Control lisVariables = new Control(
      idControl: "lisVariables",
    );
    String pagina = ContextoUI.obtenerTitulo(widget);
    lisVariables =
        lisVariables.asignar('', pagina, "si", cambiarValor, validar);
    lisVariables.controlEdicion = _controllerListaColor;
    lisVariables.lista = _lista;
    controles.add(lisVariables);

    Control txtHoraCU = Control().crear(
        '', pagina, "txtHoraCU", entidadCaptura.clave, cambiarValor, validar);
    txtHoraCU.controlEdicion = _controller_txtHoraCU;
    controles.add(txtHoraCU);

    Control txtfechaCU = Control().crear(
        '', pagina, "txtfechaCU", entidadCaptura.llave, cambiarValor, validar);
    txtfechaCU.controlEdicion = _controller_txtfechaCU;
    controles.add(txtfechaCU);

    Control txtfechaCalendario = Control().crear('', pagina,
        "txtfechaCalendario", entidadCaptura.llave, cambiarValor, validar);
    txtfechaCalendario.controlEdicion = _controller_txtfechaCalendario;
    controles.add(txtfechaCalendario);

    Control txtfechaSelector = Control().crear('', pagina, "txtfechaSelector",
        entidadCaptura.llave, cambiarValor, validar);
    txtfechaSelector.controlEdicion = _controller_txtfechaSelector;
    controles.add(txtfechaSelector);

    // controles.add(Control().crear('', widget.pagina!, "txtimporte",
    //     entidadCaptura.id, cambiarValor, validar));

    controles.add(Control().crear('', pagina, "txttelefono",
        entidadCaptura.clave, cambiarValor, validar));
    controles.add(Control().crear(
        '', pagina, "txtcorreo", entidadCaptura.nombre, cambiarValor, validar));
    controles.add(Control().crear('', pagina, "txtruta",
        entidadCaptura.descripcion, cambiarValor, validar));

    return cargarControlesCaptura(context, controles, '',
        ContextoUI.obtenerTipo(widget), cambiarValor, validar, []);
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {}
  dynamic cambiarValor(Control control, dynamic valor) {
    // setState(() {
    // entidadCaptura = ContextoAplicacion.db.tablaVenta!.entidad;
    print("cambiarValor");
    print(ContextoAplicacion.db.tablaVenta!.entidad.id);
    print(entidadCaptura.id);

    print(control.idControl);
    print(valor);

    switch (control.idControl) {
      case "lisVariables":
        break;
      case "txtcuenta":
        break;
      case "txtfechaNacimiento":
        break;
      case "txtimporte":
        break;
      case "txttelefono":
        break;
      case "txtcorreo":
        entidadCaptura.nombre = valor;
        break;
      case "txtruta":
        break;
    }
    ContextoAplicacion.db.tablaVenta!.entidad = entidadCaptura;
    // });

    return entidadCaptura;
  }

  // guardar  información
  // void guardar(BuildContext context, ElementoLista elemento,
  //     [dynamic argumentos]) {
  //   if (!keyFormulario.currentState!.validate()) return;
  //   keyFormulario.currentState!.save();

  //   print("guardar");
  //   print(ContextoAplicacion.db.tablaVenta!.entidad.id);
  //   print(entidadCaptura.id);

  //   if (entidadCaptura.id == null || entidadCaptura.id == 0)
  //     ui.insertar(context, elemento, entidadCaptura);
  //   else
  //     ui.modificar(context, elemento, entidadCaptura);
  // }
}
