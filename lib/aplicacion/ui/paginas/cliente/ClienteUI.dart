//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:io';

//  librerias importadas flutter
// import 'package:image_picker/image_picker.dart';

//  librerias  proyecto

//  librerias  proyecto

import '../../../../configuracion/configuracion.dart';
import '../../../contexto/contexto.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';

//  librerias externas  flutter

// class ejemploclase<T extends EntidadBase> {
//   T clase;
//   ejemploclase({required this.clase}) {}
//   iniciar<T extends EntidadBase>(AccesoTabla<T> tabla) {}
// }

// class ejemplometodo {
//   iniciar<T extends EntidadBase>(T entidad, AccesoTabla<T> tabla) {}
// }

class ClienteUI<T extends EntidadBase> {
  ClienteUI(
      {required this.tabla,
      this.context,
      this.widget,
      this.scaffoldKey,
      this.keyFormulario});

  // dynamic iniciarEntidad<T extends EntidadBase>(AccesoTabla<T> tabla) {
  //   tabla.entidad = tabla.iniciar();
  //   return tabla.entidad;
  // }

  AccesoTabla<T>? tabla;
  BuildContext? context;
  Widget? widget;
  GlobalKey<ScaffoldState>? scaffoldKey;
  GlobalKey<FormState>? keyFormulario;

  //  dispose widget
  // void dispose() {

  // }

  @override
  void dispose() {}

  iniciar(BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
      [dynamic widget]) {
    this.context = context;
    this.scaffoldKey = scaffoldKey;
    this.widget = widget;

    // ejemploclase<Venta> ec = ejemploclase<Venta>(clase: Venta());
    // ec.iniciar<Venta>(ContextoAplicacion.db.tablaVenta!);
    // ejemplometodo em = ejemplometodo();
    // em.iniciar<Venta>(Venta(), ContextoAplicacion.db.tablaVenta!);
  }
  //
  //  interfaz de UI  comun
  //

  //
  // crear elemento de lista
  //

  Widget crearElementoEntidad(
      BuildContext context, dynamic entidad, ElementoLista accion) {
    ElementoLista elemento = ElementoLista();

    //
    //  asigna la  información  requerida para genere widget elemento de la lista
    //

    elemento.id = entidad.id;
    elemento.titulo = entidad.id.toString() + ', : ' + entidad.nombre;
    elemento.subtitulo = "";

    elemento.icono = accion.icono;
    elemento.accion = accion.accion;
    elemento.callBackAccion = accion.callBackAccion;
    elemento.ruta = accion.ruta;

    elemento.icono2 = accion.icono2;
    elemento.accion2 = accion.accion2;
    elemento.callBackAccion2 = accion.callBackAccion2;
    elemento.ruta2 = accion.ruta2;

    elemento.icono3 = accion.icono3;
    elemento.accion3 = accion.accion3;
    elemento.callBackAccion3 = accion.callBackAccion3;
    elemento.ruta3 = accion.ruta3;

    elemento.operacion = accion.operacion;

    // if (elemento.color == null)
    //   elemento.color = Theme.of(context).primaryColor.withOpacity(0.6);

    //
    //  crea el gidget elemento de la lista con sus aciones segun lo se requiera
    //  con la accion Dismisible y acciones mas

    // ESTAS  SON LAS OPCIONES PARA  crear los elementos :

    //  Listas.crearTituloElemento
    //  Listas.crearElementoConAcciones
    //  Listas.crearElementoLista
    //  Listas.crearElementoListaCheck
    //
    Widget? elementos;
    if (accion.operacion == eOperacion.consultar) {
      elementos = Listas.crearElementoListaDismisibleConAcciones(
          context, elemento, accion.accion!, accion.accion2!);
    } else if (accion.operacion == eOperacion.filtrar) {
      elementos = Listas.crearElementoListaDismisibleConAcciones(
          context, elemento, accion.accion!, accion.accion2!);
    }

    // if (ele.operacion == eOperacion.consultar) {
    //   elementos = Listas.crearElementoConAcciones(context, elemento);
    // } else if (ele.operacion == eOperacion.filtrar) {
    //   elementos = Listas.crearElementoConAcciones(context, elemento);
    // }
    return elementos!;
  }

  //
  //  Crear  Boton  acciones
  //

