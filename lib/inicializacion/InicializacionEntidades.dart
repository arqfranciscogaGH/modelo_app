//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias  proyecto

import '../aplicacion/contexto/Contexto.dart';
export '../aplicacion/contexto/Contexto.dart';

class InicializacionEntidades {
  static void iniciar() async {
    await cargarEntidades();
  }

  static cargarEntidades() async {
    // declarar  variables
    // declarar configuracion

    // declarar entidades

    // CuentaUsuario

    // CuentaUsuario cu = CuentaUsuario().iniciar();
    // cu.id = 1;
    // cu.nombre = 'Administrador';
    // cu.perfiles = "administrador";
    // cu.cuenta = "admin";
    // cu.contrasena = "123";

    // await ContextoApp.db.cuentaUsuario!
    //     .insertar(cu)
    //     .then((respuesta) => {print(respuesta)});

    // Cliente

    Cliente c = Cliente().iniciar();
    c.id = null;
    c.nombre = 'Mostrador';

    await ContextoApp.db.cliente!
        .consultarTabla(ContextoApp.db.cliente!.entidad)
        .then((respuesta) => {print(respuesta)});

    if (ContextoApp.db.cliente!.lista.length == 0) {
      // print(c.toJson());
      print(c.fromJson(c.toJson()));

      await ContextoApp.db.cliente!
          .insertar(c)
          .then((respuesta) => {print(respuesta)});

      c = Cliente().iniciar();
      c.id = null;
      c.nombre = 'Francisco Garcia';
      await ContextoApp.db.cliente!
          .insertar(c)
          .then((respuesta) => {print(respuesta)});

      c = Cliente().iniciar();
      c.id = null;
      c.nombre = 'Fernando Garcia';
      await ContextoApp.db.cliente!
          .insertar(c)
          .then((respuesta) => {print(respuesta)});
    }

    await ContextoApp.db.cliente!
        .consultarTabla(ContextoApp.db.cliente!.entidad)
        .then((respuesta) => {print(respuesta)});

    // producto

    // ContextoApp.db.producto!.configuracion!.llaveApi =
    //     ContextoApp.db.tablaAutenticacion!.entidad.llave!;

    print(ContextoApp.db.producto!.configuracion!.llaveApi);

    await ContextoApp.db.producto!
        .consultarTabla(ContextoApp.db.producto!.entidad)
        .then((respuesta) => {print(respuesta)});

    ContextoApp.db.producto!.paginador.registrosPorPagina = 100;
    ContextoApp.db.producto!.paginador.estatus = 1;
    await ContextoApp.db.producto!
        .consultarPaginacionTabla(ContextoApp.db.producto!.entidad)
        .then((respuesta) => {print(respuesta)});

    // venta

    // Venta v = Venta().iniciar();
    // v.id = 1;
    // v.nombreCliente = 'fga';
    // v.importeVenta = 100;
    // v.referencia = "uno";
    // v.idMesa = 2;
    // v.idCliente = 1;
    // v.idVendedor = 3;

    // await ContextoApp.db.venta!
    //     .insertar(v)
    //     .then((respuesta) => {print(respuesta)});

    // v = Venta().iniciar();
    // v.id = 2;
    // v.idCliente = 2;
    // v.nombreCliente = 'francisco';
    // v.importeVenta = 200;
    // v.referencia = "uno";
    // v.idMesa = 2;
    // v.idVendedor = 3;

    // await ContextoApp.db.venta!
    //     .insertar(v)
    //     .then((respuesta) => {print(respuesta)});

    // v = Venta().iniciar();
    // v.id = 3;
    // v.idCliente = 3;
    // v.nombreCliente = 'fernado';
    // v.importeVenta = 300;
    // v.referencia = "uno";
    // v.idMesa = 2;
    // v.idVendedor = 3;

    // await ContextoApp.db.venta!
    //     .insertar(v)
    //     .then((respuesta) => {print(respuesta)});

// //////////////////////////////////////////////////////////////////////////////////////////

/*
    // tablaAutenticacion

    // obtener  token por  get y parametros en url

    ContextoApp.db.tablaAutenticacion!.configuracion!.llaveApi = "";

    Map<String, String> parametros = {
      'id': '1',
      'cuenta': 'giorgio',
      'clave': '123',
      'operacion': 'registrar',
      'estacionTrabajo': 'fga',
    };

    await ContextoApp.db.tablaAutenticacion!
        .ejecutar(ContextoApp.db.tablaAutenticacion!.entidad, parametros)
        .then((respuesta) {
      if (respuesta != null) {
        ContextoApp.db.tablaAutenticacion!.configuracion!.llaveApi =
            respuesta[0]["llave"];
        String diass = respuesta[0]["diasVigencia"].toString();
        int dias = int.parse(diass);

        print(respuesta);
      }
    });
    print(ContextoApp.db.tablaAutenticacion!.entidad.llave);

    // obetenr  token por  post
    ContextoApp.db.tablaAutenticacion!.configuracion!.llaveApi = "";

    // ContextoApp.db.tablaAutenticacion!.configuracion!.llaveApi =
    //     "794B0B5A-6BE3-4523-B16C-FC24E884AACE";
    ContextoApp.db.tablaAutenticacion!.entidad.id = 1;
    ContextoApp.db.tablaAutenticacion!.entidad.cuenta = 'giorgio';
    ContextoApp.db.tablaAutenticacion!.entidad.clave = '123';
    ContextoApp.db.tablaAutenticacion!.entidad.operacion = 'insertar';
    ContextoApp.db.tablaAutenticacion!.entidad.estacionTrabajo = 'VVVV';

    await ContextoApp.db.tablaAutenticacion!
        .insertar(ContextoApp.db.tablaAutenticacion!.entidad)
        .then((respuesta) {
      if (respuesta != null)
        ContextoApp.db.tablaAutenticacion!.configuracion!.llaveApi =
            respuesta.llave;
      print(respuesta);
    });

    print(ContextoApp.db.tablaAutenticacion!.entidad.llave);

    // tablaCuentaUsuario

    ContextoApp.db.tablaCuentaUsuario!.configuracion!.llaveApi =
        ContextoApp.db.tablaAutenticacion!.entidad.llave!;

    print(ContextoApp.db.tablaCuentaUsuario!.configuracion!.llaveApi);

    await ContextoApp.db.tablaCuentaUsuario!
        .consultarTabla(ContextoApp.db.tablaCuentaUsuario!.entidad)
        .then((respuesta) => {print(respuesta)});

    ContextoApp.db.tablaCuentaUsuario!.entidad =
        ContextoApp.db.tablaCuentaUsuario!.iniciarEntidad();

    ContextoApp.db.tablaCuentaUsuario!.controlEstadoUI =
        ControlEstadoUI();

    ContextoApp.db.tablaCuentaUsuario!.paginador.registrosPorPagina =
        100;
    ContextoApp.db.tablaCuentaUsuario!.paginador.estatus = 1;
    await ContextoApp.db.tablaCuentaUsuario!
        .consultarPaginacionTabla(
            ContextoApp.db.tablaCuentaUsuario!.entidad)
        .then((respuesta) => {print(respuesta)});


*/

    // print(ContextoApp.db.tablaCliente!.lista.length);
    // print(ContextoApp.db.venta!.lista.length);

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
