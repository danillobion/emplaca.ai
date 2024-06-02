import 'package:flutter/material.dart';
import 'package:jkgbrasil/services/storage_service.dart';
import 'package:jkgbrasil/telas/menu_barra.dart';
import 'package:jkgbrasil/telas/tela_login.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';

class TelaApresentacao extends StatefulWidget {
  @override
  _TelaApresentacaoState createState() => _TelaApresentacaoState();
}

class _TelaApresentacaoState extends State<TelaApresentacao> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  void _checkLogin() async {
    Map<String, String?> usuarioData = await SecureStorage.getUserData();
    bool existeEstampadora = await SecureStorage.getExisteEstampadora();
    if (usuarioData['id'] != null) {
      if (existeEstampadora) {
        _navigateTo(MenuBarra());
      } else {
        _navigateTo(TelaSelecionarEstampadora());
      }
    } else {
      _navigateTo(TelaLogin());
    }
  }

  void _navigateTo(Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/logos/logo_emplaca_ai_vertical.png", width: 130),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
