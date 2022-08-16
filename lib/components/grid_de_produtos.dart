import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lista_produtos.dart';
import '../models/produtos.dart';
import 'item_produtos.dart';

class GridDeProdutos extends StatelessWidget {
  final bool selecaoFavorito;
  const GridDeProdutos({
    required this.selecaoFavorito,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListaProdutos provide = Provider.of<ListaProdutos>(context);
    final List<Produtos> produtos =
        selecaoFavorito ? provide.produtosFavoritos : provide.itensProdutos;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: produtos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (cxt, indice) => ChangeNotifierProvider.value(
        value: produtos[indice],
        child: const ItemProdutos(),
      ),
    );
  }
}
