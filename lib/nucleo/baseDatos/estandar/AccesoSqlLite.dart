//  librerias internas de flutter

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

//  librerias importadas flutter

//  librerias  proyecto

import '../admin/IAccesoBD.dart';

class AccesoSqlLite implements IAccesoBD {
  // variables
  Database? _database;

  ConfiguracionAccesoBD? _configuracion;

  //  constructor
  AccesoSqlLite() {
    iniciar();
  }
  // propiedades
  //
  //  obtener configuracion
  @override
  ConfiguracionAccesoBD get configuracion {
    return _configuracion!;
  }

  //  asignar  configuracion
  @override
  set configuracion(ConfiguracionAccesoBD configuracion) {
    _configuracion = configuracion;
  }

  // metodos
  @override
  iniciar() async {}

  @override
  abrir(/* String pnombreDB,List<EntidadBase> ptablas */) async {
    /*     super.nombreDB=pnombreDB;
      super.tablas=ptablas;
      tablas=ptablas;
      nombreDB = nombreDB; */
    // await obtenerDB();

    await database;
  }

  // métodos

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

//   // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //  String path = join(documentsDirectory.path, configuracion.nombreBD!);
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, configuracion.nombreBD! + '.db');
    _database = await openDatabase(path,
        version: configuracion.version, onCreate: _onCreate);
    //  onCreate: (Database db, int version) async {
    //     await db.execute( 'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    //     if (configuracion.tablas != null)
    //     {
    //         configuracion.tablas!.forEach((tabla) {
    //             print(tabla.sqlTabla());
    //             print("____________________________");
    //             db.execute(tabla.sqlTabla());
    //         });
    //      }
    //     // _database=db;
    //     // List<Map> list = await db.rawQuery('SELECT * FROM Test');
    // });
    // List<Map> list = await _database!.rawQuery('SELECT * FROM Test');
    return _database;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');

    if (configuracion.tablas != null) {
      configuracion.tablas!.forEach((tabla) {
        print(tabla.sqlTabla());
        print("____________________________");
        db.execute(tabla.sqlTabla());
      });
    }
    return db;
  }

  // Future<Database> crear() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   final path = join(documentsDirectory.path, configuracion.nombreBD! + '.db');
  //   print("path:  $path");
  //   print(this.configuracion.nombreBD);
  //   print(this.configuracion.tablas!.length);
  //   return await openDatabase(path,
  //       version: configuracion.version,
  //       onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //       if (configuracion.tablas != null) {
  //         configuracion.tablas!.forEach((tabla) {
  //           print(tabla.sqlTabla());
  //           print("____________________________");
  //           db.execute(tabla.sqlTabla());
  //         });
  //       }
  //   });
  // }

  @override
  Future<dynamic> ejecutar(
      String nombreTabla, Map<String, String> parametros) async {
    await _database!.execute("");
  }

  @override
  Future<List<dynamic>> consultarTabla(String nombreTabla) async {
    // await database; // para se instanciar la database
    final respuesta = await _database!.query(nombreTabla);
    print(respuesta);
    return respuesta;
  }

  @override
  Future<List<dynamic>> consultarPaginacionTabla(
      String nombreTabla, Map<String, dynamic> paginacion) async {
    // await database; // para se instanciar la database
    final respuesta = await _database!.query(nombreTabla);
    print(respuesta);
    return respuesta;
  }

  @override
  Future<List<dynamic>> filtrarTabla(String nombreTabla,
      Map<String, dynamic> map, String campo, dynamic valor) async {
    // await database; // para se instanciar la database
    final respuesta = await _database!
        .query(nombreTabla, where: " $campo = ?", whereArgs: [valor]);

    print(respuesta);
    return respuesta;
  }

  @override
  Future<dynamic> obtener(String nombreTabla, Map<String, dynamic> map,
      String campo, dynamic valor) async {
    // await database; // para se instanciar la database
    campo = campo == null ? 'id' : campo;
    final res = await _database!
        .query(nombreTabla, where: " $campo = ?", whereArgs: [valor]);
    return res.isNotEmpty ? res.first : null;
  }

  @override
  Future<dynamic> insertar(String nombreTabla, Map<String, dynamic> map,
      String campo, dynamic valor) async {
    // await database; // para se instanciar la database
    //  int registros=0;
    //  print ( '++  id' );
    //  if (configuracion.contadorRegistros == true) {
    //     registros = tabla.datos == null || tabla.datos.length == 0 ? 0 : tabla.datos.last['id']??0;
    //     registros++;
    //     map['id'] = registros ;

    // print ( registros );
    // print ( tabla.datos.last  );
    // print ( tabla.datos.last['id']   );

    // tabla.datos.insert(registros-1,map);
    // tabla.agregar(map);
    // tabla.eliminar(map);
    // }
    campo = campo == null ? 'id' : campo;
    dynamic res = await _database!.insert(nombreTabla, map);
    if (res != null && res > 0) map[campo] = res;

    return map;
  }

  @override
  Future<dynamic> actualizar(String nombreTabla, Map<String, dynamic> map,
      String campo, dynamic valor) async {
    // await database; // para se instanciar la database
    dynamic respuesta;
    campo = campo == null ? 'id' : campo;
    final res = await _database!
        .update(nombreTabla, map, where: " $campo = ?", whereArgs: [valor]);
    if (res != null && res == 1) respuesta = map;
    return respuesta;
  }

  @override
  Future<Map<String, dynamic>> eliminar(String nombreTabla,
      Map<String, dynamic> map, String campo, dynamic valor) async {
    await database; // para se instanciar la database
    campo = campo == null ? 'id' : campo;
    dynamic respuesta;
    final res = await _database!
        .delete(nombreTabla, where: " $campo = ?", whereArgs: [valor]);
    if (res != null && res == 1) respuesta = map;
    return respuesta;
  }

  @override
  Future<List<dynamic>> sqlConsultar(String sql) async {
    final respuesta = await _database!.rawQuery(sql);
    return respuesta;
  }

  @override
  Future<dynamic> sqlInsertar(String sql) async {
    final respuesta = await _database!.rawInsert(sql);
    return respuesta;
  }

  @override
  Future<dynamic> sqlActualizar(String sql) async {
    final respuesta = await _database!.rawUpdate(sql);
    return respuesta;
  }

  @override
  Future<dynamic> sqlEliminar(String sql) async {
    final respuesta = await _database!.rawDelete(sql);
    return respuesta;
  }

  @override
  void cerrar() {
    _database?.close();
  }
}
