import 'package:auth_demo/prefabs/intro/email.field.dart';
import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:flutter/material.dart';

class RegEmailPage extends StatefulWidget {
  final Widget child;

  RegEmailPage({Key key, this.child}) : super(key: key);

  _RegEmailPageState createState() => _RegEmailPageState();
}

class _RegEmailPageState extends State<RegEmailPage> {
  final formKey = GlobalKey<FormState>();
  String _regEmail;
  bool _isProcessing;

  void initState() {
    super.initState();
    _isProcessing = false;
    _regEmail = '';
  }

  void _submit() {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      _isProcessing = true;
      print('Register email is sent to $_regEmail');
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
