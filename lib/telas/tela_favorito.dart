import 'package:flutter/material.dart';

// Estrutura do componente
class Item {
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  Item(this.titulo,this.subtitulo, {required this.onTap});
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
          title: Text(item.titulo),
          subtitle: Text(item.subtitulo),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFCCCCCC)),
          onTap: item.onTap,
        );
      }).toList(),
    );
  }
}

// Tela
class TelaFavorito extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorito'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ItemDaLista([
            Item("Ler Placa","Use apenas a câmera para ler a placa", onTap: () {}),
          ]),
        ],
      ),
    );
  }
}