  Column crearBotonesAcciones(
      BuildContext context, activarAcciones, ElementoLista accion) {
    Column? columna;
    if ((activarAcciones != null && activarAcciones))
      columna = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // FloatingActionButton (
          //   heroTag: "btn10",
          //   child: Icon (Icons.zoom_in ),
          //   onPressed: () {
          //     },
          // ),

          Boton.botonFlotante(context, accion),
        ],
      );
    return columna!;
  }

  //
  //  accciones
  //

  //
  //  acccion   Agregar
  //
  void agregarElemento(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    // ContextoUI.iniciarCaptura = true;
    tabla!.entidad = tabla!.iniciarEntidad();

    // se  usa las siguientes si requiere callback o ir otra pagina
    if (elemento.callBackAccion != null)
      elemento.callBackAccion!(context, elemento, tabla!.entidad);
  }

  //
  //   respuestas   Agregar
  //

  void respuestaAgregar(BuildContext context, elemento, dynamic entidad) {
    //  obtiene  etiquetas considerando el idioma

    String titulo =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionAgregar', 'titulo');
    String icono =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionAgregar', 'icono');
    String mensaje =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionAgregar', 'mensaje');
    String opciones =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionAgregar', 'opciones');

    //   crear la  accion  para  notificar

    // ElementoLista accion = ElementoLista(
    //     tituloAccion: titulo,
    //     mensaje: mensaje ,
    //     ruta: elemento.ruta );
    //Notificacion.mostrarAccion(context, accion);

    // muestra  la notificación
    Notificacion.mostrar(context, mensaje);

    // ejecuta  la  siguinte pagina
    Accion.mostrarPagina(this.context!, widget, "siguiente");
    // Accion.hacer(context, OpcionesMenus.obtener(elemento.ruta));
  }

  //
  //  acccion   Seleccionar
  //
  void seleccionarElemento(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    dynamic entidad = tabla!.iniciarEntidad();
    entidad.id = elemento.id;
    tabla!.obtener(entidad, elemento.callBackAccion);
  }

