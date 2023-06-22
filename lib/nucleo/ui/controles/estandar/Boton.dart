//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../nucleo.dart';

// import '../../comun/comun.dart';
// import '../../Iconos/iconos.dart';
// import '../../../../nucleo/negocio/modelo/ModeloBase.dart';

class Boton {
  static dynamic seleccionarTipoBoton(eBotonTipo tipo, ElementoLista elemento) {
    if (tipo == eBotonTipo.Rectagulo) return null;
    if (tipo == eBotonTipo.RectaguloBordes)
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(
            color: Colores.obtener(elemento.colorBorde!),
          ));
    else if (tipo == eBotonTipo.RectaguloRedondeado)
      return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          side: BorderSide(
            color: Colores.obtener(elemento.colorFondo),
          ));
    else if (tipo == eBotonTipo.RectaguloOvalo)
      return StadiumBorder();
    // else if (tipo == eBotonTipo.Pentagono)
    //   return BeveledRectangleBorder(borderRadius: BorderRadius.circular(12));
    else if (tipo == eBotonTipo.Circulo)
      return CircleBorder();
    else if (tipo == eBotonTipo.Linea) return null;
  }

  static Widget plano(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    elemento = cambioColores(elemento);
    Widget? titulo;
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));

    Widget boton = TextButton(
        // minWidth: ParametrosSistema.minAncho,
        // height: ParametrosSistema.alto,
        autofocus: true,
        style: TextButton.styleFrom(
          shape: seleccionarTipoBoton(tipo, elemento),
          backgroundColor: Colores.obtener(elemento.colorFondo),
          foregroundColor: Colores.obtener(elemento.colorTexto),
          shadowColor: Colors.greenAccent,
          disabledBackgroundColor: Colors.red,
        ),
        child: titulo,
        onPressed: () {
          Accion.hacer(context, elemento);
        });
    return boton;
  }

  static Widget planoIcono(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    elemento = cambioColores(elemento);
    Widget? icono;
    Widget? titulo;
    icono = Icono.crear(
        elemento.icono!, elemento.colorTexto, elemento.tamanoIcono!);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));

    Widget boton = TextButton.icon(
        // minWidth: ParametrosSistema.minAncho,
        // height: ParametrosSistema.alto,
        autofocus: true,
        style: TextButton.styleFrom(
          shape: seleccionarTipoBoton(tipo, elemento),
          backgroundColor: Colores.obtener(elemento.colorFondo),
          foregroundColor: Colores.obtener(elemento.colorTexto),
        ),
        icon: icono,
        label: titulo,
        onPressed: () {
          Accion.hacer(context, elemento);
        });
    return boton;
  }

  static Widget texto(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));

    return MaterialButton(
      // minWidth: ParametrosSistema.minAncho,
      // height: ParametrosSistema.alto,
      autofocus: true,
      elevation: 15,
      padding: EdgeInsets.all(10),
      shape: seleccionarTipoBoton(tipo, elemento),
      child: titulo,
      color: Colores.obtener(elemento.colorFondo),
      textColor: Colores.obtener(elemento.colorTexto),
      focusColor: Colors.amber,
      hoverColor: Colors.blue,
      splashColor: Colors.indigo,
      highlightColor: Colors.green,
      disabledColor: Colors.limeAccent,
      disabledTextColor: Colors.red,
      onPressed: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget elevado(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));
    return ElevatedButton(
      // minWidth: ParametrosSistema.minAncho,
      // height: ParametrosSistema.alto,
      autofocus: true,

      style: ElevatedButton.styleFrom(
        shape: seleccionarTipoBoton(tipo, elemento),
        elevation: 35,
        padding: EdgeInsets.all(10),
        backgroundColor: Colores.obtener(elemento.colorFondo),
        foregroundColor: Colores.obtener(elemento.colorTexto),
        // primary: Colores.obtener(elemento.colorFondo),
        // onPrimary: Colores.obtener(elemento.colorTexto),
        shadowColor: Colores.obtener(ParametrosSistema.colorSombra),
      ),
      child: titulo,
      onPressed: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget elevadoIcono(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));
    return ElevatedButton.icon(
      // minWidth: ParametrosSistema.minAncho,
      // height: ParametrosSistema.alto,
      autofocus: true,
      style: ElevatedButton.styleFrom(
        shape: seleccionarTipoBoton(tipo, elemento),
        elevation: 35,
        padding: EdgeInsets.all(10),
        backgroundColor: Colores.obtener(elemento.colorFondo),
        foregroundColor: Colores.obtener(elemento.colorTexto),
        // primary: Colores.obtener(elemento.colorFondo),
        // onPrimary: Colores.obtener(elemento.colorTexto),
        shadowColor: Colores.obtener(ParametrosSistema.colorSombra),
      ),
      icon: Icono.crear(
          elemento.icono!, elemento.colorTexto, elemento.tamanoIcono!),
      label: titulo,

      onPressed: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget lineasAfuera(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));
    return OutlinedButton(
      // minWidth: ParametrosSistema.minAncho,
      // height: ParametrosSistema.alto,
      autofocus: true,
      style: OutlinedButton.styleFrom(
        shape: seleccionarTipoBoton(tipo, elemento),
        padding: EdgeInsets.all(10),
        backgroundColor: Colores.obtener(elemento.colorFondo),
        foregroundColor: Colores.obtener(elemento.colorTexto),
        shadowColor: Colores.obtener(ParametrosSistema.colorSombra),
      ),

      child: titulo,

      onPressed: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget lineasAfueraIcono(
      BuildContext context, ElementoLista elemento, eBotonTipo tipo) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));
    return OutlinedButton.icon(
      // minWidth: ParametrosSistema.minAncho,
      // height: ParametrosSistema.alto,
      autofocus: true,
      style: OutlinedButton.styleFrom(
        shape: seleccionarTipoBoton(tipo, elemento),
        padding: EdgeInsets.all(10),
        backgroundColor: Colores.obtener(elemento.colorFondo),
        foregroundColor: Colores.obtener(elemento.colorTexto),
        shadowColor: Colores.obtener(ParametrosSistema.colorSombra),
      ),
      icon: Icono.crear(
          elemento.icono!, elemento.colorTexto, elemento.tamanoIcono!),
      label: titulo,

      onPressed: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget linkIcono(BuildContext context, ElementoLista elemento) {
    elemento = cambioColores(elemento);
    return InkWell(
      highlightColor: Colors.grey.withOpacity(0.4),
      splashColor: Colors.black.withOpacity(0.5),
      child: Icono.crear(
          elemento.icono!, elemento.colorIcono, elemento.tamanoIcono!),
      onTap: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget linkTexto(BuildContext context, ElementoLista elemento) {
    Widget? titulo;
    elemento = cambioColores(elemento);
    titulo = Text(elemento.tituloAccion == null ? '' : elemento.tituloAccion!,
        style: TextStyle(
            fontSize: elemento.tamanoFuente,
            color: Colores.obtener(elemento.colorTexto)));
    return InkWell(
      highlightColor: Colors.grey.withOpacity(0.4),
      splashColor: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(1000),
      child: titulo,
      onTap: () {
        print(" on tap ");
        Accion.hacer(context, elemento);
      },
    );
  }

  static Widget icono(BuildContext context, ElementoLista elemento) {
    elemento = cambioColores(elemento);
    Widget boton = IconButton(
        style: IconButton.styleFrom(
          shape: seleccionarTipoBoton(ParametrosSistema.tipoBoton, elemento),
          padding: EdgeInsets.all(20),
          backgroundColor: Colores.obtener(elemento.colorFondo),
          foregroundColor: Colores.obtener(elemento.colorTexto),
          shadowColor: Colores.obtener(ParametrosSistema.colorSombra),
        ),
        icon: Icono.crear(
            elemento.icono!, elemento.colorIcono, elemento.tamanoIcono!),
        color: Colors.green,
        highlightColor: Colors.red,
        hoverColor: Colors.black,
        focusColor: Colors.purple,
        splashColor: Colors.yellow,
        disabledColor: Colors.grey,
        tooltip: elemento.descripcion,
        onPressed: () {
          print(" on tap ");
          Accion.hacer(context, elemento);
        });
    return boton;
  }

  static Widget contenedorTexto(BuildContext context, ElementoLista elemento) {
    Widget boton = texto(context, elemento, ParametrosSistema.tipoBoton);
    return _crearContendorBoton(boton, elemento);
  }

  static Widget contenedorElevado(
      BuildContext context, ElementoLista elemento) {
    Widget boton = elevado(context, elemento, ParametrosSistema.tipoBoton);
    return _crearContendorBoton(boton, elemento);
  }

  static Widget contenedorLineasAfuera(
      BuildContext context, ElementoLista elemento) {
    Widget boton = lineasAfuera(context, elemento, ParametrosSistema.tipoBoton);
    return _crearContendorBoton(boton, elemento);
  }

  static Widget contenedorIcono(BuildContext context, ElementoLista elemento) {
    Widget boton = icono(context, elemento);
    return _crearContendorBoton(boton, elemento);
  }

  static Widget _crearContendorBoton(Widget boton, ElementoLista elemento) {
    if (elemento.subtitulo == null) elemento.subtitulo = "";

    Text texto = Text(elemento.subtitulo!);
    return Padding(
      padding: EdgeInsets.all(5.2),
      child: Center(
        child: Column(
          children: <Widget>[
            // boton != null ? boton : null,
            boton,
            elemento.subtitulo! != null
                ? SizedBox(height: 0)
                : SizedBox(height: 0),
            elemento.subtitulo! != null ? Text(elemento.subtitulo!) : Text(""),
            texto,
          ],
        ),
      ),
    );
  }

  static Widget columnaBotonesFlotantes(
      BuildContext context, List<ElementoLista> elementos) {
    List<Widget> botones = listaBotonesFlotantes(context, elementos, 'C');
    Column contenedor =
        Column(children: botones, mainAxisAlignment: MainAxisAlignment.center);
    return contenedor;
  }

  static Widget renglonBotonesFlotantes(
      BuildContext context, List<ElementoLista> elementos) {
    List<Widget> botones = listaBotonesFlotantes(context, elementos, 'R');
    Row contenedor =
        Row(children: botones, mainAxisAlignment: MainAxisAlignment.center);
    return contenedor;
  }

  static FloatingActionButton botonFlotante(
      BuildContext context, ElementoLista elemento) {
    Color color = Theme.of(context).backgroundColor;
    elemento = cambioColores(elemento);
    FloatingActionButton boton = FloatingActionButton(
      heroTag: "btn" + elemento.id.toString(),
      backgroundColor: Colores.obtener(elemento.colorFondo),
      onPressed: () {
        Accion.hacer(context, elemento);
      },
      tooltip: elemento.descripcion,
      child: Icono.crear(
          elemento.icono!, elemento.colorTexto, elemento.tamanoIcono),
    );
    return boton;
  }

  static List<Widget> listaBotonesFlotantes(
      BuildContext context, List<ElementoLista> elementos, String tipo) {
    List<Widget> botones = [];
    for (ElementoLista elemento in elementos) {
      Widget boton = botonFlotante(context, elemento);
      botones.add(boton);
      botones.add(tipo == 'R' ? SizedBox(width: 1) : SizedBox(height: 1));
    }
    return botones;
  }

  static ElementoLista cambioColores(ElementoLista elemento) {
    elemento.colorFondo =
        elemento.colorFondo ?? ParametrosSistema.colorBotonFondo;
    elemento.colorTexto =
        elemento.colorTexto ?? ParametrosSistema.colorBotonTexto;
    elemento.colorIcono =
        elemento.colorIcono ?? ParametrosSistema.colorBotonIcono;
    elemento.colorBorde =
        elemento.colorBorde ?? ParametrosSistema.colorBotonBorde;
    elemento.tamanoFuente =
        elemento.tamanoFuente ?? ParametrosSistema.tamanoFuente;
    elemento.tamanoIcono =
        elemento.tamanoIcono ?? ParametrosSistema.tamanoIcono;
    return elemento;
  }
}
