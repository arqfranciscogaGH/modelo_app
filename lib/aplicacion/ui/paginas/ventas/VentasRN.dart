import '../../../contexto/contexto.dart';

Venta calcularImportesTotales(Venta entidad) {
  if (entidad.importePagado! > 0) {
    //  calcular  saldo

    entidad.saldo = entidad.importePagado! >= entidad.importeVenta!
        ? 0
        : entidad.importeVenta! - entidad.importePagado!;

    // calcular importe  de cambio

    entidad.importeCambio = entidad.importePagado! >= entidad.importeVenta!
        ? entidad.importePagado! - entidad.importeVenta!
        : 0;
  } else
    entidad.saldo = entidad.importeVenta!;

  return entidad;
}

// actualizar  totales  de venta
void actualizarVenta() async {
  int? totalCantidad = 0;
  double? totalImporte = 0;
  await ContextoApp.db.ventaProducto!
      .filtrarTabla(ContextoApp.db.ventaProducto!.entidad, "idVenta",
          ContextoApp.db.ventaProducto!.entidad.idVenta)
      .then((respuesta) {
    print(respuesta);
  });
  //  suma  cantidad e  importes
  for (VentaProducto p in ContextoApp.db.ventaProducto!.lista) {
    print(p.id!);
    print(p.cantidad!);
    print(p.importe!);
    totalCantidad = totalCantidad! + p.cantidad!;
    totalImporte = totalImporte! + p.importe!;
  }

  Venta entidad = ContextoApp.db.venta!.entidad;
  entidad.cantidadVenta = totalCantidad;
  entidad.importeVenta = totalImporte;
  entidad = calcularImportesTotales(entidad);
  // ContextoApp.db.venta!.entidad = entidad;

  await ContextoApp.db.venta!.modificar(entidad, null).then((respuesta) {
    print("Actulizacion  totales venta");
    print(respuesta);
  });
}
