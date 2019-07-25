import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {

    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("Criar Conta",
              style: TextStyle(
                fontSize: 15.0
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => SignupScreen()
                )
              );
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if(model.isLoading) {
            return Center(child: CircularProgressIndicator(),);
          }else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if(text.isEmpty || !text.contains("@")) return "E-mail inválido";
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (text) {
                      if(text.isEmpty || text.length < 6) return "Senha inválida";
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () {
                        if(_formKey.currentState.validate()) {

                        }
                        model.signIn();
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                            fontSize: 18.0
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
