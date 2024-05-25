import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage.dart';

class ApiService{
  static const String baseUrl = 'http://d.jkgbrasil.com.br/api/v2';

  static Future<Map<String,dynamic>> login(String email,String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/usuario/login'),
      body:{
        'email':email,
        'password':senha,
      },
    );
    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      throw Exception('Falha ao fazer login');
    }
  }

  static Future<Map<String, dynamic>> listarEstampadorasDoUsuario(String usuarioId) async {
    //pega o token
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
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao listar estampadoras do usuário');
    }
  }

  static Future<Map<String, dynamic>> listarOrdensServico(String estampadora_id, String situacao, String pagina) async {
      //pega o token
      Map<String, String?> userData = await SecureStorage.getUserData();
      String? token = userData['token'];

      final response = await http.get(
        Uri.parse('$baseUrl/ordens-servico?estampadora_id=$estampadora_id&situacao=$situacao&pagina=$pagina'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao listar as ordens de serviço');
      }
  }

  static Future<Map<String, dynamic>> pesquisarOrdensServico(String placa, String pagina) async {
    Map<String, String?>? estampadoraData = await SecureStorage.getEstampadoraData();
    if (estampadoraData != null && estampadoraData.containsKey('estampadora_id')) {
      //pega o token
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
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao pesquisar ordem de servico do usuário');
      }
    }
    throw Exception('Seu token de acesso expirou. Por favor, saia do seu aplicativo e entre novamente usando e-mail e senha.');
  }
}