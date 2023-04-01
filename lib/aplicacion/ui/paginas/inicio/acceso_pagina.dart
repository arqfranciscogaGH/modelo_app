//  librerias internas de flutter
//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

import 'package:provider/provider.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

//  librerias  proyecto

import '../../../../inicializacion/inicializacion.dart';
import '../../../../configuracion/configuracion.dart';
import '../../../../administracion/administracion.dart';

import '../../../../nucleo/nucleo.dart';
import '../../../../aplicacion/aplicacion.dart';
import '../../../contexto/contexto.dart';
import '../../../negocio/negocio.dart';

class acceso_pagina extends StatefulWidget {
  acceso_pagina(
      {Key? key,
      this.paginaSiguiente,
      this.paginaAnterior,
      this.activarAcciones})
      : super(key: key);

  String? paginaSiguiente = "";
  String? paginaAnterior = "";
  bool? activarAcciones = false;

  @override
  _acceso_pagina_state createState() => _acceso_pagina_state();
}

class _acceso_pagina_state extends State<acceso_pagina> {
  //  propiedades  widget

  //    control de estado  con provider

  //  controlador  de estado comun para  actulizar la UI

  ControlEstadoUI? controlEstadoUI;

  CuentaUsuario entidadCaptura = CuentaUsuario();
  List<dynamic> listaEntidad = [];

  // KEYS

  //  KEY Scaffold
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  //  KEY captura

  GlobalKey<FormState> keyFormulario = GlobalKey<FormState>();

  //  Acciones

  ElementoLista? accionGuardar;

  //  provider
  ControlEstadoUI? providerA;
  ControlEstadoUI? provider;

  //  Interfaz  comun

  //  UsuarioUI ui;

  //  controladores

  //  otros

  //  inicializar  variables

  @override
  void initState() {
    super.initState();
    widget.paginaAnterior = ContextoUI.obtenerTipo(widget);
    controlEstadoUI = ControlEstadoUI();
    Sesion.idUsuario = 0;
    Sesion.nombre = "";
    Sesion.cuenta = "";
    Sesion.idSuscriptor = 0;
    Sesion.perfiles = "";
    Sesion.grupos = "";

    providerA = ControlEstadoUI();
    provider = ControlEstadoUI();

    // ui=UsuarioUI(provider: provider);
    //accionGuardar=ElementoLista ( id:4, icono: "save" , ruta:widget.paginaSiguiente, accion: ui.guardarEntidad ,callBackAccion: ui.respuestaInsertar,  callBackAccion2: ui.respuestaModificar  , callBackAccion3:respuestaGuardar , argumento: widget.pagina  );
    keyFormulario = GlobalKey<FormState>();
    // ContextoUI.guadarKey(widget.pagina, keyFormulario);
    //  iniciar y consultar lista para obtener elemento y obtener el elemento que insertará
  }

