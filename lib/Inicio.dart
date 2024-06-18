import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Correo Electrónico',
                ),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                child: Text('Iniciar Sesión'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              FlatButton(
                child: Text('¿No tienes una cuenta? Regístrate'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/register');
                },
              ),
              FlatButton(
                child: Text('¿Olvidaste tu contraseña?'),
                onPressed: () {
                  Navigator.pushNamed(context, '/reset-password');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
