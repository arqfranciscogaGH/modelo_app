//  librerias internas de flutter

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//  librerias  proyecto

import '../../../nucleo/nucleo.dart';

class Vista_lista extends StatefulWidget {
  Vista_lista(
      {Key? key,
      this.pagina,
      this.context,
      this.lista,
      this.metodoCrearElemento,
      this.acciones,
      this.enProceso})
      : super(key: key);
  //  parametros de  clase
  String? pagina = "";
  BuildContext? context;
  List<dynamic>? lista;
  Function? metodoCrearElemento;
  ElementoLista? acciones;
  bool? enProceso;

  @override
  _Vista_lista_estatus createState() => _Vista_lista_estatus();
}

class _Vista_lista_estatus extends State<Vista_lista> {
  //  declaración de variables

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
    // Provider.of<ControladorEstadoUI>(context, listen: false).actualizarControles;
    // listaEntidad=regresarListaEntidad();
    return Listas.mostrarLista(widget.lista!, widget.context!, widget.acciones!,
        widget.metodoCrearElemento!, widget.enProceso!);
  }

  //
  // mostrar Contenido
  //

}

//
// Termina widget
//
