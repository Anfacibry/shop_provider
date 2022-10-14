import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Autenticacao extends ChangeNotifier {
  static const String _urlRegistro =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCMmmL8xUpM4HF_Nc--vDckx4GJtCnQ8qE";
  Future<void> registroLogin({
    required String email,
    required String senha,
  }) async {
    final response = await http.post(
      Uri.parse(_urlRegistro),
      body: jsonEncode(
        {
          "email": email,
          "password": senha,
          "returnSecureToken": true,
        },
      ),
    );
    debugPrint(jsonDecode(response.body));
  }
}
