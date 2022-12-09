//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../nucleo/negocio/modelo/modeloBase.dart';
import '../../../nucleo/negocio/modelo/endidad/ElementoLista.dart';
import 'OpcionesMenus.dart';
import 'PaginaAnimacion.dart';

class Accion {
  BuildContext context;
  ElementoLista elemento;
  dynamic argumentos;
  static String paginaActual = "";
  static String paginaAnterior = "";
  Accion({required this.context, required this.elemento, this.argumentos});

  static hacer(BuildContext context, ElementoLista elemento,
      [dynamic argumento]) {
    if (argumento == null && elemento.argumento != null)
      argumento = elemento.argumento;
    if (elemento != null && elemento.accion != null)
      ejecutarAccion(context, elemento, argumento);
    else if ((elemento != null && elemento.ruta != null) &&
        (elemento.pagina == null))
      ejecutarRuta(context, elemento, argumento);
    else if ((elemento != null) && (elemento.pagina != null))
      animar(context, elemento, argumento);
    else
      Accion.regresar(context);
  }

  static ejecutarAccion(BuildContext context, ElementoLista elemento,
      [dynamic argumento]) {
    if (argumento == null && elemento.argumento != null)
      argumento = elemento.argumento;
    if (elemento.accion != null || elemento.accion != "")
      elemento.accion!(context, elemento, argumento);
    else if (elemento.accion! != null)
      elemento.accion!(context, elemento, argumento);
  }

  static ejecutarRuta(BuildContext context, ElementoLista elemento,
      [dynamic argumento]) {
    if (elemento.ruta!.toUpperCase().contains("REGRESAR")) {
      Navigator.pop(context);
    } else if ((elemento.ruta != null || elemento.ruta != "") &&
        argumento == null) {
      Navigator.pushNamed(context, elemento.ruta!);
    } else if ((elemento.ruta != null || elemento.ruta != "") &&
        argumento != null) {
      Navigator.of(context).pushNamed(elemento.ruta!, arguments: argumento);
    }
    cambiarPagina(elemento.ruta!);
  }

  static cambiarPagina(String pagina) {
    if (paginaActual != null && paginaAnterior != paginaActual)
      paginaAnterior = paginaActual;
    else
      paginaAnterior = pagina;
    if (pagina != null) paginaActual = pagina;
  }

  static animar(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    if ((elemento != null || elemento.pagina != null)) {
      switch (elemento.animacionPagina!) {
        case eAnimacionPagina.slideRightRoute:
          Navigator.push(context, SlideRightRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.scaleRoute:
          Navigator.push(context, ScaleRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.rotationRoute:
          Navigator.push(context, RotationRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.sizeRoute:
          Navigator.push(context, SizeRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.fadeRoute:
          Navigator.push(context, FadeRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.scaleRotateRoute:
          Navigator.push(context, ScaleRotateRoute(page: elemento.pagina!));
          break;
        case eAnimacionPagina.enterExitRoute:
          Navigator.push(
              context,
              EnterExitRoute(
                  enterPage: elemento.pagina!, exitPage: elemento.pagina2!));
          break;
        default:
          Navigator.push(context, ScaleRotateRoute(page: elemento.pagina!));
          break;
      }
    }
  }

  static mostrarSiguientePagina(BuildContext context, dynamic widget) {
    if (widget == null)
      Accion.regresar(context);
    else if (widget.paginaAnterior == null && widget.paginaSiguiente == null)
      Accion.regresar(context);
    else if (widget.paginaSiguiente != null)
      Accion.hacer(context, OpcionesMenus.obtener(widget.paginaSiguiente));
    else if (widget.paginaAnterior != null)
      Accion.hacer(context, OpcionesMenus.obtener(widget.paginaAnterior));
  }

  static regresar(BuildContext context) {
    Navigator.pop(context);
  }
}
