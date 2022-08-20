import 'package:flutter/material.dart';
import 'package:shop_provider/components/card_total_carrinho.dart';

class TelaCarrinho extends StatelessWidget {
  const TelaCarrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Carrinho"),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) => const Text("Quantidade"),
      ),
      floatingActionButton: const CardTotalCarrinho(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
