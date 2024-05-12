import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/services/api_service.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';
import '../services/secure_storage.dart';

class TelaLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    String email = "";
    String senha = "";
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Image.asset("assets/logos/logo_emplaca_ai_vertical.png",width: 130),

              SizedBox(height: 20.0),

              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite o seu e-mail',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              TextFormField(
                onChanged: (value) {
                  senha = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              Container(
                width: double.infinity,
                height: 50.0,
                child:FilledButton(
                  onPressed: () async{
                    try{
                      final response = await ApiService.login(email, senha);

                      await SecureStorage.saveUserData(
                        email: email,
                        nome: response['user']['nome'].toString(),
                        cpf: response['user']['cpf'].toString(),
                        id: response['user']['id'].toString(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TelaSelecionarEstampadora()), // Substitua "ProximaTela" pelo nome da próxima tela
                      );
                    }catch(e){
                      print('Erro ao fazer login: $e');
                    }
                  },
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    backgroundColor:Colors.blue[400],
                  ),
                ),
              ),

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: 50.0,
                child:TextButton(
                  onPressed: () {
                    // Lógica para entrar
                  },
                  child: Text(
                    'Esqueci a senha',
                    style: TextStyle(
                      color: Colors.blue[400],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}