//
//   respuestas   Seleccionar
//

  void respuestaSeleccionar(dynamic entidad) {
    ElementoLista elemento = ElementoLista();
    //  obtiene  etiquetas considerando el idioma
    String titulo =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionSeleccionar', 'titulo');
    String icono =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionSeleccionar', 'icono');
    String mensaje = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionSeleccionar', 'mensaje');
    String opciones = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionSeleccionar', 'opciones');

    //   Asigna información  la  accion  para  mostrar de mensaje de alerta

    mensaje = mensaje + " " + entidad.id.toString() + " : " + entidad.nombre!;
    elemento.titulo = titulo;
    elemento.icono = icono;
    elemento.mensaje = mensaje;
    elemento.tituloAccion = opciones;

    //  muestar  mensaje de  alerta
    Notificacion.mostrar(this.context!, elemento.mensaje!);
    // Dialogo.mostrarAlerta(this.context, elemento);

    // ejecuta  la  siguinte pagina

    Accion.mostrarPagina(this.context!, widget, "siguiente");
    // Accion.hacer(context, OpcionesMenus.obtener(elemento.ruta));
  }

  void seleccionarElemento3(BuildContext context, ElementoLista elemento) {}

  void respuestaSeleccionar3(
      BuildContext context, ElementoLista elemento, dynamic entidad) {}

  //
  //   acccion   guardar  informacion
  //

  void guardar(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    dynamic entidadCaptura = tabla!.entidad;

    if (!keyFormulario!.currentState!.validate()) return;
    keyFormulario!.currentState!.save();

    print("guardar");
    print(tabla!.entidad.id);
    print(entidadCaptura.id);

    if (entidadCaptura.id == null || entidadCaptura.id == 0)
      insertar(context, elemento, entidadCaptura);
    else
      modificar(context, elemento, entidadCaptura);
  }

  //
  //  acccion  insertar
  //

  void insertar(BuildContext context, ElementoLista elemento, dynamic entidad) {
    String titulo =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionInsertar', 'titulo');
    String mensaje =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionInsertar', 'mensaje');
    String icono =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionInsertar', 'icono');
    String opciones =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionInsertar', 'opciones');

    //   crear la  accion  para  Dialogo
    ElementoLista elementoDialogo = ElementoLista(
      titulo: titulo,
      tituloAccion: opciones,
      icono: icono,
      mensaje: mensaje + " : " + entidad.nombre!,
      argumento: entidad, /* accion: elemento.callBackAccion */
    );

    tabla!.insertar(entidad, elemento.callBackAccion2).then((respuesta) {
      print("insertar");
      entidad = respuesta;
      print(tabla!.entidad);
      print(respuesta);
      mensaje = mensaje + " " + entidad.id.toString() + " : " + entidad.nombre!;
      elementoDialogo.mensaje = mensaje;
      // muestra  la notificación
      Notificacion.mostrar(context, mensaje);
      Dialogo.mostrarAlerta(context, elementoDialogo);
    });
  }

  //
  //   respuestas   Insertar
  //

  void respuestaInsertar(
      /*    BuildContext context, ElementoLista elemento, */ dynamic entidad) {
    Accion.mostrarPagina(this.context!, widget, "anterior");
  }

  //
  //   acccion  Modificar
  //

  void modificar(
      BuildContext context, ElementoLista elemento, dynamic entidad) {
    String titulo =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionModificar', 'titulo');
    String mensaje =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionModificar', 'mensaje');
    String icono =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionModificar', 'icono');
    String opciones =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionModificar', 'opciones');

    mensaje = mensaje + " " + entidad.id.toString() + " : " + entidad.nombre!;

    ElementoLista elementoDialogo = ElementoLista(
      titulo: titulo,
      tituloAccion: opciones,
      icono: icono,
      mensaje: mensaje,
      argumento: entidad, /*  accion: elemento.callBackAccion */
    );

    tabla!.modificar(entidad, elemento.callBackAccion3).then((respuesta) {
      print("modificar");
      entidad = respuesta;

      print(respuesta);
      Notificacion.mostrar(context, mensaje);
      Dialogo.mostrarAlerta(this.context!, elementoDialogo);
    });
  }

  //
  //   respuestas   Modificar
  //

  void respuestaModificar(
      /*     BuildContext context, ElementoLista elemento,  */ dynamic
          entidad) {
    Accion.mostrarPagina(this.context!, widget, "anterior");
  }

  //
  //  acccion    Eliminar
  //

  void eliminarElemento(BuildContext context, ElementoLista elemento) {
    String titulo = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionConfirmarEliminacion', 'titulo');
    String mensaje = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionConfirmarEliminacion', 'mensaje');
    String icono = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionConfirmarEliminacion', 'icono');
    String opciones = Traductor.obtenerAtrbuto(
        'comun_pagina', 'accionConfirmarEliminacion', 'opciones');

    dynamic opcion = opciones.split(" ");

    List<ElementoLista> elementos = [];
    // se debe pasar como argumeto  el elemento eleccionado
    elementos.add(new ElementoLista(
        titulo: opcion[0],
        tituloAccion: opcion[0],
        accion: comfirmarEliminarElemento,
        argumento: elemento));
    elementos.add(new ElementoLista(
        titulo: opcion[1],
        tituloAccion: opcion[1],
        accion: comfirmarEliminarElemento,
        argumento: elemento));
    print(icono);
    Dialogo.seleccionarOpciones(context, icono, titulo, mensaje, elementos);
  }

  void comfirmarEliminarElemento(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    // dynamic entidad =
    //     provider!.obtenerEntidadDeLista(context, elemento.argumento, null);
    // se debe pasar como argumeto  el elemento eleccionado
    String titulo =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionEliminar', 'titulo');
    String mensaje =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionEliminar', 'mensaje');
    String icono =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionEliminar', 'icono');
    String opciones =
        Traductor.obtenerAtrbuto('comun_pagina', 'accionEliminar', 'opciones');
    String mensajeOperacion =
        Traductor.obtenerAtrbuto('comun_pagina', 'operacionExitosa', 'mensaje');

    if (elemento.titulo.toString().trim().toLowerCase() == "si") {
      //   crear la  accion  para  Dialogo
      ElementoLista elementoDialogo = ElementoLista(
        titulo: titulo,
        tituloAccion: opciones,
        icono: icono,
        mensaje: mensaje,
        // accion: elemento.argumento.callBackAccion2,
        argumento: elemento, /* accion: elemento.callBackAccion */
      );

      tabla!.entidad = tabla!.iniciarEntidad();
      tabla!.entidad.id = elemento.argumento.id;
      tabla!.obtener(tabla!.entidad).then((entidad) {
        mensaje =
            mensaje + " " + entidad.id.toString() + " : " + entidad.nombre!;
        elementoDialogo.mensaje = mensaje;
        tabla!
            .eliminar(entidad, elemento.argumento.callBackAccion2)
            .then((respuesta) {
          print(respuesta);
          Notificacion.mostrar(context, mensaje);
          Dialogo.mostrarAlerta(context, elementoDialogo);
        });
      });
    } else
      Accion.mostrarPagina(this.context!, widget, "anterior");
    // Accion.regresar(context);
  }

//
//  respuestas   Eliminar
//

  void respuestaEliminar(dynamic entidad) {
    Accion.mostrarPagina(this.context!, widget, "anterior");
  }

//
//  respuestas   filtrar
//

  //
  // imprimir  información
  //
  void imprimir(dynamic entidadCaptura, [String comentario = '']) {
    comentario = comentario == null ? " imprimir " : comentario;
    print(comentario);
    print(" entidad        :${entidadCaptura.tabla}");
    print(" id             :${entidadCaptura.id}");
    print(" nombre         :${entidadCaptura.nombre}");
    print(entidadCaptura.toMap());
  }
}
