//  tipos de botones

enum eBotonTipo {
  Plano,
  Rectagulo,
  RectaguloBordes,
  RectaguloRedondeado,
  RectaguloOvalo,
  Pentagono,
  Linea,
  Circulo,
}
// tipos de bordes

enum eTipoBorde {
  ninguno,
  circular,
  rectangular,
  lineal,
}

//   tipos  de controles

enum eTipoControl {
  etiqueta,
  cajaTexto,
  cajaTextoForma,
  fechaSelector,
  horaSelector,
  fechaSelectorCupertino,
  horaSelectorCupertino,
  calendario,
  listaDespegable,
  listaDespegableFija,
  apagador,

  radioVertical,
  radioHorizontal,
  verificadorVertical,
  verificadorHorizontal,
  selectorDeslizante,
  foto,
  videoSimple,
  videoMejorado,
  autoCompletarLista,
  autoCompletarTabla,
}

//  control de estado

//  procesosde  entidades

enum eProceso {
  ninguno,
  iniciar,
  terminar,
  insertar,
  modificar,
  eliminar,
  consultar,
  obtener,
  filtrar,
}
// estados de  entidades

enum eEstatus {
  ninguno,
  iniciado,
  enProceso,
  terminado,
  insertado,
  modificado,
  eliminado,
  consultado,
  obtenido,
  filtrado,
}
