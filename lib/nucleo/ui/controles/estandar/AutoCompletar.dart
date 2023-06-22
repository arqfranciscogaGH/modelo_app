//  librerias internas de flutter

import 'package:flutter/material.dart';
import 'package:modelo_app/aplicacion/contexto/contexto.dart';

//  librerias importadas flutter

import '../../../nucleo.dart';

//  librerias  proyecto

class AutoCompletarTabla/*<T extends Object>*/ extends StatefulWidget {
  AutoCompletarTabla({
    Key? key,
    required this.tabla,
    this.control,
    this.metodo,
  }) : super(key: key);
  dynamic tabla;
  Control? control;
  Function? metodo;

  @override
  _AutoCompletarTabla_state createState() => _AutoCompletarTabla_state();
}

class _AutoCompletarTabla_state extends State<AutoCompletarTabla> {
  @override
  Widget build(BuildContext context) {
    if (widget.tabla == null && widget.control!.tabla != null)
      widget.tabla = widget.control!.tabla!;
    return Autocomplete<EntidadBase>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // if (textEditingValue.text == '') {
        //   return const Iterable<Map<String, dynamic>>.empty();
        // }
        // print(widget.tabla!.resultado.datos);
        // return widget.tabla!.resultado.datos
        //     .where((Map<String, dynamic> elemento) {
        //   // print(elemento["nombre"]);

        //   // return elemento.nombre!
        //   return elemento["nombre"]
        //       .toLowerCase()
        //       .contains(textEditingValue.text.toLowerCase());
        print(textEditingValue.text.toLowerCase());
        if (textEditingValue.text == '') {
          return const Iterable<EntidadBase>.empty();
        }
        print('lista');
        print(widget.tabla!.lista.length);
        print(widget.tabla!.lista);
        return widget.tabla!.lista.where((EntidadBase elemento) {
          print("nombre:  $elemento.nombre");
          print(elemento.nombre);
          return elemento.nombre!
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      //displayStringForOption: (EntidadBase opcion) => opcion['nombre'],
      displayStringForOption: (EntidadBase opcion) => opcion.nombre!,
      onSelected: (EntidadBase elemento) {
        // widget.control!.id = elemento['id'];
        // widget.control!.valor = elemento['nombre'];
        widget.control!.id = elemento.id;
        widget.control!.valor = elemento.nombre!;
        widget.control!.controlEdicion!.text = widget.control!.valor;
        // elemento.accion = widget.metodo!;
        print(widget.control!.id);
        print(widget.control!.valor);
        widget.control!.accion!(widget.control, widget.control!.valor);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback metodo) {
        if (fieldTextEditingController.text == "")
          fieldTextEditingController.text = widget.control!.valor;
        widget.control!.controlEdicion = fieldTextEditingController;
        //  se debe  asignar  para que  se muestre  la lista  de elementos  abajo
        widget.control!.focusNode = fieldFocusNode;
        widget.control!.valor = fieldTextEditingController.text;

        TextField capturaTexto =
            crearCajaTexto(context, widget.control!) as TextField;
        return capturaTexto;
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<EntidadBase> onSelected,
          Iterable<EntidadBase> elementos) {
        int maxItems = 5;
        Responsivo.identifciarDispositivo(context);
        double width = Responsivo.width / 2;
        double height = Responsivo.height / 3;
        // print(Responsivo.orientation);
        // double width = 300.0;
        // double height = 300.0;
        print('Elemtos');
        print(elementos.length);
        return /* Align(
          alignment: Alignment.topLeft, */
            // es necesrio  el widget Material  , sino  genera  error

            Material(
          child: Container(
              //color: Theme.of(context).primaryColor.withOpacity(0.2),
              width: width,
              height: height,
              padding: EdgeInsets.only(top: .0),
              color: Colores.obtener(ParametrosSistema.colorPrimario)
                  .withOpacity(0.1),
              child: ListView.separated(
                padding: EdgeInsets.all(1.0),
                // itemCount: elementos.length,
                itemCount:
                    elementos.length > maxItems ? maxItems : elementos.length,
                itemBuilder: (context, index) {
                  final dynamic elemento = elementos.elementAt(index);
                  print(elemento.id!);
                  print(elemento.nombre!);
                  ElementoLista el =
                      ElementoLista(id: elemento.id, titulo: elemento.nombre);
                  return GestureDetector(
                    onTap: () {
                      onSelected(elemento);
                    },
                    child: Listas.crearTituloElemento(context, el),
                    // child: ListTile(
                    //   title: Text(elemento.nombre,
                    //       // title: Text(elemento['nombre'],
                    //       style: const TextStyle(color: Colors.black)),
                    // ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colores.obtener(ParametrosSistema.colorPrimario)
                        .withOpacity(0.2),
                    height: 1.0,
                  );
                },
              )),
        );
      },
    );
  }
}

class AutoCompletarLista extends StatefulWidget {
  AutoCompletarLista({
    Key? key,
    this.control,
    this.lista,
    this.metodo,
  }) : super(key: key);

