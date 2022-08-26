import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/card_ordens.dart';
import 'package:shop_provider/components/drawer.dart';
import 'package:shop_provider/provider/lista_ordenada.dart';

class TelaOrdens extends StatelessWidget {
  const TelaOrdens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ListaOrdenada listaOrdenada = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus pedidos"),
        centerTitle: true,
      ),
      drawer: const IconeDrawer(),
      body: ListView.builder(
        itemCount: listaOrdenada.tamanhoListaOrdem,
        itemBuilder: (context, indice) => CardOrdens(
          ordem: listaOrdenada.itens[indice],
        ),
      ),
    );
  }
}