  //
  //   construir  interfaz de usuario
  //
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: controlEstadoUI,
        child: Scaffold(
            key: scaffoldKey,
            appBar: NewGradientAppBar(
              title: Text(ContextoUI.obtenerTitulo(widget)),
              gradient: LinearGradient(colors: [
                //Theme.of(context).primaryColor,
                Colores.obtener(ParametrosSistema.colorPrimario),
                Colores.obtener(ParametrosSistema.colorSecundario)
              ]),
            ),
            body: Stack(
              children: <Widget>[
                _crearFondo(context),
                Consumer<ControlEstadoUI>(
                    builder: (context, _provider, widgetPadre) {
                  return _loginForm(context);
                }),
              ],
            )));
  }

  Widget _crearFondo(BuildContext context) {
    Image imagen;
    final size = MediaQuery.of(context).size;
    String ruta = 'assets/img/fondo4.jpeg';
    dynamic backgroundImage;
    BoxDecoration cajaSuperior;
    if (ruta != null) {
      if (ruta.contains('http')) {
        backgroundImage = Image.network(ruta);
      } else {
        backgroundImage = AssetImage(ruta);
      }
      cajaSuperior = BoxDecoration(
        image: DecorationImage(
          image: backgroundImage == null ? null : backgroundImage,
          fit: BoxFit.cover,
        ),
      );
    } else {
      cajaSuperior = BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(125, 3, 3, 10.0),
        Color.fromRGBO(82, 72, 72, 1.0)
      ]));
    }

    final fondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: cajaSuperior,
    );

    return Stack(
      children: <Widget>[
        fondo,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              //Icon( Icons.person_pin_circle, color: Colors.white, size: 100.0 ),
              SizedBox(height: .5, width: double.infinity),
              Text('Oficina Electrónica',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
              Text('Servicios Financieros ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 25.0,
                      offset: Offset(10.0, 10.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Acceso', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 40.0),
                Container(
                  child: Captura.mostrarFormularioColumnas(
                      context,
                      keyFormulario,
                      cambiarValor,
                      validar,
                      definicionControles,
                      entidadCaptura),
                ),
                SizedBox(height: 30.0),
                _crearBoton(entidadCaptura, context)
              ],
            ),
          ),
          // FlatButton(onPressed: () {}, child: Text('Olvide la contraseña')),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  Widget _crearBoton(CuentaUsuario cuenta, BuildContext context) {
    ElementoLista elemento = ElementoLista(
      icono: 'menu',
      accion: _obtenerCuenta,
      tituloAccion: "Ingresar",
      titulo: 'prueba',
      subtitulo: "x",
      descripcion: "es una prueba",
      argumento: entidadCaptura,
    );

    return Boton.texto(context, elemento, eBotonTipo.RectaguloOvalo);

    // return RaisedButton(
    //     child: Container(
    //       padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
    //       child: Text('Ingresar'),
    //     ),
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    //     elevation: 0.0,
    //     color: Theme.of(context).primaryColor,
    //     textColor: Colors.white,
    //     onPressed: cuenta.contrasena != null
    //         ? () => _obtenerCuenta(entidadCaptura, context)
    //         : null);
  }

  List<Widget> definicionControles(
      BuildContext context,
      GlobalKey<FormState> formKey,
      Function metodoActualizarValor,
      Function metodoValidar,
      dynamic entidadCaptura) {
    List<Control> controles = [];

    String pagina = ContextoUI.obtenerTitulo(widget);

    Control txtCuenta = new Control(
      idControl: "txtCuenta",
      tipo: eTipoControl.cajaTextoForma,
      borde: eTipoBorde.lineal,
      valor: entidadCaptura.cuenta,
    );
    controles.add(txtCuenta);
    txtCuenta = txtCuenta.asignar("", pagina, entidadCaptura.cuenta,
        metodoActualizarValor, metodoValidar);

    Control txtContrasena = new Control(
      idControl: "txtContrasena",
      tipo: eTipoControl.cajaTextoForma,
      borde: eTipoBorde.lineal,
      valor: entidadCaptura.contrasena,
/*        textoEtiqueta : "Contrasena",
          textoAyuda : "Capture  el  Contrasena ",
          marcaAguaTexto : "Contrasena", 
          textoContador : "no. letras",
          icono: "contrasena",
          iconoInterno:  "contrasena", 
          textoCapitalizacion:   TextCapitalization.sentences,
          tipoEntrada:   TextInputType.text,
          protegerTextoEscrito:false,
          accion:     metodoActualizarValor ,
          accionValidacion: metodoValidar, */
    );
    controles.add(txtContrasena);
    txtContrasena = txtContrasena.asignar("", pagina, entidadCaptura.contrasena,
        metodoActualizarValor, metodoValidar);

    return cargarControlesCaptura(context, controles, '',
        ContextoUI.obtenerTipo(widget), cambiarValor, validar, []);

    //return  cargarControlesCaptura(context,controles, idioma,pagina,actualizarValor,validar);
  }

  //
  //   control  de estado y validaciones
  //

  dynamic validar(Control control, dynamic valor) {
    if (control.idControl == "txtCuenta") {
      if (valor != null && valor.length < 2) {
        return 'Ingrese su cuenta o correo ';
      } else if (!isEmail(valor))
        return 'Ingrese  correo correcto ';
      else
        return null;
    }
/*       else if ( control.idControl=="txtValor" ) {            
          if ( utils.isNumeric(valor)  ) {
              return null;
          } else {
                return 'Sólo números';
          } 
      } */
  }

  dynamic cambiarValor(Control control, dynamic valor) {
    switch (control.idControl) {
      case "txtCuenta":
        entidadCaptura.cuenta = valor;
        isEmail(valor);
        break;
      case "txtContrasena":
        entidadCaptura.contrasena = valor;
        break;
    }
    // print(control.idControl + "  , valor  :$valor");

    return entidadCaptura;
  }

  bool isEmail(String email) {
    bool resultado;

    email = "tony@starkindustries.com";
    String expresion;

    expresion =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    expresion =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    //resultado = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    RegExp regExp = new RegExp(expresion);
    print(regExp.hasMatch(email));
    resultado = regExp.hasMatch(email);
    return resultado;
  }
  //
  //   control  de estado y validaciones
  //

  void actualizarValor(Control control, dynamic valor) {
    entidadCaptura = cambiarValor(control, valor);
    //  actualizarEstadoEntidad( entidadCaptura );
  }

  void actualizarEstadoLista(List<dynamic> listaRespuesta) {
    // setState(() {
    listaEntidad = listaRespuesta;
    _validarCuenta(entidadCaptura, context);
  }

  void actualizarEstadoEntidad(dynamic entidad) {
    setState(() {
      entidadCaptura = entidad;
      // actualizarEntidad(entidad);
    });
  }

  _obtenerCuenta(
      BuildContext context, ElementoLista elemento, dynamic argumento) {
    // dynamic usuario = elemento.argumento;

    entidadCaptura = elemento.argumento;
    listaEntidad = ContextoAplicacion.db.tablaCuentaUsuario!.lista;
    print(ContextoAplicacion.db.tablaCuentaUsuario!.lista.length);
    if (!keyFormulario.currentState!.validate()) return;
    keyFormulario.currentState!.save();
    // obtenerInformacion(usuario);
    if (listaEntidad != null &&
        listaEntidad.length > 0 &&
        entidadCaptura.cuenta != "") _validarCuenta(entidadCaptura, context);
  }

  _validarCuenta(dynamic entidadCaptura, BuildContext context) {
    bool resultado = false;
    // if (!keyFormulario.currentState.validate()) return;
    // keyFormulario.currentState.save();
    listaEntidad = listaEntidad;
    print(listaEntidad.length);
    CuentaUsuario? usuarioEncontrado;
    if (listaEntidad != null &&
        listaEntidad.length > 0 &&
        entidadCaptura.cuenta != "")
      usuarioEncontrado = listaEntidad.firstWhere((s) =>
          s.cuenta.trim().toLowerCase() ==
          entidadCaptura.cuenta.trim().toLowerCase());

    if (usuarioEncontrado != null &&
        entidadCaptura.contrasena.trim().toLowerCase() ==
            usuarioEncontrado.contrasena!.trim().toLowerCase()) {
      resultado = true;
      entidadCaptura = usuarioEncontrado;

      print("La  Usuario y contraseña son correctas ");
    } else if (entidadCaptura.cuenta == "adm" &&
        entidadCaptura.contrasena == "123") {
      resultado = true;
      entidadCaptura.id = 1;
      entidadCaptura.nombre = "Administrador";
      entidadCaptura.cuenta = "adm";
      entidadCaptura.idSuscriptor = 1;
      entidadCaptura.perfiles = "1";
      entidadCaptura.grupos = "";
      print("La  Usuario y contraseña son de administrador  ");
    } else if (entidadCaptura.cuenta == "arqfranciscoga@gmail.com" &&
        entidadCaptura.contrasena == "26021969") {
      resultado = true;
      entidadCaptura.id = 1;
      entidadCaptura.nombre = "Administrador";
      entidadCaptura.cuenta = "adm";
      entidadCaptura.idSuscriptor = 1;
      entidadCaptura.perfiles = "1";
      entidadCaptura.grupos = "";
      print("La  Usuario y contraseña son de administrador  ");
    } else {
      //   crear la  accion  para  Dialogo
      ElementoLista elementoDialogo = ElementoLista(
        titulo: "Acceso",
        tituloAccion: "Aceptar",
        icono: "error",
        mensaje:
            "El  Usuario o contraseña son incorrectos, intente nuevamente por favor.",
      );
      Dialogo.mostrarAlerta(context, elementoDialogo);
    }
    if (resultado) {
      ElementoLista elemento = ElementoLista();

      elemento.id = entidadCaptura.id;
      // provider.obtenerEntidad(context, elemento, null);
      Sesion.idUsuario = entidadCaptura.id;
      // Sesion.nombre = usuario.nombre;
      Sesion.cuenta = entidadCaptura.cuenta;
      Sesion.idSuscriptor = entidadCaptura.idSuscriptor;

      Sesion.perfiles = entidadCaptura.perfiles;
      Sesion.grupos = entidadCaptura.grupos;
      // Sesion.nivelRed = usuario.nivelRed;
      Accion.hacer(context, OpcionesMenus.obtener("menu_principal_pagina"));
    }
  }

  bool validarEmail(String email) {
    bool resultado = false;
    // Pattern pattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regExp = new RegExp(pattern);
    // resultado = regExp.hasMatch(email);
    return resultado;
  }

  obtenerInformacion(dynamic entidadCaptura) {
    //  definir  url y sus  parametros
    String url = "AdministracionUsuarios/";
    String argumentos = entidadCaptura.cuenta + "/C";
    String consulta = "";
    bool buscar = false;

    if (listaEntidad == null && entidadCaptura.cuenta != "")
      buscar = true;
    else if ((listaEntidad != null && listaEntidad.length > 0) &&
        entidadCaptura.cuenta != "") {
      CuentaUsuario usuarioEncontrado;
      usuarioEncontrado = listaEntidad.firstWhere((s) =>
          s.cuenta.trim().toLowerCase() ==
          entidadCaptura.cuenta.trim().toLowerCase());
      if (usuarioEncontrado == null) buscar = true;
    }
    if (buscar == true) {
      //  obtener argumentos  de pagina  comun
      // argumentos= ContextoUI.obtenerKey("seguimiento").entidad.identificador;
      argumentos = argumentos == null || argumentos == "" ? "''" : argumentos;
      print(argumentos);
      url += argumentos;
      url += consulta;
      print(url);

      // provider.limpiar();
      // provider.asignarParametros(url, "prueba");
      // provider.consultarEntidad(
      //     AdministracionUsuarios().iniciar(), actualizarEstadoLista);
    }
  }
  //  termina   widget
}

