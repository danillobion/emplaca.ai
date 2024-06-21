import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'storage_service.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initializeDatabase();
    return _database!;
  }


  // Método para inicializar o banco de dados
  Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_database.db');

    if (await databaseExists(path)) {
      await deleteDatabase(path);
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // tbl estampadoras
        await db.execute('''
        CREATE TABLE estampadoras (
          id INTEGER PRIMARY KEY,
          nome TEXT,
          tipo_nome TEXT,
          tipo TEXT,
          latitude REAL,
          longitude REAL,
          raio_detran INTEGER,
          sigla TEXT,
          estado TEXT,
          cnpj_formatado TEXT
        )
      ''');

        // tbl ordem_servicos
        await db.execute('''
        CREATE TABLE ordem_servicos (
          id INTEGER PRIMARY KEY,
          placa TEXT,
          situacao TEXT,
          marca_modelo TEXT,
          estampadora_id INTEGER
        )
      ''');

        // tbl documento_ordem_servicos
      //   await db.execute('''
      //   CREATE TABLE documento_ordem_servicos (
      //     id INTEGER PRIMARY KEY,
      //     ordem_servico_id INT,
      //     arquivo TEXT,
      //     longitude TEXT,
      //     latitude TEXT,
      //     enviado_por TEXT,
      //     created_at TEXT,
      //   )
      // ''');
      },
    );
  }

  // Método para inserir estampadoras em lote
  Future<void> inserirEstampadoraEmLote(List estampadoras) async {
    final db = await database;
    await db.delete('estampadoras'); //apago tudo

    await db.transaction((txn) async {
      for (var estampadora in estampadoras) {
        await txn.insert('estampadoras', estampadora, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  // Método para obter todas as estampadoras
  Future<List<Map<String, dynamic>>> getEstampadoras() async {
    final db = await database;
    var resultado = await db.query('estampadoras');
    return resultado;
  }

  // Método para inserir ordem de serviços em lote
  Future<void> inserirOrdemServicosEmLote(List ordem_servicos) async {
    final db = await database;
    await db.transaction((txn) async {
      for (var ordem_servico in ordem_servicos) {
        var body_ordem_servico = {
          'id': ordem_servico['id'],
          'placa': ordem_servico['placa'],
          'situacao': ordem_servico['situacao'],
          'estampadora_id': ordem_servico['estampadora_id'],
          'marca_modelo': ordem_servico['marca_modelo'],
        };
        // for (var documentos in ordem_servico['documento_ordem_servicos']) {
        //   var body_documento_ordem_servico = {
        //     'id': documentos['id'],
        //     'ordem_servico_id': ordem_servico['id'],
        //     'arquivo': documentos['arquivo'],
        //     'longitude': documentos['longitude'],
        //     'latitude': documentos['latitude'],
        //     'enviado_por': documentos['enviado_por'],
        //     'created_at': documentos['created_at'],
        //   };
        //   await txn.insert('documento_ordem_servicos', body_documento_ordem_servico, conflictAlgorithm: ConflictAlgorithm.replace);
        // }

        await txn.insert('ordem_servicos', body_ordem_servico, conflictAlgorithm: ConflictAlgorithm.replace);
      }
    });
  }

  Future<List<Map<String, dynamic>>> pesquisarOrdemServico(String placa) async{
    Map<String, String?>? estampadoraData = await SecureStorage.getEstampadoraData();
    String? estampadora_id = estampadoraData['estampadora_id'].toString();
    final db = await database;
    var resultado = await db.query(
      'ordem_servicos',
      where: 'estampadora_id = ? AND placa LIKE ?',
      whereArgs: [estampadora_id, '%$placa%'],
    );
    return resultado;
  }

  // Método para obter todas as ordens de serviço
  Future<List<Map<String, dynamic>>> getOrdemServico(String situacao) async {

    Map<String, String?>? estampadoraData = await SecureStorage.getEstampadoraData();
    String? estampadora_id = estampadoraData['estampadora_id'].toString();

    final db = await database;
    var resultado = await db.query(
      'ordem_servicos',
      where: 'estampadora_id = ? AND situacao = ?',
      whereArgs: [estampadora_id, situacao],
    );
    return resultado;
  }

  // Método para apagar todos os registros do banco de dados
  Future<void> limparDatabase() async {
    final db = await database;
    await db.delete('ordem_servicos');
  }

  // Método que informa a quantidade de OS no banco de dados
  Future<int> contarOrdemServicos() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM ordem_servicos');
    return Sqflite.firstIntValue(result) ?? 0;
  }

}
