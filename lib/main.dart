//  librerias internas de flutter
import 'package:flutter/material.dart';

//  librerias importadas flutter

import 'package:provider/provider.dart';

//  librerias  proyecto
import 'inicializacion/inicializacion.dart';
import 'configuracion/configuracion.dart';
import 'administracion/administracion.dart';

import 'nucleo/nucleo.dart';
import 'aplicacion/aplicacion.dart';

// import 'nucleo/ui/comun/Tema.dart';

//  librerias externas  flutter

import '../paquetesExternos/paquetesExternos.dart';

void main() async {
  // esta  linea  es para  asegurar que  se inicialicen las variables  asincronas  como preferences
  WidgetsFlutterBinding.ensureInitialized();

  // iniciar servicios y variables  Sincronos
  InicializacionServicios.inicicializarServiciosSincronos();
  InicializacionVariables.valoresSincronos();
  // iniciar servicios y variables  asincronos
  await InicializacionServicios.inicicializarServiciosAsincronos();
  await InicializacionVariables.valoresAsicronos();

  InicializacionEntidades.iniciar();
  // iniciar app
  runApp(
      // inicia  providers globales
      MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ParametrosSistemaCE()),
      ChangeNotifierProvider(create: (_) => ModeloCE())
    ],
    child: const MyApp(),
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("build app");
    //  esta  linea sirve para refrecscar o repintar los Widgets cuando cambia el tema o idioma
    final provider = Provider.of<ParametrosSistemaCE>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: Provider.of<controladorEstadoParametrosSistema>(context).obtenerTema(),
      theme: Tema.obtener(),
      home: inicio_pagina(),
    );
  }
}
