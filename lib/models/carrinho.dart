import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop_provider/models/itens_carrinho.dart';
import 'package:shop_provider/models/produtos.dart';

class Carrinho extends ChangeNotifier {
  final Map<String, ItemCarrinho> _itensCarrinho = {};

  Map<String, ItemCarrinho> get itensCarrinho => {..._itensCarrinho};

  int get tamanhoCarrinho => _itensCarrinho.length;

  double get valorTotal {
    double total = 0.0;
    _itensCarrinho.forEach((key, itemCarrinho) {
      total += itemCarrinho.preco * itemCarrinho.quantidade;
    });
    return total;
  }

  void adicionandoItemCarrinho(Produtos produto) {
    if (_itensCarrinho.containsKey(produto.id)) {
      _itensCarrinho.update(
        produto.id,
        (itemCarrinhoPego) => ItemCarrinho(
          id: itemCarrinhoPego.id,
          idProduto: itemCarrinhoPego.idProduto,
          produtoTitulo: itemCarrinhoPego.produtoTitulo,
          quantidade: itemCarrinhoPego.quantidade + 1,
          preco: itemCarrinhoPego.preco,
        ),
      );
    } else {
      _itensCarrinho.putIfAbsent(
        produto.id,
        () => ItemCarrinho(
          id: Random().nextInt(100).toString(),
          idProduto: produto.id,
          produtoTitulo: produto.titulo,
          quantidade: 1,
          preco: produto.preco,
        ),
      );
    }
    notifyListeners();
  }

  void removendoItemCarrinho(String idProduto) {
    _itensCarrinho.remove(idProduto);
    notifyListeners();
  }

  void limparCarrinho() {
    _itensCarrinho.clear();
    notifyListeners();
  }
}
