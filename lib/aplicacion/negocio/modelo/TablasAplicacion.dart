//  librerias internas de flutter

//  librerias importadas flutter

//  librerias  proyecto

import '../../../nucleo/baseDatos/baseDatos.dart';

import 'ModeloAplicacion.dart';

// definicion de tabla base con acceso  metodos de base de datos
class TablaBase<T extends EntidadBase> extends AccesoTabla<T> {}

//  definir  tablas  de la aplicacion

class TablaAutenticacion extends TablaBase<Autenticacion> {}

class TablaServicioAplicacion extends TablaBase<ServicioAplicacion> {}

class TablaCuentaUsuario extends TablaBase<CuentaUsuario> {}

class TablaCliente extends TablaBase<Cliente> {}

class TablaProducto extends TablaBase<Producto> {}

class TablaVenta extends TablaBase<Venta> {}

class TablaVentaProducto extends TablaBase<VentaProducto> {}
