import 'package:auth_demo/helpers/form-validators.dart';
import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

class RegVerifyPage extends StatefulWidget {
  final Widget child;

  RegVerifyPage({Key key, this.child}) : super(key: key);

  _RegVerifyPageState createState() => _RegVerifyPageState();
}

class _RegVerifyPageState extends State<RegVerifyPage> {
  final formKey = GlobalKey<FormState>();
  final _authSvc = AuthService();
  String _code;
  bool _isProcessing;

  void initState() {
    super.initState();
    _code = '';
    _isProcessing = false;
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      _isProcessing = true;
      print('Input verify code $_code');
    });

    await _authSvc.verifyEmail(_code).then((val) {
      print('email verification passed.');
      Navigator.pushNamed(context, 'reg-create', arguments: _code);
    }).catchError((err) {
      print('email verification error: $err');
    });
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _resend(String to) async {
    await _authSvc.sendRegEmail(to).then((val) {
      print('email sent.');
    }).catchError((err) {
      print('reg email error: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments as String;
    print('verifying email: $email');
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmation Code'),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onSaved: (value) {
                    this._code = value;
                  },
                  validator: FormValidators.notNull<String>(
                      'Please enter the code your received'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: RaisedButton(
                    child: !_isProcessing
                        ? Text('Continue')
                        : SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator()),
                    onPressed: !_isProcessing ? _submit : null,
                  ),
                ),
                FlatButton(
                  child: Text('Resend Email'),
                  textColor: Colors.black,
                  onPressed: () {
                    _resend(email);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
