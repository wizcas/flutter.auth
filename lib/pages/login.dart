import 'package:auth_demo/prefabs/intro/email.field.dart';
import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:flutter/material.dart';

class _LoginData {
  String email;
  String password;
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  FocusNode passwordFocus;
  _LoginData _data;
  bool _isProcessing;

  void initState() {
    super.initState();
    passwordFocus = FocusNode();
    _data = _LoginData();
    _isProcessing = false;
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      _isProcessing = true;
      print('Logging in with ${_data.email}:${_data.password}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FullScreenBg(
        child: Container(
          width: 300,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HomeLogo(),
                EmailFormField(
                  onFieldSubmitted: (String email) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                  onSaved: (String email) {
                    _data.email = email;
                  },
                ),
                _buildPasswordField(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    child: !_isProcessing
                        ? Text('Sign In')
                        : SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator()),
                    onPressed: !_isProcessing ? _submit : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      focusNode: passwordFocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(
          Icons.lock,
        ),
      ),
      validator: (String pwd) {
        if (pwd.isEmpty) {
          return 'Password is required.';
        }
      },
      onSaved: (String pwd) {
        _data.password = pwd;
      },
    );
  }

  TextStyle get _fieldTextStyle => TextStyle(color: Colors.black);
}
