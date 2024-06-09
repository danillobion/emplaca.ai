import 'package:flutter/material.dart';
import '../../utils/tradutor_utils.dart';

// Tela
class TelaDetalhes extends StatelessWidget{
  final Map<String, dynamic> ordemServico;
  TelaDetalhes({required this.ordemServico});

  @override
  Widget build(BuildContext context){
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text(ordemServico['placa']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent, // Remove o divisor
                    expansionTileTheme: ExpansionTileThemeData(
                      tilePadding: EdgeInsets.zero, // Remove padding do título
                      childrenPadding: EdgeInsets.zero, // Remove padding dos filhos
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "Ordem de Serviço",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    initiallyExpanded: ordemServico['situacao'] != 'FIN',
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Identificador", style: boldTextStyle)),
                          Expanded(child: Text(ordemServico['id'].toString(), textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Status", style: boldTextStyle)),
                          Expanded(child: Text(TradutorUtils.situacao(ordemServico['situacao']), textAlign: TextAlign.right)),
                        ],
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent, // Remove o divisor
                    expansionTileTheme: ExpansionTileThemeData(
                      tilePadding: EdgeInsets.zero, // Remove padding do título
                      childrenPadding: EdgeInsets.zero, // Remove padding dos filhos
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "Veículo",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Placa",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['placa'] == null ? "Não informado" : ordemServico['placa'], textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Marca e modelo",style: boldTextStyle,)),
                          Expanded(child: Text(
                              ordemServico['marca_modelo'] == null ? "Não informado" : ordemServico['marca_modelo'],
                            textAlign: TextAlign.right,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Categoria",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['categoria'] == null ? "Não informado" : TradutorUtils.capitalizeEachWord(ordemServico['categoria']), textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Cor ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['cor'] == null ? "Não informado" : TradutorUtils.capitalizeEachWord(ordemServico['cor']), textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Chassi ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['chassi'] == null ? "Não informado" : ordemServico['chassi'], textAlign: TextAlign.right)),
                        ],
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent, // Remove o divisor
                    expansionTileTheme: ExpansionTileThemeData(
                      tilePadding: EdgeInsets.zero, // Remove padding do título
                      childrenPadding: EdgeInsets.zero, // Remove padding dos filhos
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "Proprietário",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Nome",style: boldTextStyle,)),
                          Expanded(child: Text(
                              ordemServico['proprietario'] == null || ordemServico['proprietario'].trim().isEmpty ? "Não informado" : TradutorUtils.capitalizeEachWord(ordemServico['proprietario']),
                              textAlign: TextAlign.right,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("CPF/CNPJ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['documentoProprietario'] == null || ordemServico['documentoProprietario'].trim().isEmpty ? "Não informado" : TradutorUtils.documento(ordemServico['documentoProprietario']), textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("E-mail",style: boldTextStyle,)),
                          Expanded(child: Text(
                              ordemServico['emailProprietario'] == null || ordemServico['emailProprietario'].trim().isEmpty ? "Não informado" : ordemServico['emailProprietario'],
                              textAlign: TextAlign.right,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Telefone ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['telefoneProprietario'] == null || ordemServico['telefoneProprietario'].trim().isEmpty ? "Não informado" : ordemServico['telefoneProprietario'], textAlign: TextAlign.right)),
                        ],
                      ),
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent, // Remove o divisor
                    expansionTileTheme: ExpansionTileThemeData(
                      tilePadding: EdgeInsets.zero, // Remove padding do título
                      childrenPadding: EdgeInsets.zero, // Remove padding dos filhos
                    ),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      "Responsável",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Nome",style: boldTextStyle,)),
                          Expanded(child: Text(
                              ordemServico['responsavel'] == null || ordemServico['responsavel'].trim().isEmpty ? "Não informado" : TradutorUtils.capitalizeEachWord(ordemServico['responsavel']),
                              textAlign: TextAlign.right,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("CPF/CNPJ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['documentoResponsavel'] == null || ordemServico['documentoResponsavel'].trim().isEmpty ? "Não informado" : TradutorUtils.documento(ordemServico['documentoResponsavel']), textAlign: TextAlign.right)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("E-mail",style: boldTextStyle,)),
                          Expanded(child: Text(
                              ordemServico['emailResponsavel'] == null || ordemServico['emailResponsavel'].trim().isEmpty ? "Não informado" : ordemServico['emailResponsavel']  ,
                              textAlign: TextAlign.right,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text("Telefone ",style: boldTextStyle,)),
                          Expanded(child: Text(ordemServico['telefoneResponsavel'] == null || ordemServico['telefoneResponsavel'].trim().isEmpty ? "Não informado" : ordemServico['telefoneResponsavel'], textAlign: TextAlign.right)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),

              ],
            )
          ],

        ),
      )
    );
  }
}
