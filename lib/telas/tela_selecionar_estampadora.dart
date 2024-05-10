import 'package:flutter/material.dart';

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
class TelaSelecionarEstampadora extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione uma estampadora'),
      ),
      body: Column(
        children: [
          ItemDaLista([
            Item("Estampadora A", onTap: () {}),
            Item("Estampadora B", onTap: () {}),
            Item("Estampadora C", onTap: () {}),
            Item("Estampadora D", onTap: () {}),
            Item("Estampadora E", onTap: () {}),
            Item("Estampadora F", onTap: () {}),
          ],),
        ],
      ),
    );
  }
}
