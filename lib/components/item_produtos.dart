import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/notificacao_carrinho.dart';
import 'package:shop_provider/models/carrinho.dart';
import 'package:shop_provider/models/itens_carrinho.dart';
import 'package:shop_provider/models/produtos.dart';

import 'package:shop_provider/utils/rotas_app.dart';

class ItemProdutos extends StatelessWidget {
  final int indice;
  final String keyItemCarrinho;
  const ItemProdutos({
    Key? key,
    required this.indice,
    required this.keyItemCarrinho,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produtos produtos = Provider.of<Produtos>(context);
    final Carrinho carrinho = Provider.of<Carrinho>(context);
    final Map<String, ItemCarrinho> itens = carrinho.itensCarrinho;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Produtos>(
            builder: (cntx, produtos, child) => IconButton(
              onPressed: () {
                produtos.verificacaoFavorito();
              },
              icon: Icon(
                produtos.eFavorito ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          title: Text(
            produtos.titulo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: NotificacaoCarrinho(
            fun: () {
              carrinho.adicionandoItemCarrinho(produtos);
            },
            top: -6,
            right: 10,
            valor: itens.containsKey(keyItemCarrinho)
                ? itens[keyItemCarrinho]!.quantidade.toString()
                : "0",
            corDeFundo: Theme.of(context).colorScheme.secondary,
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(Icons.shopping_cart),
            ),
          ),

          // trailing: IconButton(
          //   onPressed: () {
          //     carrinho.adicionandoItemCarrinho(produtos);
          //   },
          //   icon: Icon(
          //     Icons.shopping_cart,
          //     color: Theme.of(context).colorScheme.secondary,
          //   ),
          // ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              RotasApp.rotaDetalhesProdutos,
              arguments: produtos,
            );
          },
          child: Image.network(
            produtos.imagemUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
