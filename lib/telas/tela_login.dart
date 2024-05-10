import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context){
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
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),


              Container(
                width: double.infinity,
                height: 50.0,
                child:FilledButton(
                  onPressed: () {
                    // Lógica para entrar
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
              TextButton(
                onPressed: () {},
                child: Text('Esqueci a senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}