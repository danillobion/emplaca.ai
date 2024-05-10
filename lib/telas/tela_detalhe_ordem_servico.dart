import 'package:flutter/material.dart';

// Tela
class TelaDetalheOrdemServico extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('ABC0123'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Placa", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text("Sérial dianteiro: ",style: boldTextStyle,)),
                    Expanded(child: Text("000000000001", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Sérial traseiro: ",style: boldTextStyle,)),
                    Expanded(child: Text("000000000001", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Placa: ",style: boldTextStyle,)),
                    Expanded(child: Text("ABC0123", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Cor da placa: ",style: boldTextStyle,)),
                    Expanded(child: Text("Azul", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Pacote: ",style: boldTextStyle,)),
                    Expanded(child: Text("Par de placas mercosul 3M", textAlign: TextAlign.right)),
                  ],
                ),
                SizedBox(height: 8),
                Text("Veículo", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text("Marca e modelo ",style: boldTextStyle,)),
                    Expanded(child: Text("Volkswagen - Gol", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Categoria ",style: boldTextStyle,)),
                    Expanded(child: Text("Particular", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Cor ",style: boldTextStyle,)),
                    Expanded(child: Text("Preto", textAlign: TextAlign.right)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text("Chassi ",style: boldTextStyle,)),
                    Expanded(child: Text("00122JJDASDASD100123", textAlign: TextAlign.right)),
                  ],
                ),
                SizedBox(height: 8),
                Text("Images", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: Text("Serial: ",style: boldTextStyle,)),
                    Expanded(child: Text("000000000001", textAlign: TextAlign.right)),
                  ],
                ),
              ],
            )
          ],

        ),
      )
    );
  }
}
