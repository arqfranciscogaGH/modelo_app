//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

import '../../../../nucleo/nucleo.dart';

//  librerias  proyecto

class Autocompletar extends StatefulWidget {
  Autocompletar({
    Key? key,
    this.opciones,
    this.control,
    this.metodo,
  }) : super(key: key);

  List<ElementoLista>? opciones;
  Control? control;
  Function? metodo;

  @override
  _Autocompletar_state createState() => _Autocompletar_state();
}

class _Autocompletar_state extends State<Autocompletar> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<ElementoLista>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<ElementoLista>.empty();
        }
        return widget.opciones!.where((ElementoLista option) {
          return option.titulo!.contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: (ElementoLista opcion) => opcion.titulo!,
      onSelected: (ElementoLista selection) {
        widget.control!.controlEdicion!.text = selection.titulo!;
        debugPrint('You just selected $selection.titulo!');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback metodo) {
        return TextField(
          controller: fieldTextEditingController,
          focusNode: fieldFocusNode,
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
    );
  }
}