  Control? control;
  List<ElementoLista>? lista;
  Function? metodo;

  @override
  _Autocompletar_state createState() => _Autocompletar_state();
}

class _Autocompletar_state extends State<AutoCompletarLista> {
  @override
  Widget build(BuildContext context) {
    if (widget.lista == null && widget.control!.lista != null)
      widget.lista = widget.control!.lista!;
    return Autocomplete<ElementoLista>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<ElementoLista>.empty();
        }
        return widget.lista!.where((ElementoLista opcion) {
          return opcion.titulo!
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: (ElementoLista opcion) => opcion.titulo!,
      onSelected: (ElementoLista elemento) {
        widget.control!.id = elemento.id;
        widget.control!.valor = elemento.titulo;
        widget.control!.controlEdicion!.text = widget.control!.valor;
        elemento.accion = widget.metodo!;
        print(widget.control!.id);
        print(widget.control!.valor);
        //Accion.hacer(context, elemento);
        //  widget.control.accion!(control, valor);
        // widget.metodo!(control, valor);
        widget.control!.accion!(widget.control, widget.control!.valor);
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback metodo) {
        if (fieldTextEditingController.text == "")
          fieldTextEditingController.text = widget.control!.valor;
        widget.control!.controlEdicion = fieldTextEditingController;
        //  se debe  asignar  para que  se muestre  la lista  de elementos  abajo
        widget.control!.focusNode = fieldFocusNode;
        widget.control!.valor = fieldTextEditingController.text;

        TextField capturaTexto =
            crearCajaTexto(context, widget.control!) as TextField;
        return capturaTexto;

        // return TextField(
        //   controller: fieldTextEditingController,
        //   focusNode: fieldFocusNode,
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ElementoLista> onSelected,
          Iterable<ElementoLista> elementos) {
        int maxItems = 5;
        Responsivo.identifciarDispositivo(context);
        double width = Responsivo.width / 2;
        double height = Responsivo.height / 3;
        // print(Responsivo.orientation);
        // double width = 300.0;
        // double height = 300.0;
        print(elementos.length);
        return /* Align(
          alignment: Alignment.topLeft, */
            // es necesrio  el widget Material  , sino  genera  error

            Material(
          child: Container(
              //color: Theme.of(context).primaryColor.withOpacity(0.2),
              width: width,
              height: height,
              padding: EdgeInsets.only(top: .0),
              color: Colores.obtener(ParametrosSistema.colorPrimario)
                  .withOpacity(0.1),
              child: ListView.separated(
                padding: EdgeInsets.all(1.0),
                // itemCount: elementos.length,
                itemCount:
                    elementos.length > maxItems ? maxItems : elementos.length,
                itemBuilder: (context, index) {
                  final ElementoLista elemento = elementos.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(elemento);
                    },
                    child: Listas.crearTituloElemento(context, elemento),
                    // child: ListTile(
                    //   title: Text(elemento.titulo!,
                    //       style: const TextStyle(color: Colors.white)),
                    // ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    color: Colores.obtener(ParametrosSistema.colorPrimario)
                        .withOpacity(0.2),
                    height: 1.0,
                  );
                },
              )

              //   child: ListView.builder(
              //     padding: EdgeInsets.all(1.0),
              //     itemCount: 5 /* elementos.length*/,
              //     itemBuilder: (BuildContext context, int index) {
              //       final ElementoLista elemento = elementos.elementAt(index);
              //     },

              //     // return Listas.crearElementoLista(context, elemento);
              //     return GestureDetector(
              //       onTap: () {
              //         onSelected(elemento);
              //       },
              //       child: Listas.crearTituloElemento(context, elemento),
              //       // child: ListTile(
              //       //   title: Text(elemento.titulo!,
              //       //       style: const TextStyle(color: Colors.white)),
              //       // ),
              //     );
              //   },
              // ),

              ),
        );
      },
    );
  }
}


// static Widget mostrarElementos(List<dynamic> lista, BuildContext context,
//       ElementoLista acciones, Function metodoCrearElemento) {
//     // if (lista != null) {
//     return ListView.separated(
//       itemCount: lista.length,
//       itemBuilder: (context, position) {
//         dynamic entidad = lista[position];
//         return metodoCrearElemento(context, entidad, acciones);
//       },
//       separatorBuilder: (context, position) {
//         return Container(
//           color: Theme.of(context).primaryColor.withOpacity(0.2),
//           height: 2.0,
//         );
//       },
//     );
//     // }
//   }