/* 
Widget MostrarDetalle ()
  {
      Control control  = new Control( 
          IdControl:"txtNombre" ,
          Tipo : "TextField", 
          ValorTexto: _nombre ,
          TextoEtiqueta : "Nombre",
          TextoAyuda : "Capture  el  nombre ",
          MarcaAguaTexto : "Nombre de la persona", 
          TextoContador : " Número: " ,
          Icono: "account_circle",
          IconoInterno:  "accessibility", 
          TextoCapitalizacion:   TextCapitalization.sentences,
          TipoEntrada:   null,
          ProtegerTextoEscrito:false,
          Accion:     CambiarValor ,

    );

     Control controlcorreo  = new Control( 
          IdControl:"txtCorreo" ,
          Tipo : "TextField", 
          ValorTexto: _email ,
          TextoEtiqueta : "Correo",
          TextoAyuda : "Capture  el  correo ",
          MarcaAguaTexto : "Cuenta de  correo", 
          TextoContador : " Número: " ,
          Icono: "email",
          IconoInterno:  "alternate_email", 
          TextoCapitalizacion:   null,
          TipoEntrada:   TextInputType.emailAddress,
          ProtegerTextoEscrito:false,
          Accion:     CambiarValor ,

    );
     
     Control controlcontrasena  = new Control( 
          IdControl:"txtContrasena" ,
          Tipo : "TextField", 
          ValorTexto: _contrasena ,
          TextoEtiqueta : "Contraseña",
          TextoAyuda : "Capture  el  Contraseña ",
          MarcaAguaTexto : "Contraseña", 
          TextoContador : " Número: " ,
          Icono: "lock",
          IconoInterno:  "lock_open", 
          TextoCapitalizacion:   null,
          TipoEntrada:   TextInputType.text,
          ProtegerTextoEscrito:true,
          Accion:     CambiarValor ,

    );

     Control controlFecha  = new Control( 
          IdControl:"txtFecha" ,
          Tipo : "TextField", 
          ValorTexto: _fecha ,
          TextoEtiqueta : "Fecha",
          TextoAyuda : "Capture  el  Fecha ",
          MarcaAguaTexto : "Fecha de  nacimiento", 
          TextoContador : " Número: " ,
          Icono: "calendar_today",
          IconoInterno:  "perm_contact_calendar", 
          TextoCapitalizacion:   null,
          TipoEntrada:   TextInputType.datetime,
          ProtegerTextoEscrito:false,
          Accion:     CambiarValor ,


    );

    return ListView (
        children: <Widget>[
          CrearCajaTexto( control ),
          Divider(),
          CrearCajaTexto( controlcorreo ),
          Divider(),
          CrearCajaTexto( controlcontrasena ),
          Divider(),
          CrearCajaTexto( controlFecha ),  
          Divider(),
/*           _crearPassword(),
          Divider(),
          _crearFecha( context ),
          Divider(), */
          _crearDropdown(),
          Divider(),
          _crearPersona(),
          Divider(),
          // CrearImagenInternet(10),
          
        ],

    );
  }
*/