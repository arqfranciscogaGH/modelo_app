//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../nucleo/nucleo.dart';
import '../../../aplicacion.dart';

//  librerias externas  flutter

class tema_pagina extends StatefulWidget {
  tema_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _tema_pagina_state createState() => _tema_pagina_state();
}

class _tema_pagina_state extends State<tema_pagina> {
  //  propiedades  widget

  // entidad

  dynamic entidadCaptura;

  //    control de estado  con provider

  ParametrosSistemaCE? prov;

  // captura
  final formKey = GlobalKey<FormState>();

  //  controladores

  TextEditingController _controllerListaColor = new TextEditingController();
  TextEditingController _controllerColorSecundario = TextEditingController();

  //  otros

  //  inicializar  widget
  @override
  void initState() {
    super.initState();
  }

  //  dispose widget
  @override
  void dispose() {
    super.dispose();
  }

  //  build widget
  @override
  Widget build(BuildContext context) {
    prov = Provider.of<ParametrosSistemaCE>(context, listen: true);
    return Scaffold(
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
          ContextoUI.obtenerTitulo(widget)),
      body: mostrarCaptura(context, formKey, cambiarValor, validar,
          definicionControles, entidadCaptura),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Boton.botonFlotante(
        context,
        ElementoLista(icono: "save", accion: guardar),
      ),
    );
  }

  //    metodos

  Widget mostrarCaptura(
      BuildContext context,
      GlobalKey<FormState> formKey,
      Function cambiarValor,
      Function validar,
      Function metodoDefinicionControles,
      dynamic entidadCaptura) {
    return /* SingleChildScrollView(
                    child:  */
        Container(
      padding: EdgeInsets.all(15.0),
      child: Captura.mostrarFormulario(context, formKey, cambiarValor, validar,
          metodoDefinicionControles, entidadCaptura),
      //)
    );
  }

  List<Widget> definicionControles(
      BuildContext context,
      GlobalKey<FormState> formKey,
      Function cambiarValor,
      Function validar,
      dynamic entidadCaptura) {
    List<Control> controles = [];

    List<ElementoLista> _listaColores = [];
    _listaColores.add(ElementoLista(valor: "azulclaro", titulo: "azul claro"));
    _listaColores.add(ElementoLista(valor: "rojo", titulo: "rojo"));
    _listaColores
        .add(ElementoLista(valor: "rojouFuerte", titulo: "rojou fuerte"));
    _listaColores.add(ElementoLista(valor: "azul", titulo: "azul"));
    _listaColores
        .add(ElementoLista(valor: "azulindigo", titulo: "azul indigo"));
    _listaColores.add(ElementoLista(valor: "verde", titulo: "verde"));
    _listaColores
        .add(ElementoLista(valor: "verdeclaro", titulo: "verde claro"));
    _listaColores.add(ElementoLista(valor: "lima", titulo: "lima"));
    _listaColores.add(ElementoLista(valor: "amarillo", titulo: "amarillo"));
    _listaColores.add(ElementoLista(valor: "naranja", titulo: "naranja"));
    _listaColores.add(ElementoLista(valor: "cafe", titulo: "cafe"));
    _listaColores.add(ElementoLista(valor: "rosa", titulo: "rosa"));
    _listaColores.add(ElementoLista(valor: "negro", titulo: "negro"));
    _listaColores.add(ElementoLista(valor: "gris", titulo: "gris"));

    List<ElementoLista> _listaColoresII = [];
    _listaColores.add(ElementoLista(valor: "azulclaro", titulo: "azul claro"));
    _listaColoresII.add(ElementoLista(valor: "rojo", titulo: "rojo"));
    _listaColoresII
        .add(ElementoLista(valor: "rojouFuerte", titulo: "rojou fuerte"));
    _listaColoresII.add(ElementoLista(valor: "azul", titulo: "azul"));
    _listaColoresII
        .add(ElementoLista(valor: "azulindigo", titulo: "azul indigo"));
    _listaColoresII.add(ElementoLista(valor: "verde", titulo: "verde"));
    _listaColoresII
        .add(ElementoLista(valor: "verdeclaro", titulo: "verde claro"));
    _listaColoresII.add(ElementoLista(valor: "lima", titulo: "lima"));
    _listaColoresII.add(ElementoLista(valor: "amarillo", titulo: "amarillo"));
    _listaColoresII.add(ElementoLista(valor: "naranja", titulo: "naranja"));
    _listaColoresII.add(ElementoLista(valor: "cafe", titulo: "cafe"));
    _listaColoresII.add(ElementoLista(valor: "rosa", titulo: "rosa"));
    _listaColoresII.add(ElementoLista(valor: "negro", titulo: "negro"));
    _listaColoresII.add(ElementoLista(valor: "gris", titulo: "gris"));
/*           _listaColores.add(ElementoLista(valor:"negro" , titulo:"negro" ));  
          _listaColores.add(ElementoLista(valor:"negroclaro" , titulo:"negroclaro" ));  
          _listaColores.add(ElementoLista(valor:"negrofuerte" , titulo:"negrofuerte" )); */

    print(ParametrosSistema.colorPrimario);
    Control lisColoresTema = Control(
      idControl: "colorPrimario",
    );

    lisColoresTema = lisColoresTema.asignar('', ContextoUI.obtenerTipo(widget),
        ParametrosSistema.colorPrimario, 1, cambiarValor, validar);
    lisColoresTema.controlEdicion = _controllerListaColor;
    lisColoresTema.lista = _listaColores;
    controles.add(lisColoresTema);

    Control colorSecundario = Control(idControl: "colorSecundario");
    colorSecundario = colorSecundario.asignar(
        '',
        ContextoUI.obtenerTipo(widget),
        ParametrosSistema.colorSecundario,
        1,
        cambiarValor,
        validar);
    colorSecundario.controlEdicion = _controllerColorSecundario;
    colorSecundario.lista = _listaColoresII;
    controles.add(colorSecundario);

    // controles.add(Control().crear('', widget.pagina!, "apaBrillo",
    //     ParametrosSistema.esModoObscuro == 1 ? true : false, cambiarValor, validar));

    controles.add(Control().crear(
        '',
        ContextoUI.obtenerTipo(widget),
        "apaBrillo",
        ParametrosSistema.esModoObscuro,
        1,
        cambiarValor,
        validar));

/* 

          eTipoBorde borde=eTipoBorde.Lineal;
          print  (borde.index);
          borde=eTipoBorde.values[borde.index];
          print  (borde.index);          
          print  (borde.toString());    

          dynamic datos= idioma.obtenerPagina('pagina_preferencias');
          print (datos);
          print (datos['apaBrillo']);
          dynamic valorControl= idioma.obtenerElemento('pagina_preferencias','apaBrillo'); 
          print (valorControl['textoAyuda']);
          print(idioma.obtenerElemento ('pagina_preferencias','botGuardar'));
          print(idioma.obtenerElemento ('pagina_preferencias','lista'));
          dynamic x= idioma.obtenerElemento ('pagina_preferencias','martin');
          // x.foreach( (e) => print(e) );
          // Dropdown
       List<Map<String,dynamic>> maps=[];
          Control temp= controles.firstWhere((o) => o.idControl=="lisColoresTema");
          temp.textoEtiqueta="Hola cambio";
          Map<String,dynamic> ele=temp.toMap();
          maps.add(ele);

          print (temp);
          print (ele);
          print (maps);
          dynamic zzz=maps.firstWhere((o) => o["idControl"]=="lisColoresTema");
          print (zzz);

          List<Map<String,dynamic>> jjjj=controles.map((c) => c.toMap()).toList();
 */
/*           Control con = Control( idControl: "prueba");
          List<Map<String,dynamic>>  j=con.toMapList(controles); */

/* 
          print (jjjj);
          ele.forEach((k,v) => print('${k}: ${v}')); 

          print  ( controles.firstWhere((o) => o.idControl=="lisColoresTema").textoEtiqueta);

          print (Configuracion.brillo);
          print (Configuracion.brillo==1?true:false);

    */

    return cargarControlesCaptura(context, controles, '',
        ContextoUI.obtenerTipo(widget), cambiarValor, validar, []);
    //return crearControlesCaptura(context,controles).toList();
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {}
  dynamic cambiarValor(Control control, dynamic valor) {
    // setState(() {

    switch (control.idControl) {
      case "colorPrimario":
        print(valor);

        prov!.cambiarColorPrimario(valor);
        print(ParametrosSistema.colorPrimario);
        break;
      case "colorSecundario":
        print(valor);
        prov!.cambiarColorSecundario(valor);
        print(ParametrosSistema.colorSecundario);
        break;
      case "apaBrillo":
        // ParametrosSistema.esModoObscuro = valor ;
        //ParametrosSistema.esModoObscuro = valor == true ? 1 : 0;
        print(valor);
        prov!.cambiarEsModoObscuro(valor);
        print(ParametrosSistema.esModoObscuro);
        break;
    }

    // });

    return entidadCaptura;
  }

  void guardar(BuildContext context, ElementoLista elemento,
      [dynamic argumentos]) {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    prov!.guardarTema();

    // setState(() {

    // });

    // print(Configuracion.tema);

//   lista de variables

    // Variables v = Variables();
    // Variable entiddad = Variable();
    // entiddad.nombre = "rojo";
    // entiddad.tipo = "rojo";
    // v.agregar(entiddad);

    // Variable entiddad2 = Variable();
    // entiddad2.tipo = "azul";
    // entiddad2.nombre = "azul";
    // v.agregar(entiddad2);

    // Variable entiddad3 = v.obtener((c) => c.tipo == "azul");
    // entiddad3.tipo = "verde";
    // v.actualizar((c) => c.tipo == "verde", entiddad3);

    // v.eliminar(entiddad);

    /*    coversiones

          List<Map<String,dynamic>> jjjj=v.obtenerLista().map((c) => c.toMap()).toList();
          List<Map<String,dynamic>> jjjj= v.lisTotMap();
            print (jjjj);
            print (v.lisTotMap());
            String  st=v.toJson();
            print (st);

        print (v.fromMap(v.lisTotMap(),new Variable()));  
        Control con = Control( idControl: "prueba");
        List<Map<String,dynamic>>  j=con.toMapList(controles);

    */
  }
}
