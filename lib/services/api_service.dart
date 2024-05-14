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
      Uri.parse('$baseUrl/usuario/estampadoras'),
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
}