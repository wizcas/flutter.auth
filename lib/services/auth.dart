import 'dart:convert';
import 'dart:io';

import 'package:auth_demo/services/jwt.dart';
import 'package:http/http.dart' as http;

class RegisterData {
  final String token;
  final String firstName;
  final String lastName;
  final String password;
  final String storeName;
  final String resellerId;
  final String phone;
  RegisterData(
      {this.token,
      this.firstName,
      this.lastName,
      this.password,
      this.storeName,
      this.resellerId,
      this.phone});
}

class AuthService {
  static const URLs = {
    'login': 'http://www.mocky.io/v2/5caaf0ea300000dd1c9046fa',
    'reg.request': 'http://www.mocky.io/v2/5caaf12230000078179046fd',
    'reg.verify': 'http://www.mocky.io/v2/5caaff013000007e1990477e',
    'reg.create': 'http://www.mocky.io/v2/5caaff503000005619904780',
  };
  static final AuthService _instance = new AuthService._internal();
  factory AuthService() {
    return _instance;
  }
  AuthService._internal();

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

  Future sendRegEmail(String email) async {
    final httpResp =
        await http.post(URLs['reg.request'], body: {"email": email});
    final resp = ApiResponse.parse(httpResp);
    if (!resp.ok) {
      String err;
      switch (resp.subStatus) {
        case 1:
          err = 'Email address is already in use';
          break;
        case 2:
          err = 'Email address is currently unavailable';
          break;
        default:
          err = 'Request failed (${resp.status})';
          break;
      }
      throw (err);
    }
  }

  Future verifyEmail(String token) async {
    final httpResp = await http.get(URLs['reg.verify'] + '?token=$token');
    final resp = ApiResponse.parse(httpResp);
    if (!resp.ok) {
      String err;
      switch (resp.subStatus) {
        case 1:
          err = 'Invalid identity';
          break;
        case 2:
          err = 'Email address is currently unavailable';
          break;
        default:
          err = 'Request failed (${resp.status})';
          break;
      }
      throw (err);
    }
  }

  Future<ApiResponse> register(RegisterData data) async {
    final httpResp = await http.post(URLs['reg.create'], body: data);
    final resp = ApiResponse.parse(httpResp);
    if (!resp.ok) {
      String err;
      switch (resp.subStatus) {
        case 1:
          err = 'Invalid identity';
          break;
        case 2:
          err = 'Email address is currently unavailable';
          break;
        default:
          err = 'Request failed (${resp.status})';
          break;
      }
      throw (err);
    }
    return resp;
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
