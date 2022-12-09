//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../nucleo.dart';

class Dialogo {
  static void seleccionarOpciones(BuildContext context, String icono,
      String titulo, String mensaje, List<ElementoLista> elementos) async {
    await showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: crearContenidoDialogoOpciones(
                  context, icono, titulo, mensaje, elementos)
              //title: Text(titulo),
              //content: _crearMensaje(context,mensaje, opcion),
              /*               actions: <Widget>[
                  RaisedButton(
                    child: Text(opcion),
                    onPressed: ()=> Navigator.of(context).pop(),
                  )  
                ],*/
              );
        });
  }

  static void mostrarAlerta(
      BuildContext context, ElementoLista elemento) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: crearContenidoAlerta(context, elemento.icono!,
                  elemento.titulo!, elemento.mensaje!, elemento)
              //title: Text(titulo),
              //content: _crearMensaje(context,mensaje, opcion),
/*               actions: <Widget>[
                RaisedButton(
                  child: Text(opcion),
                  onPressed: ()=> Navigator.of(context).pop(),
                )  
              ],*/
              );
        });
  }
}

//
//   metodos  globales de  selecciona rOpciones
//

Widget crearContenidoDialogoOpciones(BuildContext context, String icono,
    String titulo, String mensaje, List<ElementoLista> elementos) {
  return Stack(
    children: <Widget>[
      crearMarcoDialogoOpciones(context, titulo, mensaje, elementos),
      crearIconoDialogo(context, icono),
    ],
  );
}

Widget crearMarcoDialogoOpciones(BuildContext context, String titulo,
    String mensaje, List<ElementoLista> elementos) {
  return Container(
    padding: EdgeInsets.only(
      top: 30,
      bottom: 0,
      left: 16,
      right: 16,
    ),
    margin: EdgeInsets.only(top: 30),
    decoration: BoxDecoration(
        color: Colores.fondoMarco,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colores.sombra,
              blurRadius: 30,
              offset: Offset(0, 3),
              spreadRadius: 1.0)
        ]),
    child: crearElementosDialogoOpciones(context, titulo, mensaje, elementos),
  );
}

Widget crearIconoDialogo(BuildContext context, String icono) {
  return Positioned(
      top: 7,
      left: 240,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor, //  Colores.fondoIcono,
        radius: 30.0,
        child: Icono.crear(icono, 'negro', 30.0),
      ));
}

Widget crearElementosDialogoOpciones(BuildContext context, String titulo,
    String mensaje, List<ElementoLista> elementos) {
  return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    crearTituloDialogo(titulo),
    SizedBox(height: 25.0),
    crearMensajeDialogo(mensaje),
    SizedBox(height: 16.0),
    crearAccionesDialogoOpciones(context, elementos),
  ]);
}

Widget crearAccionesDialogoOpciones(
    BuildContext context, List<ElementoLista> elementos) {
  final List<Widget> opciones = [];
  for (ElementoLista elemento in elementos) {
    final widgetTemp = crearAccionDialogo(context, elemento);
    opciones..add(widgetTemp);
  }
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: opciones);
}

Widget crearAccionDialogo(BuildContext context, ElementoLista elemento) {
  return Align(child: Boton.crearTexto(context, elemento)
      //   Navigator.of(context).pop();
      //   Accion.hacer(context, elemento);
      // },
      // child: Text(elemento.titulo!,
      //     style: TextStyle(color: Colores.textoBotonAccion)),
      // )
      );
}

//
//   metodos  globales de  alerta
//

Widget crearContenidoAlerta(BuildContext context, String icono, String titulo,
    String mensaje, ElementoLista elemento) {
  return Stack(
    children: <Widget>[
      crearMarcoAlerta(context, titulo, mensaje, elemento),
      crearIconoAlerta(context, icono),
    ],
  );
}

Widget crearMarcoAlerta(BuildContext context, String titulo, String mensaje,
    ElementoLista elemento) {
  return Container(
    padding: EdgeInsets.only(
      top: 30,
      bottom: 0,
      left: 16,
      right: 16,
    ),
    margin: EdgeInsets.only(top: 30),
    decoration: BoxDecoration(
        color: Colores.fondoMarco,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colores.sombra,
              blurRadius: 30,
              offset: Offset(0, 3),
              spreadRadius: 1.0)
        ]),
    child: crearElementosAlerta(context, titulo, mensaje, elemento),
  );
}

Widget crearIconoAlerta(BuildContext context, String icono) {
  return Positioned(
      top: 7,
      left: 20,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor, //  Colores.fondoIcono,
        radius: 30.0,
        child: Icono.crear(icono, 'negro', 30.0),
      ));
}

Widget crearElementosAlerta(BuildContext context, String titulo, String mensaje,
    ElementoLista elemento) {
  return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    crearTituloDialogo(titulo),
    SizedBox(height: 25.0),
    crearMensajeDialogo(mensaje),
    SizedBox(height: 16.0),
    crearAccionAlerta(context, elemento),
  ]);
}

Widget crearAccionAlerta(BuildContext context, ElementoLista elemento) {
  return Align(child: Boton.crearTexto(context, elemento));
}

Widget crearTituloDialogo(String titulo) {
  return Text(
    titulo,
    style: TextStyle(
        color: Colores.titulo, fontSize: 24, fontWeight: FontWeight.w700),
    textAlign: TextAlign.center,
  );
}

Widget crearMensajeDialogo(String mensaje) {
  return Text(
    mensaje,
    style: TextStyle(
        color: Colores.texto, fontSize: 14, fontWeight: FontWeight.w700),
    textAlign: TextAlign.center,
  );
}
