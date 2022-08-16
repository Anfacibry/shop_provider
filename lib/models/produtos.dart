import 'package:flutter/cupertino.dart';

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

  void verificacaoFavorito() {
    eFavorito = !eFavorito;
    notifyListeners();
  }
}
