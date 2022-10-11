import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_provider/exceptions/http_exceptions.dart';
// import 'package:shop_provider/data/dados_produtos.dart';
import 'package:shop_provider/models/produtos.dart';
import "package:http/http.dart" as http;

import '../utils/constantes.dart';

class ListaProdutos extends ChangeNotifier {
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
    final response = await http.get(Uri.parse("${Urls.urlProdutos}.json"));
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
    final response = await http.post(Uri.parse("${Urls.urlProdutos}.json"),
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

  Future<void> atualizandoProduto(Produtos produto) async {
    int indice = _itensProdutos
        .indexWhere((produtoFiltrado) => produtoFiltrado.id == produto.id);
    if (indice >= 0) {
      await http.patch(Uri.parse("${Urls.urlProdutos}/${produto.id}.json"),
          body: jsonEncode(
            {
              "titulo": produto.titulo,
              "descricao": produto.descricao,
              "preco": produto.preco,
              "imagemUrl": produto.imagemUrl,
              "eFavorito": produto.eFavorito,
            },
          ));
      _itensProdutos[indice] = produto;
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> removendoProduto(Produtos produto) async {
    int indice = _itensProdutos
        .indexWhere((produtoFiltrado) => produtoFiltrado.id == produto.id);
    if (indice >= 0) {
      _itensProdutos
          .removeWhere(((produtoFiltrado) => produtoFiltrado.id == produto.id));
      notifyListeners();
      final response =
          await http.delete(Uri.parse("${Urls.urlProdutos}/${produto.id}"));
      if (response.statusCode >= 400) {
        _itensProdutos.insert(indice, produto);
        notifyListeners();
        throw HttpExceptions(
          mg: "Não foi possivel deletar o produto",
          statsCode: response.statusCode,
        );
      }
    }
  }
}
