import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_favorito.dart';
import 'package:jkgbrasil/telas/tela_login.dart';
import 'package:jkgbrasil/telas/menu/tela_menu.dart';
import 'package:jkgbrasil/telas/ordens_servico/tela_ordens_servicos.dart';
import 'package:jkgbrasil/telas/ordens_servico/tela_pesquisar.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';
import '../services/storage_service.dart';
import '../services/database_service.dart';
import 'package:flutter/services.dart';

class MenuBarra extends StatefulWidget {
  @override
  _MenuBarraState createState() => _MenuBarraState();
}

class _MenuBarraState extends State<MenuBarra> {
  int _opcaoSelecionada = 0;

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
                await DatabaseService().limparDatabase();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            children:[
              Image.asset("assets/logos/logo_emplaca_ai_horizontal.png",width: 130),
            ]
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Adicione aqui a ação ao pressionar o ícone de notificações
            },
          ),
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: FutureBuilder<Map<String, String?>>(
                future: SecureStorage.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar dados do usuário');
                  } else {

                    String? nome_completo = snapshot.data?['nome'];
                    String? nome_usuario = nome_completo?.split(' ')[0] ?? 'Usuário';

                    String? estampadora_nome = snapshot.data?['estampadora_nome'];
                    String? estampadora_cnpj_formatado = snapshot.data?['cnpj_formatado'];
                    String? estampadora_tipo_nome = snapshot.data?['tipo_nome'];

                    return SingleChildScrollView(
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Olá, $nome_usuario!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '$estampadora_nome',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$estampadora_cnpj_formatado',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '$estampadora_tipo_nome',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                        )
                      );
                  }
                },
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),



            ListTile(
              title: Text('Selecionar estampadora'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaSelecionarEstampadora()),
                );
              },
            ),
            ListTile(
              title: Text('Sair do aplicativo'),
              onTap: () {
                _confirmarLogout();
              },
            ),
            // Adicione mais itens de menu, se necessário
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _opcaoSelecionada,
        onTap: (opcao) {
          setState(() {
            _opcaoSelecionada = opcao;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Ordens de Serviço",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite_border),
          //   label: "Favorito",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Menu",
          ),
        ],
      ),
      body: IndexedStack(
        index: _opcaoSelecionada,
        children: <Widget>[
          TelaOrdensServicos(),
          // TelaFavorito(),
          TelaMenu(),
        ],
      ),
    );
  }
}
