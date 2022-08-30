import 'package:flutter/material.dart';
import 'package:shop_provider/models/produtos.dart';

class DetalhesProdutos extends StatelessWidget {
  const DetalhesProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Produtos produtos =
        ModalRoute.of(context)!.settings.arguments as Produtos;
    final double altura = MediaQuery.of(context).size.height;
    final double largura = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(produtos.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: altura * .4,
              width: largura,
              child: Image.network(
                produtos.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              "R\$ ${produtos.preco.toString()}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            Text(
              "R\$ ${produtos.descricao}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
