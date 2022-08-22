import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/card_total_carrinho.dart';
import 'package:shop_provider/models/carrinho.dart';
import 'package:shop_provider/models/itens_carrinho.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Carrinho carrinho = Provider.of(context);
    final List<ItemCarrinho> itens = carrinho.itensCarrinho.values.toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Carrinho"),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (contextListItensCarrinho, indice) {
          return Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Card(
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: FittedBox(
                      child: Text(
                        itens[indice].preco.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(itens[indice].produtoTitulo),
                subtitle: Text(
                    "Total: R\$${(itens[indice].preco * itens[indice].quantidade).toStringAsFixed(2)}"),
                trailing: Text("${itens[indice].quantidade}X"),
              ),
            ),
          );
        },
      ),
      floatingActionButton: const CardTotalCarrinho(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
