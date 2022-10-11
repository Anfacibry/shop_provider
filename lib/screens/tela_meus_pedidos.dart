import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_provider/components/card_meus_pedidos.dart';
import 'package:shop_provider/components/drawer.dart';
import 'package:shop_provider/provider/lista_ordenada.dart';

class MeusPedidos extends StatelessWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  Future<void> carregandoPedidos(BuildContext context) async {
    return await Provider.of<ListaOrdenada>(
      context,
      listen: false,
    ).pegandoOrdem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus pedidos"),
        centerTitle: true,
      ),
      drawer: const IconeDrawer(),
      body: FutureBuilder(
        future: Provider.of<ListaOrdenada>(
          context,
          listen: false,
        ).pegandoOrdem(),
        builder: (contx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<ListaOrdenada>(
              builder: (contx, listaOrdenada, child) => RefreshIndicator(
                onRefresh: () => carregandoPedidos(context),
                child: ListView.builder(
                  itemCount: listaOrdenada.tamanhoListaOrdem,
                  itemBuilder: (context, indice) => CardMeusPedidos(
                    ordem: listaOrdenada.itens[indice],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
