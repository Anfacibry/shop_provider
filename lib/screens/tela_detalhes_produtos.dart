import 'package:flutter/material.dart';
import 'package:shop_provider/models/produtos.dart';

class DetalhesProdutos extends StatelessWidget {
  const DetalhesProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produtos produtos =
        ModalRoute.of(context)!.settings.arguments as Produtos;
    return Scaffold(
      appBar: AppBar(
        title: Text(produtos.titulo),
      ),
    );
  }
}
