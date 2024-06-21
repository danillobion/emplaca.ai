import 'dart:ui';

class TradutorUtils {
  static String situacao(String situacao) {
    switch (situacao) {
      case 'ABE':
        return 'Aberta';
      case 'FIN':
        return 'Finalizada';
      case 'CAN':
        return 'Cancelada';
      default:
        return 'Desconhecida';
    }
  }
  static String documento(String documento) {
    if (documento.length == 11) {
      // formato CPF: XXX.XXX.XXX-XX
      return "${documento.substring(0, 3)}.${documento.substring(3, 6)}.${documento.substring(6, 9)}-${documento.substring(9, 11)}";
    } else if (documento.length == 14) {
      // formato CNPJ: XX.XXX.XXX/XXXX-XX
      return "${documento.substring(0, 2)}.${documento.substring(2, 5)}.${documento.substring(5, 8)}/${documento.substring(8, 12)}-${documento.substring(12, 14)}";
    } else {
      return documento;
    }
  }
  static String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
  static Map<String, String> tipoPlaca(String tipo_veiculo, String categoria_veiculo) {

    String tipo = "";
    String categoria = "";
    String cor = "";

    if(tipo_veiculo == "MOTOCICLETA" ||
        tipo_veiculo == "CICLOMOTOR" ||
        tipo_veiculo == "MOTONETA" ||
        tipo_veiculo == "TRICICLO" ||
        tipo_veiculo == "QUADRICICLO") {
      tipo = "moto";
    } else {
      tipo = "carro";
    }

    switch (categoria_veiculo) {
      case 'PARTICULAR':
        categoria = "particular";
        cor = "black";
        break;
      case 'OFICIAL':
        categoria = "oficial";
        cor = "blue";
        break;
      case 'ALUGUEL':
      case 'APRENDIZAGEM':
        categoria = "comercial";
        cor = "red";
        break;
      case 'EXPERIENCIA':
      case 'FABRICANTE':
        categoria = "especial";
        cor = "green";
        break;
      case 'COLECIONADOR':
        categoria = "colecionador";
        cor = "brown";
        break;
      case 'CORPO_CONSULAR':
      case 'ORGANISMOS_INTERNACIONAIS':
      case 'CHEFE_DE_MISSAO_DIPLOMATICA':
      case 'CORPO_DIPLOMATICO':
      case 'MISSAO_REPARTICAO_REPRESENTACAO':
      case 'AC_DE_COOPERACAO_INTERNACIONAL':
        categoria = "diplomata";
        cor = "orange";
        break;
      default:
        categoria = "particular";
        cor = "black";
        break;
    }

    return {
      "tipo": tipo,
      "categoria": categoria,
      "cor": cor,
    };
  }

}
