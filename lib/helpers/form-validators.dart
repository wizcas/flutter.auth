import 'package:flutter/material.dart';

class FormValidators {
  static FormFieldValidator<T> notNull<T>(String message) {
    return (T value) {
      if (value == null || (value is String && value.isEmpty)) {
        return message;
      }
    };
  }
}
