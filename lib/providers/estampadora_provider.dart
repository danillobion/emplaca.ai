import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/database_service.dart';

class EstampadoraProvider with ChangeNotifier {
  bool _estaConectado = false;
  bool _modoOffline = false;

  bool get estaConectado => _estaConectado;
  bool get modoOffline => _modoOffline;

  EstampadoraProvider() {
    _init();
  }

  Future<void> _init() async {
    _estaConectado = await _verificarConexao();
    notifyListeners();
  }

  Future<bool> _verificarConexao() async {
    var resultadoConexao = await (Connectivity().checkConnectivity());
    return resultadoConexao == ConnectivityResult.mobile || resultadoConexao == ConnectivityResult.wifi;
  }

  Future<bool> _verificarModoOffline() async {
    return await SecureStorage.getModoOffline();
  }

  Future<Map<String, dynamic>> listar() async {
    bool estaConectado = await _verificarConexao();

    DatabaseService databaseService = DatabaseService();

    if (estaConectado) {
      var lista = await ApiService.listarEstampadorasDoUsuario();
      if (lista['estampadoras'] != null) {
        await databaseService.inserirEstampadoraEmLote(lista['estampadoras']);
        return lista;
      } else {
        return {'estampadoras': []};
      }
    } else {
      List<Map<String, dynamic>> dadosLocais = await databaseService.getEstampadoras();
      return {'estampadoras': dadosLocais ?? []};
    }
  }

}
