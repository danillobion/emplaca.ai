import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';
import 'database_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  // static const String baseUrl = 'http://192.168.1.8:8080/api/v2'; // local
  static const String baseUrl = 'http://d.jkgbrasil.com.br/api/v2'; // local

  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario/login'),
      body: {
        'email': email,
        'password': senha,
      },
    );
    if (response.statusCode == 200) {
      await inicializarDatabase(); //inicializar o banco de dados quando logar
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao fazer login');
    }
  }

  static Future<Map<String, dynamic>> listarEstampadorasDoUsuario(String usuarioId) async {
    DatabaseService databaseService = DatabaseService();
    bool conectado = await estouConectado();
    if (conectado) {
      Map<String, String?> userData = await SecureStorage.getUserData();
      String? token = userData['token'];

      final response = await http.post(
        Uri.parse('$baseUrl/estampadoras'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'usuario_id': usuarioId,
        },
      );
      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        await databaseService.inserirEstampadoraEmLote(dadosJson['lista_perfis_usuario']); // Salva no banco de dados local
        return dadosJson;
      } else {
        throw Exception('Falha ao listar estampadoras do usuário');
      }
    } else {
      List<Map<String, dynamic>> dadosLocais = await databaseService.getEstampadoras();
      return {'lista_perfis_usuario': dadosLocais};
    }
  }

  static Future<Map<String, dynamic>> listarOrdensServico(String situacao, String pagina) async {
    DatabaseService databaseService = DatabaseService();
    bool modoOffline = await SecureStorage.getModoOffline();
    bool conectado = await estouConectado();
    Map<String, String?>? estampadoraData = await SecureStorage.getEstampadoraData();
    Map<String, String?> userData = await SecureStorage.getUserData();

    String? token = userData['token'];
    String? estampadora_id = estampadoraData['estampadora_id'].toString();
    if (conectado && estampadoraData != null && estampadoraData.containsKey('estampadora_id')) {
      final response = await http.get(
        Uri.parse('$baseUrl/ordens-servico?estampadora_id=$estampadora_id&situacao=$situacao&pagina=$pagina'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var dadosJson = json.decode(response.body);
        if(modoOffline){
          await databaseService.inserirOrdemServicosEmLote(dadosJson['ordens_servico']);
        }
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao listar as ordens de serviço');
      }
    }else{
      List<Map<String, dynamic>> dadosLocais = await databaseService.getOrdemServico(situacao);
      return {'ordens_servico': dadosLocais};
    }
  }

  static Future<Map<String, dynamic>> pesquisarOrdensServico(String placa, String pagina) async {
    bool conectado = await estouConectado();
    DatabaseService databaseService = DatabaseService();
    bool modoOffline = await SecureStorage.getModoOffline();
    Map<String, String?>? estampadoraData = await SecureStorage.getEstampadoraData();
    if (conectado) {
      if (estampadoraData != null && estampadoraData.containsKey('estampadora_id')) {
        Map<String, String?> userData = await SecureStorage.getUserData();
        String? token = userData['token'];
        String? estampadora_id = estampadoraData['estampadora_id'].toString();

        final response = await http.get(
            Uri.parse('$baseUrl/ordens-servico/pesquisar?estampadora_id=$estampadora_id&placa=$placa&pagina=$pagina'),
            headers: {
              'Authorization': 'Bearer $token',
            }
        );

        if (response.statusCode == 200) {
          var dadosJson = json.decode(response.body);
          if(modoOffline){
            await databaseService.inserirOrdemServicosEmLote(dadosJson['ordens_servico']);
          }
          return json.decode(response.body);
        } else {
          throw Exception('Falha ao pesquisar ordem de servico do usuário');
        }
      }
    }else{
      List<Map<String, dynamic>> ordensServico = await databaseService.pesquisarOrdemServico(placa);
      return {'ordens_servico': ordensServico};
    }

    throw Exception('Seu token de acesso expirou. Por favor, saia do seu aplicativo e entre novamente usando e-mail e senha.');
  }

  static Future<void> inicializarDatabase() async {
    DatabaseService databaseService = DatabaseService();
    await databaseService.database;
  }

  static Future<bool> estouConectado() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }
}
