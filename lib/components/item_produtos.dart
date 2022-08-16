import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/models/produtos.dart';

import 'package:shop_provider/utils/rotas_app.dart';

class ItemProdutos extends StatelessWidget {
  const ItemProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produtos produtos = Provider.of<Produtos>(context, listen: false);
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
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
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
