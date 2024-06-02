import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/menu/tela_modo_offline.dart';
import 'package:jkgbrasil/telas/menu/tela_sobre.dart';

// Estrutura do componente
class Item {
  final String nome;
  final VoidCallback onTap;

  Item(this.nome, {required this.onTap});
}

// Componente
class ItemDaLista extends StatelessWidget {
  final List<Item> items;

  ItemDaLista(this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return ListTile(
          title: Text(item.nome),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFCCCCCC)),
          onTap: item.onTap,
        );
      }).toList(),
    );
  }
}

// Tela
class TelaMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          ItemDaLista([
            Item("Modo Offline", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaModoOffline()));
            }),
            // Item("Termos de Uso", onTap: () {}),
            // Item("Políticas de Privacidade", onTap: () {}),
            Item("Sobre", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaSobre()));
            }),
            Item("Sair do aplicativo", onTap: () {}),
          ]),
        ],
      ),
    );
  }
}
