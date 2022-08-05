import 'package:flutter/material.dart';
import 'package:shop_provider/data/dados_produtos.dart';
import 'package:shop_provider/models/produtos.dart';

class ListaProdutos extends ChangeNotifier {
  final List<Produtos> _itensProdutos = DadosDeProdutos().dadosProdutos;
  List<Produtos> get itensProdutos => [..._itensProdutos];

  void adicionandoProduto(Produtos produto) {
    itensProdutos.add(produto);
    notifyListeners();
  }
}