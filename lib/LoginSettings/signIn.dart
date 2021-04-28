import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Pages/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //GlobalKey possible replace with Key, UniqueKey

  Future<void> signIn() async {
    final _formState = _formKey.currentState;
    if (_formState.validate()) {
      _formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Row(
          children: <Widget>[
            Image(image: AssetImage('assets/images/cog_logo.png')),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // ignore: missing_return
                    TextFormField(
                      validator: (input) {
                        if (input.isEmpty) {
                          return 'Please type in email';
                        }
                      },
                      onSaved: (input) => _email = input,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Please type in password';
                        }
                      },
                      onSaved: (input) => _password = input,
                      decoration: InputDecoration(
                        labelText: 'password',
                      ),
                      obscureText: true,
                    ),
                    RaisedButton(
                      onPressed: signIn,
                      child: Text('Sign In'),
                    ),
                  ],
                ))
          ],
        ));
  }
}
