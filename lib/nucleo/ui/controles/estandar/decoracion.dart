//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../../../nucleo.dart';
// import '../../comun/comun.dart';
// import '../../Iconos/iconos.dart';
// import '../../../../nucleo/negocio/modelo/ModeloBase.dart';

Decoration crearDecoracionContenedor(BuildContext context, Control control) {
  Decoration contenedorDecoracion = BoxDecoration(
      border: Border.all(
    width: 0,
    style: BorderStyle.none,
  ));
  control.colorBorde = ParametrosSistema.colorBorde;
  if (control.borde == null || control.borde == eTipoBorde.ninguno)
    contenedorDecoracion = BoxDecoration(
        border: Border.all(
      width: 0,
      style: BorderStyle.none,
    ));
  else if (control.borde == eTipoBorde.circular)
    contenedorDecoracion = BoxDecoration(
      border: Border.all(
        //color: Theme.of(context).disabledColor,
        color: Colores.obtener(control.colorBorde),
      ),
      borderRadius: BorderRadius.circular(20),
    );
  else if (control.borde == eTipoBorde.rectangular)
    contenedorDecoracion = BoxDecoration(
      border: Border.all(
          //color: Theme.of(context).disabledColor,
          color: Colores.obtener(control.colorBorde)),
    );
  else if (control.borde == eTipoBorde.lineal)
    contenedorDecoracion = BoxDecoration(
        border: Border(
            bottom: BorderSide(
      //color: Theme.of(context).disabledColor,
      color: Colores.obtener(control.colorBorde),
    )));

  return contenedorDecoracion;
}

InputDecoration crearDecoracionInput(Control control) {
  FocusNode focusNode = new FocusNode();
  return InputDecoration(
    contentPadding: EdgeInsets.all(10.0),
    border: control.borde == null || control.borde == eTipoBorde.ninguno
        ? InputBorder.none
        : crearBordeInput(control, ""),
    focusedBorder: control.borde == null || control.borde == eTipoBorde.ninguno
        ? InputBorder.none
        : crearBordeInput(control, "activo"),
    enabledBorder: control.borde == null || control.borde == eTipoBorde.ninguno
        ? InputBorder.none
        : crearBordeInput(control, "inactivo"),
    errorBorder: control.borde == null || control.borde == eTipoBorde.ninguno
        ? InputBorder.none
        : crearBordeInput(control, "error"),
    counter:
        control.textoContador != null ? mostrarContadorLetras(control) : null,
    hintText: control.marcaAguaTexto != null ? control.marcaAguaTexto : null,
    labelText: control.textoEtiqueta != null ? control.textoEtiqueta : null,
    labelStyle: TextStyle(
        color: focusNode.hasFocus
            ? Colores.obtener(ParametrosSistema.colorPrimario)
            : Colores.obtener(ParametrosSistema.colorSecundario)),
    helperText: control.textoAyuda != null ? control.textoAyuda : null,
    suffixIcon: control.iconoInterno != null
        ? Icono.crear(control.iconoInterno!)
        : null,
    icon: control.icono != null ? Icono.crear(control.icono!) : null,
  );
}

InputBorder crearBordeInput(Control control, [String tipo = ""]) {
  // no cambia el  color ,solo aplica el color del tema
  String color = control.colorBorde != null
      ? control.colorBorde
      : ParametrosSistema.colorBorde;
  if (tipo == "activo")
    color = ParametrosSistema.colorPrimario;
  else if (tipo == "inactivo")
    color = ParametrosSistema.colorSecundario;
  else if (tipo == "error") color = ParametrosSistema.colorError;

  InputBorder controlBorde =
      OutlineInputBorder(borderRadius: BorderRadius.circular(20.0));

  if (control.borde == eTipoBorde.circular)
    controlBorde =
        OutlineInputBorder(borderRadius: BorderRadius.circular(20.0));
  else if (control.borde == eTipoBorde.rectangular)
    controlBorde = OutlineInputBorder();
  else if (control.borde == eTipoBorde.lineal)
    controlBorde = UnderlineInputBorder(
        borderSide: BorderSide(
            color: Colores.obtener(color), style: BorderStyle.solid));
  return controlBorde;
}

Widget mostrarContadorLetras(Control control) {
  return contadorLetrasTexto(control);
}

Widget contadorLetrasTexto(Control control) {
  dynamic valor = control.valor;
  Widget? texto;
  print(control.valor.runtimeType.toString());
  if ((control.tipo == eTipoControl.cajaTexto ||
          control.tipo == eTipoControl.cajaTextoForma) &&
      control.textoContador != null) {
    if (control.activo == 1 &&
        control.valor.runtimeType.toString() == "String") {
      if (control.textoContador!.length == 1)
        texto = Text(' ${valor.length} ');
      else if (control.textoContador!.length > 1)
        texto = Text(control.textoContador! + ' ${valor.length} ');
    } else
      texto = Container();
  } else
    texto = Container();

  return texto!;
}
