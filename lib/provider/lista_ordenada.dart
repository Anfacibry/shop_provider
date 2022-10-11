import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop_provider/models/itens_carrinho.dart';
import 'package:shop_provider/models/ordem.dart';
import 'package:shop_provider/provider/carrinho.dart';
import 'package:shop_provider/utils/constantes.dart';

class ListaOrdenada extends ChangeNotifier {
  final List<Ordem> _itens = [];

  List<Ordem> get itens => [..._itens];

  int get tamanhoListaOrdem => _itens.length;

  Future<void> pegandoOrdem() async {
    _itens.clear();
    final response = await http.get(Uri.parse("${Urls.urlOrdem}.json"));
    if (response.body == "null") return;
    Map<String, dynamic> produtos = jsonDecode(response.body);
    produtos.forEach((key, value) {
      List<dynamic> listaProdutos = value["produto"];
      _itens.add(
        Ordem(
          id: key,
          total: value["total"],
          produtos: listaProdutos
              .map((prod) => ItemCarrinho(
                    id: prod["id"],
                    idProduto: prod["idProduto"],
                    produtoTitulo: prod["produtoTitulo"],
                    quantidade: prod["quantidade"],
                    preco: prod["preco"],
                  ))
              .toList(),
          data: DateTime.parse(value["data"]),
        ),
      );
    });

    notifyListeners();
  }

  Future<void> addOrdem(Carrinho carrinho) async {
    final data = DateTime.now();
    final response = await http.post(
      Uri.parse("${Urls.urlOrdem}.json"),
      body: jsonEncode({
        "total": carrinho.valorTotal,
        "data": data.toIso8601String(),
        "produto": carrinho.itensCarrinho.values
            .map((itemCarrinho) => {
                  "id": itemCarrinho.id,
                  "idProduto": itemCarrinho.idProduto,
                  "produtoTitulo": itemCarrinho.produtoTitulo,
                  "quantidade": itemCarrinho.quantidade,
                  "preco": itemCarrinho.preco,
                })
            .toList(),
      }),
    );
    final String id = jsonDecode(response.body)["name"];
    _itens.insert(
      0,
      Ordem(
        id: id,
        total: carrinho.valorTotal,
        produtos: carrinho.itensCarrinho.values.toList(),
        data: data,
      ),
    );
    notifyListeners();
  }
}
