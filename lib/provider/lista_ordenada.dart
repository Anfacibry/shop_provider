import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop_provider/models/ordem.dart';
import 'package:shop_provider/provider/carrinho.dart';

class ListaOrdenada extends ChangeNotifier {
  final List<Ordem> _itens = [];

  List<Ordem> get itens => [..._itens];

  int get tamanhoListaOrdem => _itens.length;

  void addOrdem(Carrinho carrinho) {
    _itens.insert(
      0,
      Ordem(
        id: Random().nextInt(100).toString(),
        total: carrinho.valorTotal,
        produtos: carrinho.itensCarrinho.values.toList(),
        data: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
