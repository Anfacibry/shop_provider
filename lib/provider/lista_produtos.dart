import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:shop_provider/data/dados_produtos.dart';
import 'package:shop_provider/models/produtos.dart';
import "package:http/http.dart" as http;

class ListaProdutos extends ChangeNotifier {
  final String _url =
      "https://shop-provider-949c2-default-rtdb.firebaseio.com/produtos.json";
  final List<Produtos> _itensProdutos = [];
  List<Produtos> get itensProdutos => [..._itensProdutos];
  int get tamanhoListProdutos => _itensProdutos.length;
  List<Produtos> get produtosFavoritos =>
      _itensProdutos.where((element) => element.eFavorito).toList();

  Future<void> addProdutoFormulario(Map<String, dynamic> dadosForm) {
    bool temId = dadosForm["id"] != null;
    final Produtos novoProduto = Produtos(
        id: temId ? dadosForm["id"] : Random().nextDouble().toString(),
        titulo: dadosForm["titulo"],
        descricao: dadosForm["descricao"],
        preco: dadosForm["preco"],
        imagemUrl: dadosForm["imagemUrl"]);

    if (temId) {
      return atualizandoProduto(novoProduto);
    } else {
      return adicionandoProduto(novoProduto);
    }
  }

  Future<void> pegandoDados() async {
    _itensProdutos.clear();
    final response = await http.get(Uri.parse(_url));
    Map<String, dynamic> produtos = jsonDecode(response.body);
    produtos.forEach((key, value) {
      _itensProdutos.add(
        Produtos(
          id: key,
          titulo: value["titulo"],
          descricao: value["descricao"],
          preco: value["preco"],
          imagemUrl: value["imagemUrl"],
          eFavorito: value["eFavorito"],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> adicionandoProduto(Produtos produto) async {
    ///Comando para fazer inserção de dados no servidor
    final response = await http.post(Uri.parse(_url),
        body: jsonEncode(
          {
            "titulo": produto.titulo,
            "descricao": produto.descricao,
            "preco": produto.preco,
            "imagemUrl": produto.imagemUrl,
            "eFavorito": produto.eFavorito,
          },
        ));
    final String id = jsonDecode(response.body)["name"];

    _itensProdutos.add(
      Produtos(
        id: id,
        titulo: produto.titulo,
        descricao: produto.descricao,
        preco: produto.preco,
        imagemUrl: produto.imagemUrl,
        eFavorito: produto.eFavorito,
      ),
    );
    notifyListeners();
  }

  Future<void> atualizandoProduto(Produtos produto) {
    int indice = _itensProdutos
        .indexWhere((produtoFiltrado) => produtoFiltrado.id == produto.id);
    if (indice >= 0) {
      _itensProdutos[indice] = produto;
      notifyListeners();
    }
    return Future.value();
  }

  void removendoProduto(Produtos produto) {
    int indice = _itensProdutos
        .indexWhere((produtoFiltrado) => produtoFiltrado.id == produto.id);
    if (indice >= 0) {
      _itensProdutos
          .removeWhere(((produtoFiltrado) => produtoFiltrado.id == produto.id));
      notifyListeners();
    }
  }
}
