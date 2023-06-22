//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'package:modelo_app/nucleo/ui/controles/estandar/AutoCompletar.dart';
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

//  librerias externas  flutter

import '../../../../paquetesExternos/paquetesExternos.dart';

// import '../../../../nucleo/ui/controles/estandar/AutoCompletar.dart';

class botones_pagina extends StatefulWidget {
  botones_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;
  static String ruta = "botones_pagina";

  @override
  _botones_paginas_state createState() => _botones_paginas_state();
}

class _botones_paginas_state extends State<botones_pagina> {
  int _counter = 0;
  //  declaración de variables
  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  ParametrosSistemaCE? prov;
  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() async {
    // setState(() {

    //  final prov= controladorEstadoTema.obtenerEstado(context);
    print(ParametrosSistema.idioma);

    if (ParametrosSistema.idioma != "es") {
      prov!.cambiarIdioma("es");
    } else {
      prov!.cambiarIdioma("en");
    }

    print(ParametrosSistema.idioma);
    print(ParametrosSistema.colorTema);
    _counter++;
    // });
  }

  @override
  Widget build(BuildContext context) {
    prov = Provider.of<ParametrosSistemaCE>(context, listen: true);

    print(ParametrosSistema.idioma);
    print(ParametrosSistema.colorTema);

    ElementoLista elementoP = ElementoLista(
        icono: 'house',
        accion: ejecutar,
        tituloAccion: "Tit A 1",
        titulo: 'Tit  1',
        subtitulo: "Sub A 1",
        descripcion: "desc A 1");

    ElementoLista elemento = ElementoLista(
        icono: 'menu',
        accion: ejecutar,
        tituloAccion: "Accion 1",
        titulo: 'Titulo 1',
        subtitulo: "Subtitulo 1",
        descripcion: "descripcion 2");

    ElementoLista elemento2 = ElementoLista(
        icono: 'nivel',
        accion: ejecutar,
        tituloAccion: "Accion 2",
        titulo: 'Titulo 2',
        subtitulo: "Subtitulo 2",
        descripcion: " descripcion 2");

    ElementoLista elementoT = ElementoLista(
      // icono: 'nivel',
      accion: ejecutar,
      // tituloAccion: "accion A",
      // titulo: 'Titulo 2',
      // subtitulo: "Subtitulo 2",
      // descripcion: " descripcion 2"
    );

    ElementoLista elementoI = ElementoLista(
      icono: 'nivel',
      // tituloAccion: "accion B",
      accion: ejecutar,
      // titulo: 'Titulo 2',
      // subtitulo: "Subtitulo 2",
      // descripcion: " descripcion 2"
    );

    List<ElementoLista> opciones = [];

    opciones.add(ElementoLista(id: 1, titulo: 'aardvark'));
    opciones.add(ElementoLista(id: 2, titulo: 'bobcat'));
    opciones.add(ElementoLista(id: 3, titulo: 'chameleon'));

    TextEditingController _controllerAutoCompletar = TextEditingController();
    Control control = Control(controlEdicion: _controllerAutoCompletar);
    control.controlEdicion = _controllerAutoCompletar;
    control.textoEtiqueta = "cliente";
    control.marcaAguaTexto = "cliente";
    control.lista = opciones;
    ParametrosSistema.tipoBoton = eBotonTipo.Pentagono;

//

    TextEditingController _controllerAutoCompletarTabla =
        TextEditingController();
    Control controlP = Control(controlEdicion: _controllerAutoCompletarTabla);
    controlP.controlEdicion = _controllerAutoCompletarTabla;
    controlP.textoEtiqueta = "producto";
    controlP.marcaAguaTexto = "producto";

    ParametrosSistema.tipoBoton = eBotonTipo.Pentagono;
    print(ContextoApp.db.producto!.lista);

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),

            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),

            AutoCompletarLista(
                lista: opciones, control: control, metodo: ejecutar),

            Boton.plano(context, elementoT, ParametrosSistema.tipoBoton),
            Boton.planoIcono(context, elementoI, ParametrosSistema.tipoBoton),

            Boton.plano(context, elemento2, ParametrosSistema.tipoBoton),
            Boton.planoIcono(context, elemento2, ParametrosSistema.tipoBoton),

            // Autocompletar(lista: opciones, control: control, metodo: ejecutar),

            AutoCompletarTabla(
              tabla: ContextoApp.db.producto,
              control: controlP,
              metodo: ejecutar,
            ),

            Boton.texto(context, elementoP, ParametrosSistema.tipoBoton),

            Boton.elevado(context, elemento, ParametrosSistema.tipoBoton),
            Boton.elevadoIcono(context, elemento, ParametrosSistema.tipoBoton),

            Boton.lineasAfuera(context, elemento2, ParametrosSistema.tipoBoton),
            Boton.lineasAfueraIcono(
                context, elemento2, ParametrosSistema.tipoBoton),

            Boton.icono(context, elemento),

            Boton.linkTexto(context, elementoP),

            Boton.linkIcono(context, elemento2),

            //  Icono.crear(elemento.icono!),
            // FloatingActionButton(
            //   child: Icon(Icons.access_time),
            //   elevation: 50.0,
            //   backgroundColor: Colors.amber,
            // ),
            // MaterialButton(
            //   minWidth: 200.0,
            //   height: 40.0,
            //   onPressed: () {},
            //   color: Colors.lightBlue,
            //   child: Text('Material Button',
            //       style: TextStyle(color: Colors.white)),
            // ),
            // RaisedButton(
            //   disabledColor: Colors.amber,
            //   child: Text("Raised Button"),
            //   splashColor: Colors.amber,
            //   color: Colors.blueAccent,
            //   onPressed: ()  {
            //     print("Hola Raised Button");
            //   },
            // ),
            // FlatButton(
            //   child: new Text('Flat Button'),
            //   onPressed: ()  {
            //     print("Hola Raised Button");
            //   },
            // )
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Boton.botonFlotante(
        context,
        ElementoLista(icono: "save", accion: ejecutar),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  dynamic cambiarValor(dynamic valor) {
    print(valor);
  }

  ejecutar(BuildContext context, ElementoLista elemento, [dynamic argumetos]) {
    print("ejecuto ");
    _incrementCounter();
  }
}
