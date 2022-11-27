//  librerias internas de flutter

import 'package:flutter/material.dart';

//  librerias importadas flutter

//  librerias  proyecto

//import 'package:aplicacion_demo/src/nucleo/modelo/CuentaUsuario.dart';

class VistaCuadricula extends StatefulWidget {
  VistaCuadricula({this.titulo, this.datos}) : super();

  String? titulo = "Consulta ";
  DataTable? datos;

  @override
  _VistaCuadricula_State createState() => _VistaCuadricula_State();
}

class _VistaCuadricula_State extends State<VistaCuadricula> {
  @override
  void initState() {
    super.initState();
    if (widget.titulo == null) widget.titulo = "Consulta ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo!),
      ),
      body: SafeArea(
        child: Container(
          child: mostrarConsulta(widget.datos!),
        ),
      ),
    );
  }

  Widget mostrarConsulta(DataTable datos) {
    if (datos == null)
      return Center(child: CircularProgressIndicator());
    else if (datos.rows == 0)
      return Center(child: Text("No  hay  información"));
    else {
      return FuenteDatos.mostrar(datos);
    }
  }
}

class FuenteDatos {
  static DataTable construir(
      List<dynamic> lista,
      var campos,
      int indiceColumnaOrden,
      bool ordenar,
      dynamic elementoSelecccionado,
      Function accionSeleccionarColumna,
      Function accionOrdenar,
      Function accionSeleccionarRegistro) {
    DataTable? datos;
    DataColumn columna;
    List<DataColumn> columnas = [];
    List<DataRow> registros = [];
    if (lista != null) {
      if (campos != null) {
        campos.forEach((campo) {
          if (campo == "id")
            columna =
                FuenteDatos.crearColumna(columnas, campo, campo, accionOrdenar);
          else
            columna =
                FuenteDatos.crearColumna(columnas, campo, campo, accionOrdenar);
        });
      }
      List<DataCell> listaCeldas = [];
      lista.forEach((entidad) {
        DataCell celda;
        listaCeldas = [];
        Map<String, dynamic> entidadMap = entidad.toMap();
        dynamic valor;
        campos.forEach((campo) {
          if (campo == "id") {
            valor = entidadMap[campo].toString();
            celda = DataCell(Text(valor), onTap: () {
              accionSeleccionarColumna(campos.indexOf(campo), entidadMap);
            });
          } else {
            valor = entidadMap[campo];
            celda = DataCell(Text(valor));
          }
          listaCeldas.add(celda);
        });
        if (elementoSelecccionado == null)
          registros.add(DataRow(cells: listaCeldas));
        else
          registros.add(DataRow(
              selected: elementoSelecccionado.contains(entidad),
              cells: listaCeldas,
              onSelectChanged: (i) {
                accionSeleccionarRegistro(i, entidad);
                print("Onselect");
              }));
      });

      datos = FuenteDatos.crearTabla(
          columnas, registros, indiceColumnaOrden, ordenar);
    }
    return datos!;
  }

  static DataTable crearTabla(List<DataColumn> columnas,
      List<DataRow> registros, int indiceColumnaOrden, bool ordenar) {
    return DataTable(
      sortAscending: ordenar,
      sortColumnIndex: indiceColumnaOrden,
      columns: columnas,
      rows: registros,
    );
  }

  static DataColumn crearColumna(List<DataColumn> columnas, String titulo,
      String ayuda, Function accionOrdenar) {
    DataColumn columna = DataColumn(
        label: Text(titulo),
        numeric: false,
        tooltip: ayuda,
        onSort: (columnIndex, ascending) {
          //setState(() {
          //  ordenar = !ordenar;
          //});
          accionOrdenar(columnIndex, ascending);
        });
    columnas.add(columna);
    return columna;
  }

  static List<DataColumn> agregarColumna(
      List<DataColumn> columnas, DataColumn columna) {
    columnas.add(columna);
    return columnas;
  }

  static SingleChildScrollView mostrar(DataTable datos,
      [Function? accionOrdenar, Function? accionEliminar]) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: datos,
    );
  }
}
