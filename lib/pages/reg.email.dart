import 'package:auth_demo/prefabs/intro/email.field.dart';
import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

class RegEmailPage extends StatefulWidget {
  final Widget child;

  RegEmailPage({Key key, this.child}) : super(key: key);

  _RegEmailPageState createState() => _RegEmailPageState();
}

class _RegEmailPageState extends State<RegEmailPage> {
  final formKey = GlobalKey<FormState>();
  final _authSvc = AuthService();
  String _regEmail;
  bool _isProcessing;

  void initState() {
    super.initState();
    _isProcessing = false;
    _regEmail = '';
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      _isProcessing = true;
      print('Register email is sent to $_regEmail');
    });

    await _authSvc.sendRegEmail(_regEmail).then((val) {
      print('email sent.');
      Navigator.pushNamed(context, 'reg-verify', arguments: _regEmail);
    }).catchError((err) {
      print('reg email error: $err');
    });
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScreenBg(
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
                  onSaved: (String email) {
                    this._regEmail = email;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: RaisedButton(
                    child: !_isProcessing
                        ? Text('Sign Up')
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
}
