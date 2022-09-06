import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/card_total_carrinho.dart';
import 'package:shop_provider/provider/carrinho.dart';
import 'package:shop_provider/models/itens_carrinho.dart';

class TelaCarrinho extends StatefulWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  State<TelaCarrinho> createState() => _TelaCarrinhoState();
}

class _TelaCarrinhoState extends State<TelaCarrinho> {
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
            child: Dismissible(
              key: ValueKey(itens[indice].id),
              onDismissed: (_) {
                carrinho.removendoItemCarrinho(itens[indice].idProduto);
              },
              confirmDismiss: (direction) => showDialog<bool>(
                  context: context,
                  builder: (contDialog) {
                    return AlertDialog(
                      title: const Text("Excluindo item do carrinho"),
                      content: const Text(
                          "Tem certeza que deseja excluir este item do carriho?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Não"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text("Sim"),
                        ),
                      ],
                    );
                  }),
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
                  trailing: SizedBox(
                    width: 80,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                carrinho.excluindoItemCarrinho(
                                    itens[indice].idProduto);
                              },
                              icon: const Icon(Icons.remove)),
                          Text(
                            "${itens[indice].quantidade}X",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                carrinho.atualizandoQuantidadeItemCarrinho(
                                    itemCarrinho: itens[indice]);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        "Produto adicionando com sucesso"),
                                    duration: const Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: "DESFAZER",
                                      onPressed: () {
                                        carrinho.excluindoItemCarrinho(
                                            itens[indice].idProduto);
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                    ),
                  ),
                ),
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
