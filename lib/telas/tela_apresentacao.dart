import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/menu_barra.dart';
import 'package:jkgbrasil/telas/tela_login.dart';
import 'package:jkgbrasil/telas/tela_ordens_servicos.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';

class TelaApresentacao extends StatefulWidget{
  @override
  _TelaApresentacaoState createState() => _TelaApresentacaoState();
}

class _TelaApresentacaoState extends State<TelaApresentacao>{
  bool usuarioLogado = false; //supondo que o usuário está logado

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      _checkLogin();
    });
  }

  void _checkLogin(){
    if(usuarioLogado){ //pagina inicial
        //se não tiver uma estampadora carregada na session
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TelaSelecionarEstampadora()),);
        //se tiver uma estampadora carregada na session
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuBarra()),);
    }else{ // pagina de login
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