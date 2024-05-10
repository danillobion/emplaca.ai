import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_menu.dart';
import 'package:jkgbrasil/telas/tela_ordens_servicos.dart';
import 'package:jkgbrasil/telas/tela_pesquisar.dart';

class MenuBarra extends StatefulWidget {
  @override
  _MenuBarraState createState() => _MenuBarraState();
}

class _MenuBarraState extends State<MenuBarra> {
  int _opcaoSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children:[
            Image.asset("assets/logos/logo_emplaca_ai_horizontal.png",width: 130),
          ]
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Adicione aqui a ação ao pressionar o ícone de configurações
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Adicione aqui a ação ao pressionar o ícone de notificações
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _opcaoSelecionada,
        onTap: (opcao) {
          setState(() {
            _opcaoSelecionada = opcao;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Ordens de Serv.",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pesquisar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
        ],
      ),
      body: IndexedStack(
        index: _opcaoSelecionada,
        children: <Widget>[
          TelaOrdensServicos(),
          TelaPesquisar(),
          TelaMenu(),
        ],
      ),
    );
  }
}
