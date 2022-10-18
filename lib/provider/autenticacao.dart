import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_provider/exceptions/autentic_exceptions.dart';

class Autenticacao extends ChangeNotifier {
  Future<void> autenticando({
    required String email,
    required String senha,
    required String pedacoUrl,
  }) async {
    final String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$pedacoUrl?key=AIzaSyCMmmL8xUpM4HF_Nc--vDckx4GJtCnQ8qE";
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          "email": email,
          "password": senha,
          "returnSecureToken": true,
        },
      ),
    );
    final body = jsonDecode(response.body);
    if (body["error"] != null) {
      throw AutenticExceptions(key: body["error"]["message"]);
    }

    debugPrint(body.toString());
  }

  Future<void> registro({
    required String email,
    required String senha,
  }) async {
    return autenticando(email: email, senha: senha, pedacoUrl: "signUp");
  }

  Future<void> login({
    required String email,
    required String senha,
  }) async {
    return autenticando(
        email: email, senha: senha, pedacoUrl: "signInWithPassword");
  }
}
