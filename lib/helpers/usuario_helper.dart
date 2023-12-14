import 'package:segunda_prova/domain/Usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UsuarioHelper {
  // Singleton
  static final UsuarioHelper _instance = UsuarioHelper.internal();

  factory UsuarioHelper() => _instance;

  UsuarioHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    if (databasesPath == null) databasesPath = "";
    String path = join(databasesPath, "usuarios.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE ${Usuario.usuarioTable}("
          "${Usuario.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
          "${Usuario.nomeColumn} TEXT, "
          "${Usuario.nacionalidadeColumn} TEXT, "
          "${Usuario.sexoColumn} TEXT, "
          "${Usuario.idadeColumn} INTEGER, "
          "${Usuario.racaColumn} TEXT, "
          "${Usuario.pesoColumn} INTEGER)");
    });
  }

  Future<Usuario> saveUsuario(Usuario u) async {
    Database? dbUsuario = await db;
    if (dbUsuario != null) {
      u.id = await dbUsuario.insert(Usuario.usuarioTable, u.toMap());
    }
    return u;
  }

  Future<Usuario?> getUsuario(int id) async {
    Database? dbUsuario = await db;
    if (dbUsuario != null) {
      List<Map> maps = await dbUsuario.query(Usuario.usuarioTable,
          columns: [
            Usuario.idColumn,
            Usuario.nomeColumn,
            Usuario.nacionalidadeColumn,
            Usuario.sexoColumn,
            Usuario.idadeColumn,
            Usuario.racaColumn,
            Usuario.pesoColumn,
          ],
          where: "${Usuario.idColumn} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Usuario.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> deleteUsuario(int id) async {
    Database? dbUsuario = await db;
    if (dbUsuario != null) {
      return await dbUsuario.delete(Usuario.usuarioTable,
          where: "${Usuario.idColumn} = ?", whereArgs: [id]);
    } else
      return 0;
  }

  Future<int> updateUsuario(Usuario u) async {
    Database? dbUsuario = await db;
    if (dbUsuario != null) {
      return await dbUsuario.update(Usuario.usuarioTable, u.toMap(),
          where: "${Usuario.idColumn} = ?", whereArgs: [u.id]);
    } else {
      return 0;
    }
  }

  Future<List<Usuario>> getAllUsuarios() async {
    Database? dbUsuario = await db;
    if (dbUsuario != null) {
      List<Map<String, dynamic>> listMap =
          await dbUsuario.query(Usuario.usuarioTable);
      List<Usuario> listUsuarios = [];

      for (Map<String, dynamic> m in listMap) {
        listUsuarios.add(Usuario.fromMap(m));
      }
      return listUsuarios;
    } else {
      return [];
    }
  }
}
