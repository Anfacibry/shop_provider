import 'package:flutter/material.dart';

import '../components/grid_de_produtos.dart';

class TelaProdutos extends StatelessWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: const GridDeProdutos(),
    );
  }
}
