import 'package:flutter/material.dart';
import 'package:jkgbrasil/utils/tradutor_utils.dart';

class PlacaMercosul extends StatelessWidget {
  final String letras;
  final String numeros;
  final String tipoVeiculo;
  final String categoriaVeiculo;
  final String marcaModeloVeiculo;
  final double deslocamentoHorizontal;
  final double deslocamentoVertical;

  PlacaMercosul({
    required this.letras,
    required this.numeros,
    required this.tipoVeiculo,
    required this.categoriaVeiculo,
    required this.marcaModeloVeiculo,
    this.deslocamentoHorizontal = 30.0, // Valor padrão para moto
    this.deslocamentoVertical = 30.0, // Valor padrão para moto
  });

  @override
  Widget build(BuildContext context) {
    // Define os valores baseados no tipo
    var veiculo = TradutorUtils.tipoPlaca(tipoVeiculo, categoriaVeiculo);

    String imagePath = 'assets/images/placas/${veiculo['tipo']}_${veiculo['categoria']}.png';
    double imageWidth = (veiculo['tipo'] == "carro") ? 190 : 113;
    double horizontalOffset = (veiculo['tipo'] == "carro") ? 5.0 : 25.0;
    double verticalOffset = (veiculo['tipo'] == "carro") ? -14.0 : -6.0;

    Color color = _colorFromString(veiculo['cor'].toString());

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: veiculo['tipo'] == "carro" ? 1.0 : 35.0,
            right: veiculo['tipo'] == "carro" ? 0.0 : 38.0,
          ),
          child: Image.asset(
            imagePath,
            width: imageWidth,
            fit: BoxFit.cover,
          ),
        ),
        // Texto sobre a imagem
        Positioned(
          left: deslocamentoHorizontal + horizontalOffset,
          top: deslocamentoVertical + verticalOffset,
          child: (veiculo['tipo'] == "moto")
              ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$letras\n$numeros',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: color,
                  height: 1.1,
                  fontFamily: 'FE-FONT',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
              : Text(
            '$letras$numeros',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'FE-FONT',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Color _colorFromString(String colorString) {
    switch (colorString) {
      case 'black':
        return Colors.black;
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'brown':
        return Colors.brown;
      case 'orange':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
