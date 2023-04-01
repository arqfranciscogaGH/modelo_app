//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias  proyecto

import '../nucleo/negocio/controladorEstado/ControlEstadoUI.dart';

import '../aplicacion/contexto/ContextoAplicacion.dart';
export '../aplicacion/contexto/ContextoAplicacion.dart';

class InicializacionEntidades {
  static void iniciar() async {
    await ContextoAplicacion.iniciar();

    await cargarEntidades();
  }

  static cargarEntidades() async {
    // declarar  variables
    // declarar configuracion

    // declarar entidades

    // venta

    Venta v = Venta().iniciar();
    v.nombre = 'fga';

    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 2;
    v.nombre = 'dos';
    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 3;
    v.nombre = 'tres';
    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 4;
    v.nombre = 'cuatro';
    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 5;
    v.nombre = 'cinco';
    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 6;
    v.nombre = 'seis';

    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    v = Venta().iniciar();
    v.id = 7;
    v.nombre = 'siete';
    await ContextoAplicacion.db.tablaVenta!
        .insertar(v)
        .then((respuesta) => {print(respuesta)});

    await ContextoAplicacion.db.tablaVenta!
        .consultarTabla(ContextoAplicacion.db.tablaVenta!.entidad)
        .then((respuesta) => {print(respuesta)});

//////////////////////////////////////////////////////////////////////////////////////////

    // tablaAutenticacion

    // obtener  token por  get y parametros en url
    ContextoAplicacion.db.tablaAutenticacion!.configuracion!.llaveApi = "";

    Map<String, String> parametros = {
      'id': '1',
      'cuenta': 'giorgio',
      'clave': '123',
      'operacion': 'registrar',
      'estacionTrabajo': 'fga',
    };

    await ContextoAplicacion.db.tablaAutenticacion!
        .ejecutar(ContextoAplicacion.db.tablaAutenticacion!.entidad, parametros)
        .then((respuesta) {
      if (respuesta != null) {
        ContextoAplicacion.db.tablaAutenticacion!.configuracion!.llaveApi =
            respuesta[0]["llave"];
        String diass = respuesta[0]["diasVigencia"].toString();
        int dias = int.parse(diass);

        print(respuesta);
      }
    });
    print(ContextoAplicacion.db.tablaAutenticacion!.entidad.llave);

    // obetenr  token por  post
    ContextoAplicacion.db.tablaAutenticacion!.configuracion!.llaveApi = "";

    // ContextoAplicacion.db.tablaAutenticacion!.configuracion!.llaveApi =
    //     "794B0B5A-6BE3-4523-B16C-FC24E884AACE";
    ContextoAplicacion.db.tablaAutenticacion!.entidad.id = 1;
    ContextoAplicacion.db.tablaAutenticacion!.entidad.cuenta = 'giorgio';
    ContextoAplicacion.db.tablaAutenticacion!.entidad.clave = '123';
    ContextoAplicacion.db.tablaAutenticacion!.entidad.operacion = 'insertar';
    ContextoAplicacion.db.tablaAutenticacion!.entidad.estacionTrabajo = 'VVVV';

    await ContextoAplicacion.db.tablaAutenticacion!
        .insertar(ContextoAplicacion.db.tablaAutenticacion!.entidad)
        .then((respuesta) {
      if (respuesta != null)
        ContextoAplicacion.db.tablaAutenticacion!.configuracion!.llaveApi =
            respuesta.llave;
      print(respuesta);
    });

    print(ContextoAplicacion.db.tablaAutenticacion!.entidad.llave);

    // tablaProducto

    ContextoAplicacion.db.tablaProducto!.configuracion!.llaveApi =
        ContextoAplicacion.db.tablaAutenticacion!.entidad.llave!;

    print(ContextoAplicacion.db.tablaProducto!.configuracion!.llaveApi);

    await ContextoAplicacion.db.tablaProducto!
        .consultarTabla(ContextoAplicacion.db.tablaProducto!.entidad)
        .then((respuesta) => {print(respuesta)});

    ContextoAplicacion.db.tablaProducto!.paginador.registrosPorPagina = 100;
    ContextoAplicacion.db.tablaProducto!.paginador.estatus = 1;
    await ContextoAplicacion.db.tablaProducto!
        .consultarPaginacionTabla(ContextoAplicacion.db.tablaProducto!.entidad)
        .then((respuesta) => {print(respuesta)});

    // tablaCuentaUsuario

    ContextoAplicacion.db.tablaCuentaUsuario!.configuracion!.llaveApi =
        ContextoAplicacion.db.tablaAutenticacion!.entidad.llave!;

    print(ContextoAplicacion.db.tablaCuentaUsuario!.configuracion!.llaveApi);

    await ContextoAplicacion.db.tablaCuentaUsuario!
        .consultarTabla(ContextoAplicacion.db.tablaCuentaUsuario!.entidad)
        .then((respuesta) => {print(respuesta)});

    ContextoAplicacion.db.tablaCuentaUsuario!.entidad =
        ContextoAplicacion.db.tablaCuentaUsuario!.iniciar();

    ContextoAplicacion.db.tablaCuentaUsuario!.controlEstadoUI =
        ControlEstadoUI();

    ContextoAplicacion.db.tablaCuentaUsuario!.paginador.registrosPorPagina =
        100;
    ContextoAplicacion.db.tablaCuentaUsuario!.paginador.estatus = 1;
    await ContextoAplicacion.db.tablaCuentaUsuario!
        .consultarPaginacionTabla(
            ContextoAplicacion.db.tablaCuentaUsuario!.entidad)
        .then((respuesta) => {print(respuesta)});

    // print(ContextoAplicacion.db.tablaCliente!.lista.length);
    // print(ContextoAplicacion.db.tablaVenta!.lista.length);

    // AccesoTabla<EntidadBase>? tablaModelo;
    // AccesoTabla<EntidadBase>? tablaModelo2;

    // EntidadBase eb = EntidadBase();
    // eb = EntidadBase( campoLLave: 'id' ,  nombreTabla: 'EntidadBase', nombre: 'hola');
    // eb =eb.iniciar();
    // eb.id=1;
    // eb.nombre='fga';

    //  entidad  - map

    // Map<String, dynamic> map;
    // map=eb.toMap();
    // map["nombre"]="cambio map ";
    // eb.fromMap(map);

    // map =tabla.entidad.toMap();
    // tabla.entidad.fromMap(map);

    // dynamic map1 =tabla.entidad;
    // dynamic map2 =tabla.entidad;

    // //  entidad  - json
    // eb.clave='Json';
    // String cadenaJson =eb.toJson();
    // eb.clave='';
    // eb.fromJson(cadenaJson);

    //   asignacion de entidades , datos y  lista por  fuera

    // print( tabla.registro.datos );
    // tabla.entidad.nombre="cambio II";
    // tabla.registro.datos=map;
    // tabla.entidad=eb;
    // print( tabla.registro.datos );
    // print( tabla.entidad.nombre );
    // print( tabla.registro.datos["nombre"] );

    // tabla.registro.datos=map;
    // print( tabla.registro.datos );
    // print( tabla.entidad.nombre );
    // print( tabla.registro.datos["nombre"] );

    //  cambiar datos  de  entidad, registro y  tabla

    // tabla.registro.datos["nombre"]="cambio III";
    // tabla.registro.c("nombre", "tercero ");

    // obtener datos  datos  de  entidad , y registro y  tabla

    // print (map["nombre"]);
    // print( tabla.registro.datos["nombre"] );
    // print( tabla.registro.o("nombre")) ;
    // print( tabla.registro.oid) ;

    //  asignar  lista  entidad

    // print(tabla.lista.length);
    // print(tabla.tabla.datos.length);

    // List<EntidadBase> lista_entidad =[];
    // lista_entidad.add(eb);

    // tabla.lista=lista_entidad;

    // print(tabla.lista.length);

    // print(tabla.tabla.datos.length);

    //  lista  map  texto

    // List<Map<String,dynamic>> lista_mapa=[];

    // lista_mapa.add(map);
    // lista_mapa.add( {
    //                   "id": 2,
    //                   "llave":  "",
    //                   "clave": "" ,
    //                   "nombre": "nuevo" ,
    //                   "descripcion": "" ,
    //                   "tabla":  ""
    //                 }
    // );

    // tabla.tabla.datos=lista_mapa;

    // print(tabla.lista.length);

    // print(tabla.tabla.datos.length);

    // print(tabla.tabla.datos);
    // print ( tabla.registro.datos);
    // print (lista_mapa);

    // dynamic b=lista_mapa.firstWhere((o) => o['nombre']=="nuevo");
    // b=tabla.tabla.datos.firstWhere((o) => o["nombre"]=="nuevo");
    // print (b);

    // dynamic d=tabla.lista.firstWhere((o) => o.nombre=="nuevo");

    // // print (d.nombre );

    // //  acceso a listas

    // List<Map<String,dynamic>> c=lista_entidad.map((c) => c.toMap()).toList();
    // print (c);
    // c=tabla.lista.map((c) => c.toMap()).toList();
    // print (c);

    // print(tablaModelo.lista.length);
    // print(tablaModelo.tabla.datos.length);
    // print(tablaModelo.tabla.datos);
    // print ( tablaModelo.registro.datos);

    //  await  tablaModelo.consultarTabla(tablaModelo.entidad).then((respuesta) =>{
    //     print ( respuesta)
    //   });

    // print(tablaModelo.lista.length);
    // print(tablaModelo.tabla.datos.length);
    // print(tablaModelo.tabla.datos);
    // print ( tablaModelo.registro.datos);

    // await tablaModelo.consultarTabla(tablaModelo.entidad).then((respuesta) =>{
    //     print ( respuesta)
    // });

    // agregar  elementos
    //   EntidadBase uno=EntidadBase(nombre: 'uno').iniciar();
    // //  uno.id=2;
    //   uno.nombre='uno';
    //   EntidadBase dos=EntidadBase(nombre: 'dos').iniciar();
    //   // dos.id=3;
    //   dos.nombre='dos';
    //   EntidadBase tres=EntidadBase(nombre: 'tres');
    //  tres.id=4;
    //   tres.nombre='tres';

    // tabla.lista.add(dos);
    // tabla.lista.add(tres);

    // //  memoria
    //   await tablaModelo.insertar(uno).then((respuesta) =>{
    //       print ( respuesta)
    //   });
    //  await  tablaModelo.consultarTabla(tablaModelo.entidad).then((respuesta) =>{
    //     print ( respuesta)
    //   });
    //   await  tablaModelo.insertar(dos).then((respuesta) =>{
    //       print ( respuesta)
    //   });
    //  await  tablaModelo.consultarTabla(tablaModelo.entidad).then((respuesta) =>{
    //     print ( respuesta)
    //   });
    //   await tablaModelo.insertar(tres).then((respuesta) =>{
    //       print ( respuesta)
    //   });

    //  await  tablaModelo.consultarTabla(tablaModelo.entidad).then((respuesta) =>{
    //     print ( respuesta)
    //   });

    //   print(tablaModelo.lista.length);
    //   print(tablaModelo.tabla.datos.length);
    //   print(tablaModelo.tabla.datos);
    //   print ( tablaModelo.registro.datos);

    //  dynamic x=tablaModelo.lista.firstWhere((o) => o.nombre.toString().contains("dos"));
    // // dynamic y=tabla.lista.firstWhere((o) => o.nombre=="tres");

    // print (x. nombre);
    // // print (y);
    // dos.nombre="dosfga";
    // await tablaModelo.actualizar(dos).then((respuesta) =>{
    //       print ( respuesta)
    // });
    // await tablaModelo.eliminar(tres).then((respuesta) =>{
    //       print ( respuesta)
    // });

    // await  tablaModelo2.consultarTabla(tablaModelo2.entidad).then((respuesta) =>{
    //       print ( respuesta)
    // });
    // uno.id=null;
    // await tablaModelo2.insertar(uno).then((respuesta) =>{
    //     print ( respuesta)
    // });
    // dos.id=null;
    // await tablaModelo2.insertar(dos).then((respuesta) =>{
    //     print ( respuesta)
    // });
    // await  tablaModelo2.consultarTabla(tablaModelo2.entidad).then((respuesta) =>{
    //       print ( respuesta)
    // });
    // print(tablaModelo2.lista.length);
    // print(tablaModelo2.tabla.datos.length);
    // print(tablaModelo2.tabla.datos);
    // print ( tablaModelo2.registro.datos);

    // tabla.consultarTabla(tabla.entidad).then((respuesta) =>{
    //       print ( respuesta)
    // });

    // print(tablaModelo.lista.length);
    // print(tablaModelo.tabla.datos.length);
    // print(tablaModelo.tabla.datos);
    // print ( tablaModelo.registro.datos);

    // print(  tabla.tabla.datos[0]["nombre"] ) ;

    // var s=tabla.lista.firstWhere( (o) => o.nombre=="nuevo" , orElse: ()=> EntidadBase() );
    // var r=lista_entidad.firstWhere( (o) => o.nombre=="nnuevo" , orElse: ()=> EntidadBase() );
  }
}
