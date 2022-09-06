import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/drawer.dart';
import 'package:shop_provider/components/itens_lista_produtos.dart';
import 'package:shop_provider/provider/lista_produtos.dart';
import 'package:shop_provider/utils/rotas_app.dart';

class TelaProdutos extends StatelessWidget {
  const TelaProdutos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListaProdutos produtos = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerencia de produtos"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RotasApp.rotaFormulario);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const IconeDrawer(),
      body: ListView.builder(
        itemCount: produtos.tamanhoListProdutos,
        itemBuilder: (contxtTelaProdutos, indice) => Column(
          children: [
            ItensListaProdutos(
              produtos: produtos.itensProdutos[indice],
            ),
            const Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
