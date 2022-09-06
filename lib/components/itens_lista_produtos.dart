import 'package:flutter/material.dart';
import 'package:shop_provider/models/produtos.dart';

class ItensListaProdutos extends StatelessWidget {
  final Produtos produtos;
  const ItensListaProdutos({
    Key? key,
    required this.produtos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(produtos.titulo),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produtos.imagemUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
