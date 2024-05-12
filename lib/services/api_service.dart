import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{
  static const String baseUrl = 'http://d.jkgbrasil.com.br/api/v2';

  static Future<Map<String,dynamic>> login(String email,String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
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
}