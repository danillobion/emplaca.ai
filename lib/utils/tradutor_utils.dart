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
}
