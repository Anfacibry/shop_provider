import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_provider/data/dados_produtos.dart';
import 'package:shop_provider/models/produtos.dart';
import "package:http/http.dart" as http;

class ListaProdutos extends ChangeNotifier {
  final String _url = "https://shop-provider-949c2-default-rtdb.firebaseio.com";
  final List<Produtos> _itensProdutos = DadosDeProdutos().dadosProdutos;
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

  Future<void> adicionandoProduto(Produtos produto) {
    ///Comando para fazer inserção de dados no servidor
    return http
        .post(Uri.parse("$_url/produtos.json"),
            body: jsonEncode(
              {
                "titulo": produto.titulo,
                "descricao": produto.descricao,
                "preco": produto.preco,
                "imagemUrl": produto.imagemUrl,
                "eFavorito": produto.eFavorito,
              },
            ))
        .then((respnse) {
      final String id = jsonDecode(respnse.body)["name"];

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
    });
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
