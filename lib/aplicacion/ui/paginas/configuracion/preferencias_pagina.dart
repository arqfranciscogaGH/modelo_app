//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../nucleo/nucleo.dart';
import '../../../aplicacion.dart';

//  librerias externas  flutter

class preferencias_pagina extends StatefulWidget {
  preferencias_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _preferencias_pagina_state createState() => _preferencias_pagina_state();
}

class _preferencias_pagina_state extends State<preferencias_pagina> {
  //  propiedades  widget

  // entidad

  dynamic entidadCaptura;

  //    control de estado  con provider

  ParametrosSistemaCE? prov;

  // KEYS

  // captura
  final formKey = GlobalKey<FormState>();

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  controladores

  TextEditingController _controllerListaIdioma = new TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
  }

  //  dispose widget
  @override
  void dispose() {
    super.dispose();
  }
  //
  //   construir  interfaz de usuario
  //

  @override
  Widget build(BuildContext context) {
    prov = Provider.of<ParametrosSistemaCE>(context, listen: true);

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
      body: mostrarCaptura(context, formKey, cambiarValor, validar,
          definicionControles, entidadCaptura),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Boton.botonFlotante(
        context,
        ElementoLista(icono: "save", accion: guardar),
      ),
    );
  }

  Widget mostrarCaptura(
      BuildContext context,
      GlobalKey<FormState> formKey,
      Function cambiarValor,
      Function validar,
      Function metodoDefinicionControles,
      dynamic entidadCaptura) {
    return /* SingleChildScrollView(
              child:  */
        Container(
      padding: EdgeInsets.all(15.0),
      child: Captura.mostrarFormulario(context, formKey, cambiarValor, validar,
          metodoDefinicionControles, entidadCaptura),

      //)
    );
  }

  List<Widget> definicionControles(
      BuildContext context,
      GlobalKey<FormState> formKey,
      Function cambiarValor,
      Function validar,
      dynamic entidadCaptura) {
    List<Control> controles = [];

    List<ElementoLista> _listaIdiomas = [];
    _listaIdiomas.add(ElementoLista(
        valor: "es",
        titulo: Traductor.obtenerEtiquetaSeccion('comun_pagina', 'idiomaES')));
    _listaIdiomas.add(ElementoLista(
        valor: "en",
        titulo: Traductor.obtenerEtiquetaSeccion('comun_pagina', 'idiomaEN')));

    Control listaIdiomas = new Control(
      idControl: "listaIdiomas",
    );

    listaIdiomas = listaIdiomas.asignar('', ContextoUI.obtenerTipo(widget),
        ParametrosSistema.idioma, 1, cambiarValor, validar);
    listaIdiomas.controlEdicion = _controllerListaIdioma;
    listaIdiomas.lista = _listaIdiomas;
    controles.add(listaIdiomas);

    return cargarControlesCaptura(context, controles, '',
        ContextoUI.obtenerTipo(widget), cambiarValor, validar, []);
    //return crearControlesCaptura(context,controles).toList();
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {}
  dynamic cambiarValor(Control control, dynamic valor) {
    // setState(() {
    switch (control.idControl) {
      case "listaIdiomas":
        print(valor);
        prov!.cambiarIdioma(valor);
        print(ParametrosSistema.idioma);
        break;
    }
    // });

    return entidadCaptura;
  }

  void guardar(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    prov!.guardarIdioma();
  }
}
