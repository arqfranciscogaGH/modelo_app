//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../configuracion/configuracion.dart';
import '../../../contexto/contexto.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

import 'ClienteUI.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class Cliente_captura_pagina extends StatefulWidget {
  Cliente_captura_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _Cliente_captura_pagina_state createState() =>
      _Cliente_captura_pagina_state();
}

class _Cliente_captura_pagina_state extends State<Cliente_captura_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  ControlEstadoUI? controlEstadoUI;

  //  Interfaz  comun
  ClienteUI<Cliente> ui = ClienteUI<Cliente>(tabla: ContextoApp.db.cliente);

  // entidad
  Cliente entidadCaptura = Cliente();

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  final keyFormulario = GlobalKey<FormState>();

  //  controladores

  TextEditingController _controllerListaColor = new TextEditingController();
  TextEditingController _controller_txt = TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
    // widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    controlEstadoUI = ControlEstadoUI();
    ui = ClienteUI(tabla: ContextoApp.db.cliente!);

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

    String pagina = ContextoUI.obtenerTipo(widget);
    String nombrePagina = ContextoUI.obtenerTitulo(widget);

    controles.add(Control().crear('', pagina, "txtnombre",
        entidadCaptura.nombre, 1, cambiarValor, validar));

    // controles.add(Control().crear('', pagina, "txtprecio",
    //     entidadCaptura.precio.toString(), 1, cambiarValor, validar));

    // controles.add(Control().crear('', pagina, "txtcosto",
    //     entidadCaptura.costo.toString(), 1, cambiarValor, validar));

    // controles.add(Control().crear('', pagina, "txtexistencia",
    //     entidadCaptura.existencia.toString(), 1, cambiarValor, validar));

    bool estatus = entidadCaptura.estatus == 1 ? true : false;
    controles.add(Control()
        .crear('', pagina, "apaactivo", estatus, 1, cambiarValor, validar));

    return cargarControlesCaptura(
        context, controles, '', pagina, cambiarValor, validar, []);
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {}
  dynamic cambiarValor(Control control, dynamic valor) {
    // setState(() {
    // entidadCaptura = ContextoApp.db.Cliente!.entidad;
    print("cambiarValor");
    print(ui.tabla!.entidad.id);
    print(entidadCaptura.id);

    print(control.idControl);
    print(valor);

    switch (control.idControl) {
      case "txtnombre":
        entidadCaptura.nombre = valor;
        break;
      // case "txtprecio":
      //   entidadCaptura.precio = int.parse(valor);
      //   break;
      // case "txtcosto":
      //   entidadCaptura.costo = int.parse(valor);
      //   break;
      // case "txtexistencia":
      //   entidadCaptura.existencia = int.parse(valor);
      //   break;
      case "apaactivo":
        entidadCaptura.estatus = valor == true ? 1 : 0;
        break;
    }
    ui.tabla!.entidad = entidadCaptura;

    // });

    return entidadCaptura;
  }
}
