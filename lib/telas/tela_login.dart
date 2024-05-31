import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jkgbrasil/services/api_service.dart';
import 'package:jkgbrasil/telas/tela_selecionar_estampadora.dart';
import '../services/storage_service.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/logos/logo_emplaca_ai_vertical.png", width: 130),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  hintText: 'Digite o seu e-mail',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite a sua senha',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              _isLoading
                  ? CircularProgressIndicator()
                  : Container(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                      _errorMessage = null;
                    });
                    try {
                      final response = await ApiService.login(
                        _emailController.text,
                        _senhaController.text,
                      );
                      await SecureStorage.saveUserData(
                        email: _emailController.text,
                        nome: response['user']['nome'].toString(),
                        cpf: response['user']['cpf'].toString(),
                        id: response['user']['id'].toString(),
                        token: response['token']['plainTextToken'].toString(),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TelaSelecionarEstampadora()),
                      );
                    } catch (e) {
                      setState(() {
                        _errorMessage = 'Erro ao fazer login';
                      });
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    backgroundColor: Colors.blue[400],
                  ),
                ),
              ),

              if (_errorMessage != null) ...[
                SizedBox(height: 10.0),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ],

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: 50.0,
                child: TextButton(
                  onPressed: () {
                    // Lógica para recuperar a senha
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
