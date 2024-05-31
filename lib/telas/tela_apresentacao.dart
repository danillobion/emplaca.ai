import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/menu_barra.dart';
import 'package:jkgbrasil/telas/tela_login.dart';
import 'package:jkgbrasil/telas/ordens_servico/tela_ordens_servicos.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';
import '../services/storage_service.dart';

class TelaApresentacao extends StatefulWidget{
  @override
  _TelaApresentacaoState createState() => _TelaApresentacaoState();
}

class _TelaApresentacaoState extends State<TelaApresentacao>{

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      _checkLogin();
    });
  }

  void _checkLogin() async {
    Map<String, String?> usuarioData = await SecureStorage.getUserData();
    bool existeEstampadora = await SecureStorage.getExisteEstampadora();
    if (usuarioData['id'] != null) {
      if (existeEstampadora) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuBarra()),);
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaSelecionarEstampadora()),);
      }
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaLogin()),);
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
     body: Center(
       child: Container(
         padding: EdgeInsets.all(20.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Image.asset("assets/logos/logo_emplaca_ai_vertical.png",width: 130),
           ],
         ),
       ),
     ),
    );

  }
}