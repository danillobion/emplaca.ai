import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/api_service.dart';
import '../services/secure_storage.dart';

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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
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
      },
    );
  }
}

class TelaPesquisar extends StatefulWidget {
  @override
  _TelaPesquisar createState() => _TelaPesquisar();
}

class _TelaPesquisar extends State<TelaPesquisar> {
  List<Item> _ordens_servico = [];
  bool _isSearching = false;
  bool _hasSearched = false;
  String _placa = "";
  final TextEditingController _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _pesquisar() async {
    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    ApiService.pesquisarOrdensServico(_placa, "1").then((listaOrdensServico) {
      setState(() {
        _isSearching = false;
        _ordens_servico = (listaOrdensServico['ordens_servico'] as List).map((ordemServico) => Item(
          ordemServico['placa'].toString(),
          ordemServico['situacao'].toString(),
          onTap: () {},
        )).toList();
      });
    });
  }

  void _pesquisarPlaca(String placa) {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _placa = placa;
      });
      _pesquisar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisar'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textController,
                      maxLength: 7,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Ordem de Serviço',
                        hintText: 'Digite o número da placa',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Por favor, insira pelo menos 3 caracteres.';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pesquisarPlaca(_textController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide.none,
                      ),
                      padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    ),
                    child: Text('Pesquisar', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isSearching) {
      return Center(child: CircularProgressIndicator());
    } else if (!_hasSearched) {
      return Center(child: Text('Digite o número da placa.'));
    } else if (_ordens_servico.isEmpty) {
      return Center(child: Text('Nenhum resultado encontrado.'));
    } else {
      return ItemDaLista(_ordens_servico);
    }
  }
}

