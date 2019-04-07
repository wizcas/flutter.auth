import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailFormField extends StatefulWidget {
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldSetter<String> onSaved;
  EmailFormField({Key key, this.onFieldSubmitted, this.onSaved})
      : super(key: key);

  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        labelText: 'Email Address',
        icon: Icon(
          Icons.email,
        ),
      ),
      validator: (String email) {
        if (email.isEmpty) {
          return 'Email is required';
        }
        if (!EmailValidator.validate(email)) {
          return 'Please enter a valid email address';
        }
      },
    );
  }
}
