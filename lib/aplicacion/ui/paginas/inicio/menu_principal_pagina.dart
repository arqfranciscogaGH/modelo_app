//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

//  librerias importadas flutter
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../inicializacion/inicializacion.dart';
import '../../../../configuracion/configuracion.dart';
import '../../../../administracion/administracion.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

import '../../../../nucleo/negocio/controladorEstado/controladorEstado.dart';

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

class menu_principal_pagina extends StatefulWidget {
  menu_principal_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _menu_principal_pagina_state createState() => _menu_principal_pagina_state();
}

class _menu_principal_pagina_state extends State<menu_principal_pagina> {
  //  declaración de variables
  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build principal");

    // Responsivo.identifciarDispositivo(context);

    // print(ParametrosSistema.idioma);
    // print(ParametrosSistema.colorPrimario);
    // print(ParametrosSistema.colorSecundario);
    // late ElementoLista elementoLista;
    // elementoLista = InjeccionDependencia.obtener<ElementoLista>();
    // ElementoLista elementoLista2 =
    //     InjeccionDependencia.obtener<ElementoLista>();
    // elementoLista2.titulo = "222";
    // print(ContextoAplicacion.db.tablaAutenticacion!.entidad.toMap());

    return Scaffold(
      key: scaffoldKey,
      appBar: NewGradientAppBar(
        title: Text(ContextoUI.obtenerTitulo(widget)),
        gradient: LinearGradient(colors: [
          //Theme.of(context).primaryColor,
          Colores.obtener(ParametrosSistema.colorPrimario),
          Colores.obtener(ParametrosSistema.colorSecundario)
        ]),
      ),
      drawer: Menulateral.crearMenu(
          context,
          OpcionesMenus.obtenerMenuPrincipal(),
          ContextoUI.obtenerTitulo(widget),
          ParametrosSistema.paginaAccesso),
      body: Stack(
        children: <Widget>[
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //  _titulos(),
                SizedBox(height: 130.0),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: <Color>[
            //Colors.grey ,
            Theme.of(context).primaryColorLight,
            Color.fromARGB(255, 56, 9, 9)
          ])),
    );

    final cajaRosa = Transform.rotate(
        angle: -pi / 6.0,
        child: Container(
          height: 340.0,
          width: 340.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.4),
                end: FractionalOffset(0.0, 1.0),
                colors: <Color>[
                  //Colors.grey ,
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColor,
                ]),
            borderRadius: BorderRadius.circular(80.0),
            // gradient: LinearGradient(

            // )
          ),
        ));

    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(top: -185.0, child: cajaRosa),
        _titulos(),
      ],
    );
  }

  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 42),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 35.0),
            Text('Titulo ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
