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
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  MediaQuery.of(context).padding.top,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: _isFocused ? 80 : 100,
                  child: Image.asset("assets/logos/logo_cliente.png"),
                ),

                SizedBox(height: 50.0),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Digite o seu e-mail',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    setState(() {
                      _isFocused = true;
                    });
                  },
                  onFieldSubmitted: (_) {
                    setState(() {
                      _isFocused = false;
                    });
                  },
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
                  onTap: () {
                    setState(() {
                      _isFocused = true;
                    });
                  },
                  onFieldSubmitted: (_) {
                    setState(() {
                      _isFocused = false;
                    });
                  },
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
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text("Desenvolvido por:", style: TextStyle(color: Colors.grey[600]),),
                SizedBox(height: 10.0),
                Image.asset("assets/logos/logo_emplaca_ai_horizontal.png", width: 110),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
