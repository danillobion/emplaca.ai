import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/menu_barra.dart';
import 'package:jkgbrasil/telas/tela_login.dart';
import '../services/api_service.dart';
import '../services/secure_storage.dart';


// Estrutura do componente
class Item {
  final String nome;
  final String estado;
  final String sigla;
  final VoidCallback onTap;

  Item(this.nome,this.estado,this.sigla,{required this.onTap});
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
          title: Text(item.nome),
          subtitle: Text("${item.estado} - ${item.sigla} "),
          trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFCCCCCC)),
          onTap: item.onTap,
        );
      }).toList(),
    );
  }
}

// Tela
class TelaSelecionarEstampadora extends StatefulWidget {
  @override
  _TelaSelecionarEstampadoraState createState() => _TelaSelecionarEstampadoraState();
}

class _TelaSelecionarEstampadoraState extends State<TelaSelecionarEstampadora> {
  List<Item> _estampadorasItems = [];
  Map<String, dynamic> _listaEstampadoras = {};

  // Alert - confirmar logout
  Future<void> _confirmarLogout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar logout'),
          content: Text('Você deseja realmente sair do aplicativo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await SecureStorage.deleteUserData();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaLogin()),
                );
              },
              child: Text('Sair'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selecionarEstampadora(estampadora_id,estampadora_nome,estampadora_cnpj_formatado,estampadora_tipo_nome,estampadora_tipo) async {
    await SecureStorage.saveEstampadoraData(
        estampadora_id: estampadora_id,
        estampadora_nome: estampadora_nome,
        estampadora_cnpj_formatado: estampadora_cnpj_formatado,
        estampadora_tipo_nome: estampadora_tipo_nome,
        estampadora_tipo: estampadora_tipo,
    );
    Map<String, String?>? usuarioData = await SecureStorage.getUserData();

    if(usuarioData['estampadora_id'] != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuBarra()),);
    }

  }

  @override
  void initState() {
    super.initState();
    carregarEstampadoras();
  }


  void carregarEstampadoras() async {
    Map<String, String?>? usuarioData = await SecureStorage.getUserData();

    if (usuarioData != null && usuarioData.containsKey('id')) {
      ApiService.listarEstampadorasDoUsuario(usuarioData['id']!).then((listaEstampadoras) {
        setState(() {
          _estampadorasItems = listaEstampadoras['lista_perfis_usuario'].map<Item>((estampadora) {
            return Item(
              estampadora['nome'].toString(),
              estampadora['estado'].toString(),
              estampadora['sigla'].toString(),
              onTap: () {
                _selecionarEstampadora(
                    estampadora['id'].toString(),
                    estampadora['nome'].toString(),
                    estampadora['cnpj_formatado'].toString(),
                    estampadora['tipo_nome'].toString(),
                    estampadora['tipo'].toString()
                );
              },
            );
          }).toList();
        });
      }).catchError((error) {
        print('Erro ao carregar as estampadoras: $error');
      });
    } else {
      print('Erro: Não foi possível obter o ID do usuário.');
    }
  }

  Future<void> _atualizarLista() async {
    carregarEstampadoras();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione uma estampadora'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              _confirmarLogout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _atualizarLista,
        child: ListView(
          children: [
            ItemDaLista(_estampadorasItems),
          ],
        ),
      ),
    );
  }
}
