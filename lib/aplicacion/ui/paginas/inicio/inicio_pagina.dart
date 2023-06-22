//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../configuracion/configuracion.dart';

import '../../../contexto/contexto.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

//  librerias externas  flutter

class inicio_pagina extends StatefulWidget {
  inicio_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _inicio_pagina_state createState() => _inicio_pagina_state();
}

class _inicio_pagina_state extends State<inicio_pagina> {
  //  declaración de variables

  Color? colorFondo = Color.fromRGBO(108, 192, 218, 1.0);
  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  GlobalKey<FormState> keyFormulario = GlobalKey<FormState>();

  // captura

  //  controladores

  //  otros

  //  inicializar  variables
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //
  //   construir  interfaz de usuario
  //
  @override
  Widget build(BuildContext context) {
    // if  (Sesion.idUsuario==0)
    // {
    //     Accion.hacer( context, OpcionesMenus.obtener("pagina_acceso"));
    //     return (Scaffold(
    //             appBar: AppBar(
    //               title: Text(widget.titulo),
    //             ),
    //             body:Container(),
    //           )
    //     );

    // }
    // else
    // {

    return Scaffold(
        key: scaffoldKey,
        appBar: NewGradientAppBar(
          title: Text(ContextoUI.obtenerTitulo(widget)),
          gradient: LinearGradient(colors: [
            //Theme.of(context).primaryColor,
            Colores.obtener(ParametrosSistema.colorPrimario),
            Colores.obtener(ParametrosSistema.colorSecundario)
          ]),
          actions: [],
        ),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            _paginaInicio(context),
            _paginaPromociones(context)
          ],
        )

        // Column(
        //   mainAxisAlignment:MainAxisAlignment.center,
        //    children: <Widget>[
        //       RaisedButton( child: Text("Subscribir"), onPressed: (){
        //               Accion.hacer(context, ElementoLista(ruta:"Suscripcion_registro"));
        //       }),
        //       Divider(),
        //       RaisedButton( child: Text("Acceder"), onPressed: (){
        //         Navigator.pushReplacementNamed(context, pagina_acceso.routeName);
        //               Accion.hacer(context, ElementoLista(ruta:"pagina_acceso"));
        //       }),
        //       Divider(),

        //  ], )//Column( children :  <Widget> [

        // )
        );
    // }
  }

  Widget _paginaInicio(BuildContext context) {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imagenFondo(),
        _textos(),
      ],
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colorFondo,
    );
  }

  Widget _imagenFondo() {
    return Container(
      // width: double.infinity,
      // height: double.infinity,
      child: Image(
        image: AssetImage('assets/img/fondo1.jpeg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _textos() {
    final estiloTexto = TextStyle(color: Colors.white, fontSize: 50.0);
    return SafeArea(
      child: Column(
        children: <Widget>[
          // SizedBox(height: 20.0),
          // Text('  Mi ', style: estiloTexto, textAlign: TextAlign.center),
          // SizedBox(height: 20.0),
          // Text('Directorio', style: estiloTexto, textAlign: TextAlign.center),
          Expanded(child: Container()),
          Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white)
        ],
      ),
    );
  }

  Widget _paginaPromociones(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: colorFondo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RaisedButton(
              //   shape: StadiumBorder(),
              //   color: Theme.of(context).primaryColorLight,
              //   textColor: Colors.grey,
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              //     child: Text('Suscribir', style: TextStyle(fontSize: 20.0)),
              //   ),
              //   onPressed: () => Accion.hacer(context,
              //       OpcionesMenus.obtener("pagina_Suscripcion_registro")),
              // ),
              SizedBox(height: 20.0),

              Boton.texto(
                  context,
                  ElementoLista(
                    icono: 'menu',
                    accion: null,
                    tituloAccion: "Acceder",
                    pagina: acceso_pagina(),
                  ),
                  eBotonTipo.RectaguloOvalo),

              Boton.texto(
                  context,
                  ElementoLista(
                    icono: 'menu',
                    accion: null,
                    tituloAccion: "Menu",
                    pagina: menu_principal_pagina(),
                  ),
                  eBotonTipo.RectaguloOvalo),

              // RaisedButton(
              //   shape: StadiumBorder(),
              //   color: Theme.of(context).primaryColorLight,
              //   textColor: Colors.grey,
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              //     child: Text('Acceder', style: TextStyle(fontSize: 20.0)),
              //   ),
              //   onPressed: () => Accion.hacer(
              //       context, OpcionesMenus.obtener("pagina_acceso")),
              // ),
              SizedBox(height: 20.0),

              // RaisedButton(
              //   shape: StadiumBorder(),
              //   color: Theme.of(context).primaryColorLight,
              //   textColor: Colors.grey,
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              //     child: Text('Iniciar', style: TextStyle(fontSize: 20.0)),
              //   ),
              //   onPressed: () {
              //     if (Configuracion.cuenta == null ||
              //         Configuracion.cuenta == '')
              //       Accion.hacer(
              //           context, OpcionesMenus.obtener("acceso_pagina"));
              //     else
              //       Accion.hacer(context,
              //           OpcionesMenus.obtener("menu_principal_pagina"));
              //   },
              // ),
            ],
          ),
        ));
  }
}
//
// Termina widget
//
