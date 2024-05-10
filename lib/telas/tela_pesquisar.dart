import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_sobre.dart';

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
class TelaPesquisar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
      ),
      body: Column(
        children: [
          ItemDaLista([
            Item("Ler Placa","Use apenas a câmera para ler a placa", onTap: () {}),
            Item("Ler QRCode","Use apenas a câmera para ler o QRCode", onTap: () {}),
            Item("Número do serial","Digite o serial para localizar a placa", onTap: () {}),
            Item("Número da placa","Digite o número da placa para localizar", onTap: () {}),
          ]),
        ],
      ),
    );
  }
}
