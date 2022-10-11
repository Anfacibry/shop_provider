import 'dart:convert';

import 'package:flutter/cupertino.dart';
import "package:http/http.dart" as http;

class Produtos extends ChangeNotifier {
  final String id;
  final String titulo;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool eFavorito;

  Produtos({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.eFavorito = false,
  });

  final String _urlProdutos =
      "https://shop-provider-949c2-default-rtdb.firebaseio.com/produtos";

  Future<void> verificacaoFavorito() async {
    eFavorito = !eFavorito;
    await http.patch(Uri.parse("$_urlProdutos/$id.json"),
        body: jsonEncode({
          "eFavorito": eFavorito,
        }));
    notifyListeners();
  }
}
