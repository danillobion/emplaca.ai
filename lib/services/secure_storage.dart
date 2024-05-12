import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future<void> saveUserData({
    required String email,
    required String nome,
    required String cpf,
    required String id,
  }) async {
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'nome', value: nome);
    await _storage.write(key: 'cpf', value: cpf);
    await _storage.write(key: 'id', value: id);
  }

  static Future<void> saveEstampadoraData({
    required String estampadora_id,
    required String estampadora_nome,
  }) async {
    await _storage.write(key: 'estampadora_id', value: estampadora_id);
    await _storage.write(key: 'estampadora_nome', value: estampadora_nome);
  }

  static Future<Map<String, String?>> getUserData() async {
    final email = await _storage.read(key: 'email');
    final nome = await _storage.read(key: 'nome');
    final cpf = await _storage.read(key: 'cpf');
    final id = await _storage.read(key: 'id');

    return {
      'email': email,
      'nome': nome,
      'cpf': cpf,
      'id': id,
    };
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
    return estampadora_id != null;
  }

  static Future<void> deleteUserData() async {
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'nome');
    await _storage.delete(key: 'cpf');
    await _storage.delete(key: 'id');
  }
}

// Exemplo de uso:
// Para salvar os dados do usuário:
// await SecureStorage.saveUserData(
//   photoUrl: 'url_da_foto',
//   email: 'email_do_usuario',
//   nome: 'nome_do_usuario',
//   id: 'id_do_usuario',
// );

// Para recuperar os dados do usuário:
// Map<String, String?> userData = await SecureStorage.getUserData();

// Para excluir os dados do usuário:
// await SecureStorage.deleteUserData();
