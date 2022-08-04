import 'package:flutter/material.dart';
import 'package:shop_provider/components/item_produtos.dart';
import 'package:shop_provider/data/dados_produtos.dart';
import 'package:shop_provider/models/produtos.dart';

class TelaProdutos extends StatelessWidget {
  final List<Produtos> produtos = DadosDeProdutos().dadosProdutos;
  TelaProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: produtos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3 / 2,
        ),
        itemBuilder: (cxt, indice) => ItemProdutos(
          produtos: produtos[indice],
        ),
      ),
    );
  }
}
