import 'package:flutter/material.dart';
import 'package:shop_provider/models/produtos.dart';
import 'package:shop_provider/utils/rotas_app.dart';

class ItemProdutos extends StatelessWidget {
  final Produtos produtos;
  const ItemProdutos({required this.produtos, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.secondary,
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
