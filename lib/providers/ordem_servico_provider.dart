import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/database_service.dart';

class OrdemServicoProvider with ChangeNotifier {
  bool _estaConectado = false;
  bool _modoOffline = false;

  bool get estaConectado => _estaConectado;
  bool get modoOffline => _modoOffline;

  OrdemServicoProvider() {
    _init();
  }

  Future<void> _init() async {
    _estaConectado = await _verificarConexao();
    _modoOffline = await _verificarModoOffline();
    notifyListeners();
  }

  Future<bool> _verificarConexao() async {
    var resultadoConexao = await (Connectivity().checkConnectivity());
    return resultadoConexao == ConnectivityResult.mobile || resultadoConexao == ConnectivityResult.wifi;
  }

  Future<bool> _verificarModoOffline() async {
    return await SecureStorage.getModoOffline();
  }

  Future<Map<String, dynamic>> listar(String situacao, String pagina) async {
    bool estaConectado = await _verificarConexao();
    bool modoOffline = await _verificarModoOffline();

    DatabaseService databaseService = DatabaseService();

    if (estaConectado) {
      var lista = await ApiService.listarOrdensServico(situacao, pagina);
      if (modoOffline) {
        await databaseService.inserirOrdemServicosEmLote(lista['ordens_servico']);
      }
      return lista;
    } else if (modoOffline) {
      List<Map<String, dynamic>> dadosLocais = await databaseService.getOrdemServico(situacao);
      return {'ordens_servico': dadosLocais};
    } else {
      throw Exception('Sem conexão de internet.');
    }
  }

  Future<Map<String, dynamic>> pesquisar(String placa, String pagina) async {
    bool estaConectado = await _verificarConexao();
    bool modoOffline = await _verificarModoOffline();

    DatabaseService databaseService = DatabaseService();

    if (estaConectado) {
      var lista = await ApiService.pesquisarOrdensServico(placa, pagina);
      if (modoOffline) {
        await databaseService.inserirOrdemServicosEmLote(lista['ordens_servico']);
      }
      return lista;
    } else if (modoOffline) {
      List<Map<String, dynamic>> dadosLocais = await databaseService.pesquisarOrdemServico(placa);
      return {'ordens_servico': dadosLocais};
    } else {
      throw Exception('Sem conexão de internet.');
    }

  }
}
