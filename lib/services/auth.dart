import 'dart:convert';
import 'dart:io';

import 'package:auth_demo/services/jwt.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const URLs = {
    'login': 'http://www.mocky.io/v2/5caaf0ea300000dd1c9046fa',
    'regRequest': 'http://www.mocky.io/v2/5caaf12230000078179046fd'
  };
  static final AuthService _instance = new AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();

  Future sendRegEmail(String email) async {
    final httpResp =
        await http.post(URLs['regRequest'], body: {"email": email});
    final resp = ApiResponse.parse(httpResp);
    if (!resp.ok) {
      String err;
      switch (resp.subStatus) {
        case 1:
          err = 'Email address is already in use';
          break;
        case 2:
          err = 'Email address currently unavailable';
          break;
        default:
          err = 'Request failed (${resp.status})';
          break;
      }
      throw (err);
    }
  }

  Future<JWT> login(String username, String password) async {
    final basicToken = base64.encode(utf8.encode('$username:$password'));
    final httpResp = await http.get(URLs['login'], headers: {
      HttpHeaders.authorizationHeader: 'Basic $basicToken',
    });
    final resp = ApiResponse.parse(httpResp);
    if (!resp.ok) {
      throw ('Auth failed @ $username');
    }
    return JWT(resp['access_token']);
  }
}

class ApiResponse {
  final http.Response resp;
  final int status;
  final Map<String, dynamic> data;
  ApiResponse(this.status, this.data, this.resp);
  factory ApiResponse.parse(http.Response resp) {
    final rawData = json.decode(resp.body);
    return ApiResponse(rawData['status'] ?? resp.statusCode * 100,
        Map<String, dynamic>.from(rawData)..remove('status'), resp);
  }

  int get httpStatus => status ~/ 100;
  int get subStatus => status % 100;
  bool get ok => httpStatus >= 200 && httpStatus < 300;
  dynamic operator [](String key) {
    return data[key];
  }
}
