import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveUserData({
    required String token,
    required String email,
    required String nome,
    required String cpf,
    required String id,
  }) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'nome', value: nome);
    await _storage.write(key: 'cpf', value: cpf);
    await _storage.write(key: 'id', value: id);
    await _storage.write(key: 'modo_offline', value: "true");
  }

  static Future<Map<String, String?>> getUserData() async {
    final estampadora_id = await _storage.read(key: 'estampadora_id');
    final estampadora_nome = await _storage.read(key: 'estampadora_nome');
    final estampadora_cnpj_formatado = await _storage.read(key: 'estampadora_cnpj_formatado');
    final estampadora_tipo_nome = await _storage.read(key: 'estampadora_tipo_nome');
    final estampadora_tipo = await _storage.read(key: 'estampadora_tipo');
    final token = await _storage.read(key: 'token');
    final email = await _storage.read(key: 'email');
    final nome = await _storage.read(key: 'nome');
    final cpf = await _storage.read(key: 'cpf');
    final id = await _storage.read(key: 'id');

    return {
      'estampadora_id': estampadora_id,
      'estampadora_nome': estampadora_nome,
      'cnpj_formatado': estampadora_cnpj_formatado,
      'tipo_nome': estampadora_tipo_nome,
      'tipo': estampadora_tipo,
      'token': token,
      'email': email,
      'nome': nome,
      'cpf': cpf,
      'id': id,
    };
  }

  static Future<void> deleteUserData() async {
    //usuario logado
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'nome');
    await _storage.delete(key: 'cpf');
    await _storage.delete(key: 'id');
    await _storage.delete(key: 'modo_offline');
    //estampadora selecionada pelo usuario
    await _storage.delete(key: 'estampadora_id');
    await _storage.delete(key: 'estampadora_nome');
    await _storage.delete(key: 'estampadora_cnpj_formatado');
    await _storage.delete(key: 'estampadora_tipo_nome');
    await _storage.delete(key: 'estampadora_tipo');

  }

  static Future<void> saveEstampadoraData({
    required String estampadora_id,
    required String estampadora_nome,
    required String estampadora_cnpj_formatado,
    required String estampadora_tipo_nome,
    required String estampadora_tipo,
  }) async {
    await _storage.write(key: 'estampadora_id', value: estampadora_id);
    await _storage.write(key: 'estampadora_nome', value: estampadora_nome);
    await _storage.write(key: 'estampadora_cnpj_formatado', value: estampadora_cnpj_formatado);
    await _storage.write(key: 'estampadora_tipo_nome', value: estampadora_tipo_nome);
    await _storage.write(key: 'estampadora_tipo', value: estampadora_tipo);
  }

  static Future<Map<String, String?>> getEstampadoraData() async {
    final estampadora_id = await _storage.read(key: 'estampadora_id');
    final estampadora_nome = await _storage.read(key: 'estampadora_nome');

    return {
      'estampadora_id': estampadora_id,
      'estampadora_nome': estampadora_nome,
    };
  }

  static Future<bool> getExisteEstampadora() async {
    final estampadora_id = await _storage.read(key: 'estampadora_id');
    if(estampadora_id == null){
      return false;
    }else{
      return true;
    }
  }

  static Future<Map<String, String>> toggleModoOffline() async {
    final modoOffline = await _storage.read(key: 'modo_offline');
    final newModoOffline = (modoOffline == 'true') ? 'false' : 'true';
    await _storage.write(key: 'modo_offline', value: newModoOffline);
    return {'modo_offline': modoOffline ?? 'false'};
  }

  static Future<bool> getModoOffline() async{
    final modoOffline = await _storage.read(key: 'modo_offline');
    return modoOffline == 'false' ? true : false;
  }

}
