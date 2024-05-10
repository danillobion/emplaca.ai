import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_sobre.dart';

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
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          ItemDaLista([
            Item("Item A", onTap: () {}),
            Item("Item B", onTap: () {}),
            Item("Item C", onTap: () {}),
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
