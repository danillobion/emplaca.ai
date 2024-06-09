import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jkgbrasil/telas/ordens_servico/tela_detalhes.dart';
import 'package:jkgbrasil/telas/ordens_servico/tela_pesquisar.dart';
import '../../providers/ordem_servico_provider.dart';

// Estrutura
class Item {
  final String placa;
  final String situacao;
  final VoidCallback onTap;

  Item(this.placa, this.situacao, {required this.onTap});
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
          title: Text(item.placa),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.situacao),
            ],
          ),
          onTap: item.onTap,
        );
      }).toList(),
    );
  }
}

class TelaOrdensServico extends StatefulWidget {
  @override
  _TelaOrdensServicos createState() => _TelaOrdensServicos();
}

class _TelaOrdensServicos extends State<TelaOrdensServico> {
  List<Item> _ordensServicoItems = [];
  String _filtro = "ABE";
  bool _isLoading = false;

  void _selecionarOrdemServico(ordemServico) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhes(
          ordemServico: ordemServico,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    carregarOrdensServico();
  }

  void carregarOrdensServico() async {
    setState(() {
      _isLoading = true;
    });

    final provider = Provider.of<OrdemServicoProvider>(context, listen: false);
    try {
      var listaOrdensServico = await provider.listar(_filtro, "1");
      if (!mounted) return;
      setState(() {
        _ordensServicoItems = listaOrdensServico['ordens_servico'].map<Item>((ordemServico) {
          return Item(
            ordemServico['placa'].toString(),
            ordemServico['situacao'].toString(),
            onTap: () {
              _selecionarOrdemServico(ordemServico);
            },
          );
        }).toList();
      });
    } catch (error) {
      _ordensServicoItems = [];
      print('Erro ao carregar as ordens de serviço: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _atualizarLista() async {
    carregarOrdensServico();
  }

  void _filtrar(String filtro) {
    setState(() {
      _filtro = filtro;
    });
    carregarOrdensServico();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ordens de Serviço'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaPesquisar()));
              },
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {},
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: 'Aberto'),
              Tab(text: 'Finalizado'),
              Tab(text: 'Cancelado'),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  _filtrar("ABE"); // Aberto
                  break;
                case 1:
                  _filtrar("FIN"); // Finalizado
                  break;
                case 2:
                  _filtrar("CAN"); // Cancelado
                  break;
              }
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _atualizarLista,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
            children: [
              ItemDaLista(_ordensServicoItems),
            ],
          ),
        ),
      ),
    );
  }
}
