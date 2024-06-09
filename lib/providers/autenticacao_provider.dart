import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';

class AutenticacaoProvider with ChangeNotifier {
  bool _estaConectado = false;
  bool get estaConectado => _estaConectado;

  AutenticacaoProvider() {
    _init();
  }

  Future<void> _init() async {
    await _verificarConexao();
  }

  Future<void> _verificarConexao() async {
    var resultadoConexao = await Connectivity().checkConnectivity();
    _estaConectado = resultadoConexao == ConnectivityResult.mobile || resultadoConexao == ConnectivityResult.wifi;
    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String email, String senha) async {
    if (_estaConectado) {
      return await ApiService.login(email, senha);
    } else {
      throw Exception('Sem conexão de internet.');
    }
  }

  Future<Map<String, dynamic>> logout() async {
    //TODO: apagar token
    throw Exception('Apagar token');
  }

}
