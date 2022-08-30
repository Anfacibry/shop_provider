import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/provider/lista_ordenada.dart';

import '../provider/carrinho.dart';

class CardTotalCarrinho extends StatelessWidget {
  const CardTotalCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Carrinho carrinho = Provider.of(context, listen: false);
    return Card(
      //margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 5, left: 5),
            child: Text("Total"),
          ),
          Consumer<Carrinho>(
            builder: (context, carrinho, child) => Chip(
              backgroundColor: Theme.of(context).colorScheme.primary,
              label: Text(
                "R\$${carrinho.valorTotal.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Provider.of<ListaOrdenada>(context, listen: false)
                  .addOrdem(carrinho);
              carrinho.limparCarrinho();
            },
            child: const Text("Comprar"),
          ),
        ],
      ),
    );
  }
}
