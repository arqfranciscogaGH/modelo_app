//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter
//import 'package:flushbar/flushbar.dart';

//  librerias  proyecto

import '../../nucleo.dart';

class Notificacion {
  static SnackBar mostrar(
      BuildContext context,
      // GlobalKey<ScaffoldState> _scaffoldKey,
      String mensaje) {
    SnackBar barra = SnackBar(
      content: Text(mensaje),
    );
    //Scaffold.of(context).showSnackBar(barra); // no funciona
    // _scaffoldKey.currentState.showSnackBar(barra);
    ScaffoldMessenger.of(context).showSnackBar(barra);
    return barra;
  }

  static SnackBar mostrarAccion(
      BuildContext context,
      // GlobalKey<ScaffoldState> _scaffoldKey,
      ElementoLista elemento) {
    SnackBar barra = SnackBar(
      content: Text(elemento.mensaje!),
      action: SnackBarAction(
        label: elemento.tituloAccion!,
        onPressed: () {
          Accion.hacer(context, elemento);
        },
      ),
    );
    //Scaffold.of(context).showSnackBar(barra); // no funciona
    // _scaffoldKey.currentState.showSnackBar(barra);
    ScaffoldMessenger.of(context).showSnackBar(barra);
    return barra;
  }
  // static void notificarOtro(BuildContext context, String titulo, String mensaje,
  //     String textoAccion, ElementoLista elemento) {
  //   int duracion = 15;
  //   Flushbar(
  //     padding: EdgeInsets.all(10),
  //     title: titulo,
  //     message: mensaje,
  //     icon: Icon(Icons.info_outline, size: 30),
  //     leftBarIndicatorColor: Colors.cyan,
  //     duration: Duration(seconds: duracion),
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     borderRadius: 8,
  //     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  //     backgroundGradient: LinearGradient(
  //         colors: [Colors.deepPurple, Colors.green], stops: [0.6, 1]),
  //     boxShadows: [
  //       BoxShadow(color: Colors.black, offset: Offset(3, 3), blurRadius: 3)
  //     ],
  //     mainButton: FlatButton(
  //       child: Text(
  //         textoAccion,
  //         style: TextStyle(color: Theme.of(context).accentColor),
  //       ),
  //       onPressed: () {
  //         Accion.hacer(context, elemento);
  //       },
  //     ),
  //   ).show(context);
  // }
}
