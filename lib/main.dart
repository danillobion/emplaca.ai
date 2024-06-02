import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/telas/tela_apresentacao.dart';

void main() {
  runApp(MeuAppJKGBrasil());
}

class MeuAppJKGBrasil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Splash Screen",
      theme: ThemeData(),
      home: TelaApresentacao(),
    );
  }
}
