import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_detalhe_ordem_servico.dart';

// Estrutura
class Item{
  final String serial;
  final String placa;
  final String modeloMarca;
  final VoidCallback onTap;

  Item(this.placa, this.serial, this.modeloMarca, {required this.onTap});
}

// Componente
class ItemDaLista extends StatelessWidget{
  final List<Item> items;

  ItemDaLista(this.items);

  @override
  Widget build(BuildContext context){
    return Column(
      children: items.map((item) {
        return ListTile(
          title: Text(item.placa),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.serial),
              Text(item.modeloMarca),
            ],
          ),
          onTap: item.onTap,
        );
      }).toList(),
    );
  }
}


class TelaOrdensServicos extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordens de Serviços'),
      ),
      body: Column(
        children: [
          ItemDaLista([
            Item("ABC0123","00000000001","Fiat, Marea", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TelaDetalheOrdemServico()));
            }),
            Item("ABC0456","00000000002","Fiat, Marea", onTap: () {}),
            Item("ABC0789","00000000003","Fiat, Marea", onTap: () {}),
          ]),
        ],
      ),
    );
  }
}
