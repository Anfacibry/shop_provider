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
          BotaoCarrinho(carrinho: carrinho),
        ],
      ),
    );
  }
}

class BotaoCarrinho extends StatefulWidget {
  const BotaoCarrinho({
    Key? key,
    required this.carrinho,
  }) : super(key: key);

  final Carrinho carrinho;

  @override
  State<BotaoCarrinho> createState() => _BotaoCarrinhoState();
}

bool _carregando = false;

class _BotaoCarrinhoState extends State<BotaoCarrinho> {
  @override
  Widget build(BuildContext context) {
    return _carregando
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: widget.carrinho.tamanhoCarrinho == 0
                ? null
                : () async {
                    setState(() {
                      _carregando = true;
                    });
                    await Provider.of<ListaOrdenada>(context, listen: false)
                        .addOrdem(widget.carrinho);
                    widget.carrinho.limparCarrinho();
                    setState(() {
                      _carregando = false;
                    });
                  },
            child: const Text("Comprar"),
          );
  }
}
