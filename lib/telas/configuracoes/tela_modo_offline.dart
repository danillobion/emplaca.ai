import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/configuracoes/tela_configuracoes.dart';
import 'package:jkgbrasil/telas/menu_barra.dart';
import '../../services/storage_service.dart';
import '../../services/database_service.dart';

// Tela
class TelaModoOffline extends StatefulWidget {
  @override
  _TelaModoOfflineState createState() => _TelaModoOfflineState();
}

class _TelaModoOfflineState extends State<TelaModoOffline> {
  bool _isOnline = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadModoOfflineState();
  }

  Future<void> _loadModoOfflineState() async {
    bool modoOffline = await SecureStorage.getModoOffline();
    setState(() {
      _isOnline = modoOffline;
    });
  }

  void _modoOffline() async{
    Map<String, String?>? modoOfflineData = await SecureStorage.toggleModoOffline();
    await DatabaseService().limparDatabase();
    String? modo_offline = modoOfflineData['modo_offline'].toString();
    _isOnline = modo_offline == "false"? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Offline'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TelaConfiguracoes()),
                  (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modo Offline', style: TextStyle(fontSize: 18)),
                    Text(
                      'Permite utilizar o aplicativo sem conexão',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Switch(
                  value: _isOnline,
                  onChanged: (value) {
                    setState(() {
                      _isOnline = value;
                      _modoOffline();
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}