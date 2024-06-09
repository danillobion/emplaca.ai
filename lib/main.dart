import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/providers/autenticacao_provider.dart';
import 'package:jkgbrasil/providers/estampadora_provider.dart';
import 'package:jkgbrasil/telas/tela_apresentacao.dart';
import 'package:provider/provider.dart';
import 'package:jkgbrasil/providers/ordem_servico_provider.dart';
void main() {
  runApp(MeuAppJKGBrasil());
}

class MeuAppJKGBrasil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrdemServicoProvider()),
        ChangeNotifierProvider(create: (_) => AutenticacaoProvider()),
        ChangeNotifierProvider(create: (_) => EstampadoraProvider()),
      ],
      child: MaterialApp(
        title: "Splash Screen",
        theme: ThemeData(),
        home: TelaApresentacao(),
      ),
    );
  }
}
