import 'package:auth_demo/helpers/form-validators.dart';
import 'package:auth_demo/prefabs/intro/fullbg.dart';
import 'package:auth_demo/prefabs/intro/logo.home.dart';
import 'package:auth_demo/services/auth.dart';
import 'package:flutter/material.dart';

class RegCreatePage extends StatefulWidget {
  final Widget child;

  RegCreatePage({Key key, this.child}) : super(key: key);

  _RegCreatePageState createState() => _RegCreatePageState();
}

class _RegCreatePageState extends State<RegCreatePage> {
  final formKey = GlobalKey<FormState>();
  final _authSvc = AuthService();
  String _code;
  bool _isProcessing;
  RegisterData _registerData;

  void initState() {
    super.initState();
    _code = '';
    _isProcessing = false;
    _registerData = RegisterData();
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
    }).catchError((err) {
      print('email verification error: $err');
    });
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context).settings.arguments as String;
    print('register token: $token');
    return Scaffold(
      body: FullScreenBg(
        child: Container(
          width: 300,
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  HomeLogo(),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      this._code = value;
                    },
                    validator: FormValidators.notNull<String>(
                        'Please enter your first name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      this._code = value;
                    },
                    validator: FormValidators.notNull<String>(
                        'Please enter your last name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      this._code = value;
                    },
                    validator:
                        FormValidators.notNull<String>('Please set a password'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Store Name'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      this._code = value;
                    },
                    validator: FormValidators.notNull<String>(
                        'Please enter your store name'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Reseller ID',
                        hintText:
                            'Orders will be taken only if Reseller ID is valid'),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      this._code = value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: RaisedButton(
                      child: !_isProcessing
                          ? Text('Create Account')
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
      ),
    );
  }
}
